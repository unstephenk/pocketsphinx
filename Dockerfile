FROM python:latest

RUN apt-get update
RUN apt-get install -y wget \
gcc \
automake \
autoconf \
libtool \
bison \
swig \
pulseaudio \
libpulse-dev

COPY . /code
WORKDIR /code

# Untar SphinxBase
RUN tar -xvf sphinxbase-5prealpha.tar.gz

# Untar PocketSphinx
RUN tar -xvf pocketsphinx-5prealpha.tar.gz

# Build and Install SphinxBase
WORKDIR /code/sphinxbase-5prealpha
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

# Environment Variables
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# Build and Install PocketSphinx
WORKDIR /code/pocketsphinx-5prealpha
RUN  ./configure
RUN make clean all
RUN make check
RUN make install

CMD [ "pocketsphinx_continuous","-inmic","yes" ]

# docker run --name pocket --device /dev:/dev/xvdc pocketsphinx