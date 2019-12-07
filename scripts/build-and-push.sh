#!/bin/bash
# build and push docker images

set -eo pipefail

if [ "${TRAVIS_BRANCH}" = master ]; then
  IMAGE_TAG=latest
else
  IMAGE_TAG="${TRAVIS_BRANCH}"
fi

export IMAGE_TAG

build_images () {
  echo -e '\n<<< Building default image >>>\n'
  docker build -f Dockerfile -t "${IMAGE_NAME}":"${IMAGE_TAG}" .
}

test_images () {
  echo -e '\n<<< Testing default image >>>\n'
  export GOSS_SLEEP=5
  curl -sL https://github.com/aelsabbahy/goss/releases/download/v0.3.8/goss-linux-amd64 -o ~/bin/goss
  chmod +rx ~/bin/goss
  curl -sL https://github.com/aelsabbahy/goss/releases/download/v0.3.8/dgoss -o ~/bin/dgoss
  chmod +rx ~/bin/dgoss
  dgoss run -e PUID=1000 -e PGID=1000 "${IMAGE_NAME}":"${IMAGE_TAG}"
}

push_images () {
  echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin &> /dev/null
  echo -e '\n<<< Pushing default image >>>\n'
  docker push "${IMAGE_NAME}":"${IMAGE_TAG}"
}

build_images
test_images
if [[ "${TRAVIS_PULL_REQUEST}" = false ]] && [[ "${TRAVIS_BRANCH}" =~ ^(dev|master)$ ]]; then
  push_images
fi
