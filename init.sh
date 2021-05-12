#!/bin/zsh

readonly ROOT_DIR=$(git rev-parse --show-toplevel)
# shellcheck disable=SC2164
cd "$ROOT_DIR"

# Install Homebrew
if ! which -s brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Docker desktop
# If install Docker with Homebrew, may not work.
if ! which -s docker; then
  wget 'https://desktop.docker.com/mac/stable/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -O Docker.dmg
  hdiutil attach Docker.dmg
  cp /Volumes/Docker/Docker.app /Applications/
  hdiutil detach /Volumes/Docker
  rm Docker.dmg
fi
open /Applications/Docker.app

# Install system utilities.
brew update
which -s curl || brew install curl
which -s wget || brew install wget
which -s helm || brew install helm

# Show next steps.
mkdir -p temp
cat init.txt
open init.txt