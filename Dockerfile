FROM amd64/python:3.8.16-slim as builder

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    gcc \
    git

FROM builder AS project_a

WORKDIR /project_a
COPY /project_a /project_a
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python", "project_a/main.py"]

FROM builder AS project_b
WORKDIR /project-b
COPY /project_b /project-b
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python", "project-b/main.py"]
