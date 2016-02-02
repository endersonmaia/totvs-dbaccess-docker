FROM centos:6

MAINTAINER Enderson Maia <endersonmaia@gmail.com>

RUN yum -y update \
    && yum -y install \
      http://yum.postgresql.org/9.3/redhat/rhel-6.5-x86_64/postgresql93-libs-9.3.9-1PGDG.rhel6.x86_64.rpm \
      http://yum.postgresql.org/9.3/redhat/rhel-6.5-x86_64/postgresql93-odbc-09.03.0300-1PGDG.rhel6.x86_64.rpm  \
      http://yum.postgresql.org/9.3/redhat/rhel-6.5-x86_64/postgresql93-odbc-debuginfo-09.03.0300-1PGDG.rhel6.x86_64.rpm \
      dejavu-lgc-sans-fonts\
      libexpat.i686 \
      libfreetype.i686  \
      libGL.i686  \
      libICE.i686 \
      libSM.i686  \
      libXcursor.i686 \
      libXext.i686  \
      libXft.i686 \
      libXinerama.i686  \
      libXmu.i686 \
      libXrandr.i686  \
      libXrender.i686 \
      mesa-libGL.i686 \
      nc \
    && rm -rf /var/cache/yum/* \
    && yum clean all

ADD 15-06-12-DBACCESS_LINUX64_20141119.TAR.GZ /opt/totvs/dbaccess

ADD /build /build
RUN /build/setup.sh

EXPOSE 7890

WORKDIR /opt/totvs/dbaccess/multi

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "dbaccess" ]
