FROM ubuntu:18.04
LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.bedtools="2.29.2" \
      source.bedtools="https://github.com/arq5x/bedtools2/releases/tag/v2.29.2" \
      version.htslib="1.10.2" \
      source.htslib="https://github.com/samtools/htslib/releases/tag/1.10.2"

ENV BEDTOOLS_VERSION=2.29.2
ENV HTSLIB_VERSION=1.10.2

RUN apt-get update -y \
    && apt-get install -y build-essential wget python python-pip zlib1g-dev libbz2-dev liblzma-dev

RUN cd /tmp \
    && wget https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 \
    && tar xvjf htslib-${HTSLIB_VERSION}.tar.bz2 \
    && cd htslib-${HTSLIB_VERSION} \
    && ./configure \
    && make \
    && make test \
    && make install \
    && rm -rf /tmp/htslib-${HTSLIB_VERSION}*

RUN cd /tmp \
    && wget https://github.com/arq5x/bedtools2/releases/download/v${BEDTOOLS_VERSION}/bedtools-${BEDTOOLS_VERSION}.tar.gz \
    && tar -zxvf bedtools-${BEDTOOLS_VERSION}.tar.gz \
    && cd bedtools2 \
    && make \
    && cp ./bin/bedtools /usr/bin/ \
    && rm -rf /tmp/bedtools*
