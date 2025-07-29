FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN python -m pip install -U pip wheel && \
    pip install -r requirements.txt

COPY service ./service

RUN useradd -m -r service && \
    chown -R service:service /app
USER service

ENV PORT 8000
EXPOSE $PORT

CMD ["gunicorn", "service:app", "--bind", "0.0.0.0:8000"]
