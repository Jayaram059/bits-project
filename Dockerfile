FROM  oraclelinux:9

ENV ACCEPT_EULA=Y

RUN yum clean metadata \
&& yum clean all \
&& yum install -y rsyslog.x86_64 procps gcc libgcc.x86_64 python3.9 python3-pip \
&& yum install -y tar yum-utils gcc-c++

RUN pip3 install requirements.txt

RUN echo "IAM ORACLE GUY...."