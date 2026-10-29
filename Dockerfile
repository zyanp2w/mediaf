FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
# 1 worker + banyak thread agar batas rate & antrean job dipakai bersama
CMD ["sh", "-c", "gunicorn -w 1 --threads 8 -t 180 -b 0.0.0.0:${PORT:-5000} app:app"]
