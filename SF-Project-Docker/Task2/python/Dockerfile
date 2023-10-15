FROM python:3.9
MAINTAINER soroosh.mehmandoost@gmail.com

WORKDIR /app

COPY . /app

RUN pip3.9 install mysql-connector-python pandas tabulate

CMD ["python3.9", "./tw_app.sh"]
