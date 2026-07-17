{{- define "ai-service.name" -}}
ai-service
{{- end }}

{{- define "ai-service.fullname" -}}
{{ include "ai-service.name" . }}
{{- end }}
