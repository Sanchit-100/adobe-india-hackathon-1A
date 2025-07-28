# Use official Python image as base
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies for PyMuPDF and general utilities
RUN apt-get update && \
    apt-get install -y build-essential libglib2.0-0 libxrender1 libsm6 libxext6 && \
    pip install --no-cache-dir --upgrade pip

# Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the codebase
COPY . .

# Create output directory to avoid runtime issues
RUN mkdir -p /app/output

# Run the script
CMD ["python", "main.py"]
