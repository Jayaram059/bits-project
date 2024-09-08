FROM  oraclelinux:9

ENV ACCEPT_EULA=Y

RUN yum clean metadata \
&& yum clean all \
&& yum install -y rsyslog.x86_64 procps gcc libgcc.x86_64 python3.9 python3-pip \
&& yum install -y tar yum-utils gcc-c++
COPY requirements.txt requirements.txt
RUN ls -l
RUN pip3 install -r requirements.txt
WORKDIR /functions
ADD func.py /functions/
ADD func.yaml /functions/
ENTRYPOINT [ "fdk", "/functions/func.py" ]

RUN echo "IAM ORACLE GUY...."