#!/bin/zsh

readonly ROOT_DIR=$(git rev-parse --show-toplevel)

# shellcheck disable=SC2164
cd "$ROOT_DIR"

# Install Homebrew
if ! which -s brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update

# Install Docker desktop
if ! which docker; then
  brew install wget
  wget 'https://desktop.docker.com/mac/stable/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -O Docker.dmg
  hdiutil attach Docker.dmg
  cp /Volumes/Docker/Docker.app /Applications/
  hdiutil detach /Volumes//Docker
fi

open /Applications/Docker.app