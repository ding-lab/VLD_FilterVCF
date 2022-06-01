FROM python:3.7.13-buster
# Note that bullseye currently does not work on compute1

WORKDIR /opt

RUN pip install PyVCF argparse pysam ConfigParser
RUN apt-get update && apt-get install -y vim
ENV PYTHONPATH="/usr/local/lib/python3.7/site-packages:/opt/VLD_FilterVCF/src"

COPY docker/vimrc /root/.vimrc
COPY . /opt/VLD_FilterVCF

WORKDIR /opt/VLD_FilterVCF
