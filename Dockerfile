FROM ubuntu:20.04

ENTRYPOINT []


LABEL maintainer="Sagar Budhathoki <sbmagar.sbm99@gmail.com>" \
      description="Image which consists of personal rasa-chatbot" \
      version="1.0"

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
# RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pip==21.0.1

RUN pip3 install --no-cache rasa==2.8.0

# RUN pip3 install -U spacy
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
# RUN python3 -m spacy download en_core_web_md

WORKDIR /app

# RUN apt-get install -y supervisor
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD . /app/
ADD ./actions /app/actions/
RUN pip install -r /app/actions/requirements-actions.txt
# CMD ["/usr/bin/supervisord"]

RUN chmod +x /app/scripts/*

CMD /app/scripts/start_services.sh