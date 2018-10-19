FROM lambci/lambda:build-python3.6

WORKDIR /var/task

RUN pip install --upgrade pip virtualenv pyflakes

RUN mkdir -p ./snowalert
RUN virtualenv ./snowalert/venv
COPY ./requirements.txt ./snowalert/requirements.txt
RUN PYTHONPATH='' ./snowalert/venv/bin/pip install -r ./snowalert/requirements.txt

COPY ./src ./snowalert/src
COPY ./run ./run
COPY ./install ./install

ENV PYTHONPATH="/var/task/snowalert/src:${PYTHONPATH}"
ENV PATH="/var/task/snowalert/venv/bin:${PATH}"

CMD ./run