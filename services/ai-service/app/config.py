from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = "Cognita AI Service"
    version: str = "1.0.0"
    log_level: str = "INFO"

    class Config:
        env_file = ".env"


settings = Settings()
