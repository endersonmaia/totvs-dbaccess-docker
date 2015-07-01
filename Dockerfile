FROM tianon/centos:6.5

MAINTAINER Enderson Maia <endersonmaia@gmail.com>

RUN yum -y update \
    && yum -y install \
      http://yum.postgresql.org/9.3/redhat/rhel-6.5-x86_64/postgresql93-libs-9.3.9-1PGDG.rhel6.x86_64.rpm \
      http://yum.postgresql.org/9.3/redhat/rhel-6.5-x86_64/postgresql93-odbc-09.03.0300-1PGDG.rhel6.x86_64.rpm  \
      http://yum.postgresql.org/9.3/redhat/rhel-6.5-x86_64/postgresql93-odbc-debuginfo-09.03.0300-1PGDG.rhel6.x86_64.rpm \
      nc \
    && rm -rf /var/cache/yum/* \
    && yum clean all
                  
ADD 15-06-12-DBACCESS_LINUX64_20141119.TAR.GZ /opt/totvs/dbaccess

COPY /files/*.sh /
COPY /files/*.ini /tmp/

RUN /setup.sh

EXPOSE 7890

WORKDIR /opt/totvs/dbaccess/multi

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "dbaccess" ]
