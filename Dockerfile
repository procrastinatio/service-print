FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev && \
    pip install --upgrade pip setuptools wheel uwsgi

# We copy this file first to leverage docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

EXPOSE 5000

VOLUME /var/local/print


CMD ["uwsgi", "--http", ":5000", "--wsgi-file", "app.py", "--callable", "application", "--processes",  "2", "--threads", "4", "--logto", "/var/local/print/error.log"]

