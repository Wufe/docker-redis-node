FROM phusion/baseimage

RUN rm -f /etc/service/sshd/down

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update && \
    apt-get install -y \
    wget gcc make

# Install & build Redis
RUN wget http://download.redis.io/releases/redis-3.2.8.tar.gz && \
    mkdir -p /opt/redis && \
    tar -zxvf redis-3.2.8.tar.gz -C /opt/redis && \
    cd /opt/redis/redis-3.2.8 && \
    make

# Links
RUN cd /opt/redis/redis-3.2.8/src && \
    ln -sf /opt/redis/redis-3.2.8/src/redis-cli /usr/bin/redis-cli && \
    ln -sf /opt/redis/redis-3.2.8/src/redis-server /usr/bin/redis-server && \
    ln -sf /opt/redis/redis-3.2.8/src/redis-sentinel /usr/bin/redis-sentinel && \
    cd .. && \
    mkdir -p /etc/redis/
    
COPY redis.conf /etc/redis/redis.conf

# Setting unsafe password: change asap
RUN echo root:toor | chpasswd

# Install service
RUN cd /etc/service && \
    mkdir redis && \
    cd redis

COPY run /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

EXPOSE 6379

CMD /sbin/my_init