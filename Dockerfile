FROM amd64/python:3.8.16-slim as builder

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    gcc \
    git

FROM builder AS project_a

WORKDIR /project-a
COPY /project-a /project-a
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python", "project-a/main.py"]