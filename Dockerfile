# Base image: Python 3.10 slim, explicitly targeting amd64 architecture
FROM --platform=linux/amd64 python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies for PyMuPDF (fitz)
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-0 \
    libxrender1 \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY app/ /app/

# Disable buffering
ENV PYTHONUNBUFFERED=1

# Default command to run the script
CMD ["python", "main.py"]
