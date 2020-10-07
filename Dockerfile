FROM ruby:latest

RUN apt-get update \
    && apt-get install -y python-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install s3cmd
