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
