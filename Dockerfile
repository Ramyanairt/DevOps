# Use a lightweight Python image
FROM python:3.11-slim

# Ensure logs are unbuffered (helpful for Cloud Run logs)
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Create and switch to a non-root user for better security
RUN useradd -m appuser
WORKDIR /app

# Install system deps only if needed; keeping minimal for this demo
# Copy dependency files first to leverage Docker layer caching
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py ./

# Switch to non-root user
USER appuser

# Cloud Run sends traffic to this port
ENV PORT=8080
EXPOSE 8080

# Start with Gunicorn (one worker is fine for demo; tune for prod)
CMD exec gunicorn --bind 0.0.0.0:${PORT} --workers 1 --threads 8 --timeout 0 app:app
