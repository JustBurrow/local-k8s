#!/bin/zsh

set -euo pipefail

readonly ROOT_DIR=$(git rev-parse --show-toplevel)
# shellcheck disable=SC2164
cd "$ROOT_DIR"

mkdir -p volumes/jenkins/home
readonly URL_JENKINS="http://jenkins.local:10001"
readonly NEW_JENKINS=$(ls volumes/jenkins/home/ | wc -l | xargs)

docker compose up -d

#######################################################################################################################
#
# Wait Jenkins
#
#######################################################################################################################
echo -n "[Jenkins] Waiting ."
until [[ $(curl -s $URL_JENKINS) ]]; do
  sleep 1
  echo -n .
done
if [[ "0" == "$NEW_JENKINS" ]]; then
  until [[ -f volumes/jenkins/home/secrets/initialAdminPassword ]]; do
    sleep 1
    echo -n .
  done
  echo
  echo "[Jenkins] Administrator password : $(cat volumes/jenkins/home/secrets/initialAdminPassword)"
else
  echo
fi
open $URL_JENKINS