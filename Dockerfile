FROM gliderlabs/alpine:3.4

RUN apk add --update python3 git libpq
RUN apk add --update wget ca-certificates python3-dev build-base libxml2-dev libxslt-dev libstdc++
RUN update-ca-certificates
RUN wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3
RUN python3 --version
RUN pip3 --version
RUN git clone http://github.com/openspending/os-fdp-adapters.git app
RUN cd app && pip3 install -r requirements.txt
RUN pip3 install gunicorn cchardet tabulator
RUN rm -rf /var/cache/apk/*

ADD docker/startup.sh /startup.sh

EXPOSE 8000

CMD  /startup.sh
