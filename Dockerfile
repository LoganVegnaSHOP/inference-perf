FROM --platform=linux/amd64 python:3.12-slim

WORKDIR /workspace

# Copy dependency files and install (wheels only, no compilation)
COPY pyproject.toml ./
COPY inference_perf ./inference_perf
RUN pip install --no-cache-dir --only-binary :all: . 2>/dev/null || pip install --no-cache-dir . && pip cache purge

# Copy config and traces
COPY config.yml ./
COPY synthetic_traces ./synthetic_traces

ENV PYTHONPATH=/workspace

CMD ["python", "inference_perf/main.py", "--config_file", "config.yml"]
