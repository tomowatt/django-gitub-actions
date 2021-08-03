FROM python:3.9-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --update --no-cache postgresql-dev=13.3-r0 gcc=10.3.1_git20210424-r2 python3-dev=3.9.5-r1 musl-dev=1.2.2-r3 tini=0.19.0-r0

WORKDIR /tmp
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY app/ .

ENTRYPOINT [ "tini", "--" ]

CMD [ "gunicorn", "app.wsgi:application", "--bind", "0.0.0.0:5000" ]
