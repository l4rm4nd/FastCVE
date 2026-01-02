# FastAPI + Pydantic v1.x stack is not compatible with Python 3.12.
# Keep Python 3.11 until upgrading FastAPI/Pydantic to a Python-3.12-compatible combination.
FROM python:3.11-slim

ARG APP_VERSION=notset

ENV FCDB_HOME=/fastcve \
    INP_ENV_NAME=${INP_ENV_NAME} \
    PYTHONPATH=/fastcve \
    PATH=/fastcve:$PATH \
    APP_VERSION=${APP_VERSION}

WORKDIR ${FCDB_HOME}

COPY ./src/config/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./src ${FCDB_HOME}

EXPOSE 8000

CMD ["uvicorn", "web.app:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
