FROM python:3.8

WORKDIR /usr/src/app

EXPOSE 5000
ADD requirements.txt ./
RUN pip install -r requirements.txt

ADD src/*.py ./

CMD [ "python", "./main.py" ]