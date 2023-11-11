FROM frolvlad/alpine-glibc
MAINTAINER Laurent Morel <hello@lmorel3.fr> 

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/calibre/lib
ENV PATH $PATH:/opt/calibre/bin
ENV CALIBRE_INSTALLER_SOURCE_CODE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py

EXPOSE 8080

RUN mkdir /library && mkdir /incoming

ADD docker/xvfb-run /bin/
ADD docker/test.mobi /tmp/
ADD docker/update-library.sh /
ADD docker/entrypoint.sh /

RUN apk update && \
    apk add \
# --upgrade \
    bash \
    ca-certificates \
    gcc \
    dcron \
    imagemagick \
    mesa-gl \
    python \
    qt5-qtbase-x11 \
    wget \
    xdg-utils \
    xvfb \
    xz \
    libxcomposite

RUN  wget -O- ${CALIBRE_INSTALLER_SOURCE_CODE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
     rm -rf /tmp/calibre-installer-cache

# Job for periodically adding new books
RUN mkdir /opt/crontabs
RUN echo '*  *  *  *  *    /update-library.sh' > /opt/crontabs/root

VOLUME        /library /incoming
ENTRYPOINT    ["sh", "entrypoint.sh"]
