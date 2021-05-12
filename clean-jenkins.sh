#!/bin/zsh

readonly ROOT_DIR=$(git rev-parse --show-toplevel)

# shellcheck disable=SC2164
cd "$ROOT_DIR"

rm -rf home/jenkins/*
rm -rf home/jenkins/.*