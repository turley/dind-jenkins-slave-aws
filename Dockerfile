# Docker-in-Docker Jenkins Slave, with awscli and ecs-deploy

FROM tehranian/dind-jenkins-slave
MAINTAINER Ben Turley <code@benturley.com>

# Upgrade packages
RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

# Install awscli package and silinternational/ecs-deploy script for ECS deployment
RUN apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends \
        awscli \
        jq &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin &&\
    wget -O /usr/local/bin/ecs-deploy https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy &&\
    chmod +x /usr/local/bin/ecs-deploy
