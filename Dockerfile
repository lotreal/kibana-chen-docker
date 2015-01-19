FROM centos:centos7

MAINTAINER Luo Tao <lotreal@gmail.com>

RUN yum update -y

RUN yum install -y git gcc make perl-core

RUN cd opt && \
    git clone https://github.com/lotreal/kibana-authorization.git && \
    cd kibana-authorization/kbnauth/ && \
    curl -L http://xrl.us/cpanm -o /usr/local/bin/cpanm && \
    chmod +x /usr/local/bin/cpanm && \
    cpanm Mojolicious Authen::Simple::Passwd


WORKDIR /opt/kibana-authorization/kbnauth

CMD ["hypnotoad", "-f", "script/kbnauth"]

EXPOSE 80
