FROM python:latest

RUN apt-get update
RUN apt-get install wget

COPY . /code
WORKDIR /code

# Download and unzip Sphinx4 Base
RUN wget https://versaweb.dl.sourceforge.net/project/cmusphinx/sphinx4/5prealpha/sphinx4-5prealpha-src.zip
RUN unzip sphinx4-5prealpha-src.zip
RUN cp -r sphinx4-5prealpha-src/* .
RUN rm -rf sphinx4-5prealpha-src

# Generate the "configure" file:
RUN ./autogen.sh

RUN  ./configure
RUN make clean all
RUN make check
RUN make install