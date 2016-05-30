# dind-jenkins-slave-aws

Automated build available on [Docker Hub](https://hub.docker.com/r/turley/dind-jenkins-slave-aws/).

This image is based on the [tehranian/dind-jenkins-slave](https://hub.docker.com/r/tehranian/dind-jenkins-slave/) docker image, with the addition of [AWS CLI](http://aws.amazon.com/documentation/cli/) and the [silinternational/ecs-deploy](https://github.com/silinternational/ecs-deploy) script.

The combination of these tools makes it relatively simple to build, test, push, and deploy (to Amazon ECS) from Jenkins.

## Requirements

As with [tehranian/dind-jenkins-slave](https://hub.docker.com/r/tehranian/dind-jenkins-slave/), you need to run with `--privileged` for nested docker to work.

## Usage

See the [parent instructions](https://github.com/tehranian/dind-jenkins-slave). Please note that using Docker-in-Docker for CI is [discouraged](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/) due to the need for the `--privileged` flag, along with some potential filesystem issues and inefficiencies.

In my own limited testing, I've found that building images with Docker-in-Docker works, but the aforementioned filesystem issues prevent the slave container from cleaning up temporary containers and images.

I've since opted to use sibling containers rather than child containers, as suggested by jpetazzo. In that case, it's still useful to have the docker CLI bundled into this Jenkins slave image (e.g., using the `-H` option to connect to another daemon socket) to eliminate the need for scripting to a docker client elsewhere.