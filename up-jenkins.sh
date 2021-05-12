#!/bin/zsh

readonly ROOT_DIR=$(git rev-parse --show-toplevel)
# shellcheck disable=SC2164
cd "$ROOT_DIR"

readonly INITIALIZED=$(ls home/jenkins/ | wc -l | xargs)

mkdir -p home/jenkins

docker run -d --rm \
  --name=jenkins \
  --publish 8080:8080 \
  -v "$ROOT_DIR/home/jenkins:/var/jenkins_home" \
  jenkins/jenkins:lts-jdk11

if [[ "0" == "$INITIALIZED" ]]; then
  echo -n "Starting "
  until [[ $(curl -s localhost:8080) && -f home/jenkins/secrets/initialAdminPassword ]]; do
    sleep 1
    echo -n .
  done
  echo
  echo "Administrator password : $(cat home/jenkins/secrets/initialAdminPassword)"
fi

open http://localhost:8080