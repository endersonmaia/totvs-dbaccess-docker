FROM centos:7.3.1611

LABEL maintainer "Enderson Maia <endersonmaia@gmail.com>"

RUN yum -y update \
    && yum -y install \
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
      postgresql \
      postgresql-odbc \
      zlib.i686 \
    && rm -rf /var/cache/yum/* \
    && yum clean all

ADD 16-11-10-DBACCESS_LINUX64_20160402.TAR.GZ /totvs11/dbaccess64

COPY /build /build

RUN /build/setup.sh

EXPOSE 7890

WORKDIR /totvs11/dbaccess64/multi

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "dbaccess" ]
