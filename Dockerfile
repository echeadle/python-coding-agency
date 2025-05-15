# Use a slim Python image
FROM python:3.10-slim

# Install curl and system deps
RUN apt-get update && apt-get install -y curl

# Install uv (fast package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Ensure uv is in PATH
ENV PATH="/root/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy dependencies first (for Docker cache efficiency)
COPY requirements.txt .

# Install dependencies using uv
RUN uv pip install -r requirements.txt

# Copy the full project
COPY . .

# Set environment variable for src layout (optional, useful for uv pip run)
ENV PYTHONPATH="/app/src"

# Run the main app using uv's isolated env
CMD ["uv", "pip", "run", "python", "main.py"]
