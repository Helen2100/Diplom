#!/bin/bash

docker run --detach \
  --hostname 158.160.87.198 \
  --publish 8443:443 --publish 8880:80 --publish 1522:22 \
  --name gitlab \
  --restart always \
  --volume /home/user/gitlab/config:/etc/gitlab \
  --volume /home/user/gitlab/logs:/var/log/gitlab \
  --volume /home/user/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
