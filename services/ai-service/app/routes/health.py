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
