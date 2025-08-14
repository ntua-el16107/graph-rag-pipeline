FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV API_HOST=0.0.0.0 API_PORT=8000
CMD ["python", "src/app/main.py"]