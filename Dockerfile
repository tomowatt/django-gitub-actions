FROM python:3.9-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --update --no-cache postgresql-dev gcc python3-dev musl-dev tini

WORKDIR /tmp
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY app/ .

ENTRYPOINT [ "tini", "--" ]

CMD [ "gunicorn", "app.wsgi:application", "--bind", "0.0.0.0:5000" ]
