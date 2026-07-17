#!/bin/bash

set -e

echo "Creating Cognita AI Service..."

BASE="services/ai-service"

mkdir -p "$BASE/app/routes"
mkdir -p "$BASE/tests"

touch "$BASE/app/__init__.py"
touch "$BASE/app/routes/__init__.py"

########################################
# requirements.txt
########################################
cat > "$BASE/requirements.txt" <<'EOF'
fastapi==0.116.1
uvicorn[standard]==0.35.0
prometheus-fastapi-instrumentator==7.1.0
pydantic-settings==2.10.1
EOF

########################################
# config.py
########################################
cat > "$BASE/app/config.py" <<'EOF'
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = "Cognita AI Service"
    version: str = "1.0.0"
    log_level: str = "INFO"

    class Config:
        env_file = ".env"


settings = Settings()
EOF

########################################
# models.py
########################################
cat > "$BASE/app/models.py" <<'EOF'
from pydantic import BaseModel


class ChatRequest(BaseModel):
    message: str


class ChatResponse(BaseModel):
    answer: str
EOF

########################################
# health.py
########################################
cat > "$BASE/app/routes/health.py" <<'EOF'
from fastapi import APIRouter

router = APIRouter(tags=["Health"])


@router.get("/health")
def health():
    return {"status": "Healthy"}


@router.get("/ready")
def ready():
    return {"status": "Ready"}


@router.get("/live")
def live():
    return {"status": "Alive"}
EOF

########################################
# chat.py
########################################
cat > "$BASE/app/routes/chat.py" <<'EOF'
from fastapi import APIRouter
from app.models import ChatRequest, ChatResponse

router = APIRouter(tags=["Chat"])


@router.post("/chat", response_model=ChatResponse)
def chat(request: ChatRequest):
    return ChatResponse(
        answer=f"You said: {request.message}"
    )
EOF

########################################
# main.py
########################################
cat > "$BASE/app/main.py" <<'EOF'
from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

from app.config import settings
from app.routes.chat import router as chat_router
from app.routes.health import router as health_router

app = FastAPI(
    title=settings.app_name,
    version=settings.version,
)

Instrumentator().instrument(app).expose(app)

app.include_router(health_router)
app.include_router(chat_router)


@app.get("/")
def root():
    return {
        "service": settings.app_name,
        "version": settings.version,
    }
EOF

########################################
# Dockerfile
########################################
cat > "$BASE/Dockerfile" <<'EOF'
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app app

EXPOSE 8000

CMD [
    "uvicorn",
    "app.main:app",
    "--host",
    "0.0.0.0",
    "--port",
    "8000"
]
EOF

########################################
# .dockerignore
########################################
cat > "$BASE/.dockerignore" <<'EOF'
__pycache__/
*.pyc
*.pyo
*.pyd

.git
.venv
.env
EOF

########################################
# README.md
########################################
cat > "$BASE/README.md" <<'EOF'
# Cognita AI Service

Minimal AI workload used to validate the Cognita Platform.

## Endpoints

- /
- /health
- /ready
- /live
- /chat
- /metrics
EOF

echo ""
echo "========================================="
echo " Cognita AI Service scaffold created!"
echo "========================================="
echo ""

tree "$BASE" 2>/dev/null || find "$BASE"