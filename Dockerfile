FROM jbenet/go-ipfs:latest

MAINTAINER Chris Grimmett <chris@grimtech.net>

# install supervisor
RUN apt-get update && \
apt-get -y install supervisor

# add supervisor config & ipfs-website script
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ipfs-website.sh /usr/local/bin/ipfs-website

# set permissions on website script
RUN chmod 755 /usr/local/bin/ipfs-website


ENTRYPOINT ["/usr/local/bin/ipfs-website"]


