FROM centos:7.2.1511

MAINTAINER Enderson Maia <endersonmaia@gmail.com>

RUN yum -y update && rm -rf /var/cache/yum/* && yum clean all

RUN yum -y update \
    && yum -y install \
      postgresql postgresql-odbc \
      dejavu-lgc-sans-fonts\
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

ADD 16-03-15-DBACCESS_LINUX64_20141119.TAR.GZ /opt/totvs/dbaccess

ADD /build /build
RUN /build/setup.sh

EXPOSE 7890

WORKDIR /opt/totvs/dbaccess/multi

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "dbaccess" ]
