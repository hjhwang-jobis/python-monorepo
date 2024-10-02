FROM amd64/python:3.8.16-slim as builder

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    gcc \
    git

ENTRYPOINT ["python", "run.py"]