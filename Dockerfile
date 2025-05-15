# Stage 1: Build stage - To install dependencies using uv
FROM python:3.11-slim AS builder

# Install uv:
# 1. Install curl (needed to download the uv installer script).
# 2. Download and run the uv installer script.
# 3. Add uv to PATH (uv is installed to /root/.cargo/bin by default by the script).
# 4. Clean up apt packages to keep the layer small.

RUN apt-get update && \
    apt-get install -y curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*
ENV PATH="/home/runner/.cargo/bin:${PATH}"
WORKDIR /app

# Copy only requirements.txt to leverage Docker cache effectively.
# If requirements.txt doesn't change, this layer and subsequent dependency installation won't rerun.
COPY requirements.txt .

# Create a virtual environment using the Python version from the base image
# and install dependencies into it using uv add.
# uv should auto-detect and use the .venv in the current directory.
# --no-cache prevents caching of downloaded packages for this run.
#RUN uv venv .venv --seed --python $(which python3) && \
 #   uv add -r requirements.txt --no-cache
    # Note: This command will likely issue a warning if a pyproject.toml is not found,
    # stating that requirements will be added to the virtual environment but not to a pyproject.toml file.
    # This is expected in this context as we are using it primarily for installation here.
RUN /root/.cargo/bin/uv venv .venv --seed --python python3 && \
    /root/.cargo/bin/uv add -r requirements.txt --no-cache
# Stage 2: Final application stage
FROM python:3.11-slim

WORKDIR /app

# Copy the virtual environment (with installed packages) from the builder stage
COPY --from=builder /app/.venv .venv

# Copy the application code into the /app directory
COPY . .

# Set environment variables to use the created virtual environment.
# This ensures that 'python' in CMD refers to the Python interpreter in the venv.
ENV PATH="/app/.venv/bin:${PATH}"
ENV VIRTUAL_ENV="/app/.venv"
# Ensure Python doesn't buffer stdout/stderr, which is good for logging in containers.
ENV PYTHONUNBUFFERED=1

CMD ["python", "main.py"]
