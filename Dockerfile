# Use official Python slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system deps required for Selenium
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        wget \
        unzip \
        chromium-driver \
        chromium && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements and install first (for better caching)
COPY requirements.txt .

# Create a virtual environment in the container
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy entire project
COPY . .

# Expose any port if your app runs a webserver (optional)
# EXPOSE 8000

# Default invocation
CMD ["python", "main.py"]
