## Redis node docker image

Image built from [Sam Marsh's guide](http://www.everybodyhertz.co.uk/creating-a-distributed-redis-setup-using-docker/).

## Supported tags and respective `Dockerfile` links  
+ `latest` [(Dockerfile)](https://github.com/Wufe/docker-redis-node/blob/master/Dockerfile)

## How to
### Execute

**Simple start**
`docker run -d --name redis-node -p 6379:6379 kesshin/redis-node`

**Manual build**
`docker build -t redis-node .`  
`docker run -d --name redis-node redis-node`

### Important

Don't forget to **change root password**:  
+ enter the container `docker exec -it redis-node bash`
+ run passwd command `passwd`

### Configure

**SSH configuration**
SSH Root login is disabled by default.  
You can override default sshd configurations:  
`docker run -d --name redis-node -p 6379:6379 -v /path/to/my/sshd_config:/etc/ssh/sshd_config kesshin/redis-node`

**Redis configuration**  
Redis is set to automatically listen for connections from 0.0.0.0.  
If you want to use your own redis configuration, use:  
`docker run -d --name redis-node -p 6379:6379 -v /path/to/my/redis.conf:/etc/redis/redis.conf kesshin/redis-node`