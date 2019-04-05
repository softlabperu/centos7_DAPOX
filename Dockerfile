FROM centos:7

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

ADD oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm /tmp
ADD oracle-instantclient18.3-devel-18.3.0.0.0-1.x86_64.rpm /tmp

RUN  yum -y update && \
     yum -y install php-pecl-memcache php php-devel httpd gcc make libaio  && \
     yum -y localinstall /tmp/oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm \
                         /tmp/oracle-instantclient18.3-devel-18.3.0.0.0-1.x86_64.rpm && \
     yum -y autoremove && \
     yum -y clean all && \
     rm /tmp/oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm \
        /tmp/oracle-instantclient18.3-devel-18.3.0.0.0-1.x86_64.rpm

RUN echo 'instantclient,/usr/lib/oracle/18.3/client64/lib/' | pecl install oci8-2.0.12 && \
    echo 'extension=oci8.so' > /etc/php.d/oci8.ini

RUN yes | pecl install xdebug-2.4.1
