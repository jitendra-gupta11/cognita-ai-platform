#!/bin/bash

set -e

BASE="helm/ai-service"

echo "Creating Helm chart..."

mkdir -p "$BASE/templates"

#############################################
# Chart.yaml
#############################################
cat > "$BASE/Chart.yaml" <<'EOF'
apiVersion: v2
name: ai-service
description: Cognita AI Service Helm Chart
type: application
version: 0.1.0
appVersion: "1.0.0"
EOF

#############################################
# values.yaml
#############################################
cat > "$BASE/values.yaml" <<'EOF'
replicaCount: 1

image:
  repository: cognitaacr.azurecr.io/ai-service
  tag: latest
  pullPolicy: IfNotPresent

serviceAccount:
  create: true
  name: ""

service:
  type: ClusterIP
  port: 80
  targetPort: 8000

ingress:
  enabled: true
  className: nginx

  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /

  hosts:
    - host: ""
      paths:
        - path: /
          pathType: Prefix

resources:
  requests:
    cpu: 100m
    memory: 128Mi

  limits:
    cpu: 500m
    memory: 512Mi

probes:
  liveness: /live
  readiness: /ready

config:
  LOG_LEVEL: INFO
EOF

#############################################
# .helmignore
#############################################
cat > "$BASE/.helmignore" <<'EOF'
.git/
.gitignore
README.md
EOF

#############################################
# _helpers.tpl
#############################################
cat > "$BASE/templates/_helpers.tpl" <<'EOF'
{{- define "ai-service.name" -}}
ai-service
{{- end }}

{{- define "ai-service.fullname" -}}
{{ include "ai-service.name" . }}
{{- end }}
EOF

#############################################
# serviceaccount.yaml
#############################################
cat > "$BASE/templates/serviceaccount.yaml" <<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "ai-service.fullname" . }}
EOF

#############################################
# deployment.yaml
#############################################
cat > "$BASE/templates/deployment.yaml" <<'EOF'
apiVersion: apps/v1
kind: Deployment

metadata:
  name: {{ include "ai-service.fullname" . }}

spec:
  replicas: {{ .Values.replicaCount }}

  selector:
    matchLabels:
      app: ai-service

  template:

    metadata:
      labels:
        app: ai-service

    spec:

      serviceAccountName: {{ include "ai-service.fullname" . }}

      containers:

      - name: ai-service

        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"

        imagePullPolicy: {{ .Values.image.pullPolicy }}

        ports:

        - containerPort: 8000

        env:

        - name: LOG_LEVEL
          value: "{{ .Values.config.LOG_LEVEL }}"

        resources:
{{ toYaml .Values.resources | indent 10 }}

        livenessProbe:

          httpGet:
            path: {{ .Values.probes.liveness }}
            port: 8000

          initialDelaySeconds: 10

          periodSeconds: 10

        readinessProbe:

          httpGet:
            path: {{ .Values.probes.readiness }}
            port: 8000

          initialDelaySeconds: 5

          periodSeconds: 5
EOF

#############################################
# service.yaml
#############################################
cat > "$BASE/templates/service.yaml" <<'EOF'
apiVersion: v1

kind: Service

metadata:
  name: {{ include "ai-service.fullname" . }}

spec:

  type: {{ .Values.service.type }}

  selector:
    app: ai-service

  ports:

  - port: {{ .Values.service.port }}

    targetPort: {{ .Values.service.targetPort }}
EOF

#############################################
# ingress.yaml
#############################################
cat > "$BASE/templates/ingress.yaml" <<'EOF'
{{- if .Values.ingress.enabled }}

apiVersion: networking.k8s.io/v1

kind: Ingress

metadata:

  name: ai-service

  annotations:
{{ toYaml .Values.ingress.annotations | indent 4 }}

spec:

  ingressClassName: {{ .Values.ingress.className }}

  rules:

  - http:

      paths:

      - path: /

        pathType: Prefix

        backend:

          service:

            name: {{ include "ai-service.fullname" . }}

            port:

              number: {{ .Values.service.port }}

{{- end }}
EOF

echo ""
echo "===================================="
echo "Helm chart created successfully"
echo "===================================="

find "$BASE"