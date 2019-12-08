#!/bin/bash
# build and push docker images

set -euo pipefail

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

install_prereqs () {
  echo -e '\n<<< Installing trivy & (d)goss prerequisites >>>\n'
  # trivy (vuln scanner)
  TRIVY_VER=$(curl --silent "https://api.github.com/repos/aquasecurity/trivy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  export TRIVY_VER
  wget -q "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VER}/trivy_${TRIVY_VER}_Linux-64bit.tar.gz"
  tar -C "${HOME}/bin" -zxf "trivy_${TRIVY_VER}_Linux-64bit.tar.gz" trivy
  # goss/dgoss (server-spec for containers)
  export GOSS_VER=0.3.8
  curl -sL "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VER}/goss-linux-amd64" -o "${HOME}/bin/goss"
  curl -sL "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VER}/dgoss" -o "$HOME/bin/dgoss"
  # snyk (vuln scanner)
  SNYK_VER=$(curl --silent "https://api.github.com/repos/snyk/snyk/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  export SNYK_VER
  curl -sL "https://github.com/snyk/snyk/releases/download/v$SNYK_VER/snyk-linux" -o "$HOME/bin/snyk"
  chmod +rx "$HOME"/bin/{goss,dgoss,snyk}
}

vulnerability_scanner () {
  echo -e '\n<<< Checking image for vulnerabilities >>>\n'
  [[ "${IMAGE_NAME}" = latest ]] && trivy --clear-cache
  trivy --exit-code 0 --severity "UNKNOWN,LOW,MEDIUM,HIGH" --no-progress "${IMAGE_NAME}":"${IMAGE_TAG}"
  trivy --exit-code 1 --severity CRITICAL --no-progress "${IMAGE_NAME}":"${IMAGE_TAG}"
  snyk auth "${SNYK_TOKEN}"
  snyk monitor --docker "${IMAGE_NAME}":"${IMAGE_TAG}" --file=Dockerfile
}

test_images () {
  echo -e '\n<<< Testing default image >>>\n'
  export GOSS_SLEEP=5
  dgoss run -e PUID=1000 -e PGID=1000 "${IMAGE_NAME}":"${IMAGE_TAG}"
}

push_images () {
  echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin &> /dev/null
  echo -e '\n<<< Pushing default image >>>\n'
  docker push "${IMAGE_NAME}":"${IMAGE_TAG}"
}

build_images
install_prereqs
vulnerability_scanner
test_images
if [[ "${TRAVIS_PULL_REQUEST}" = false ]] && [[ "${TRAVIS_BRANCH}" =~ ^(dev|master)$ ]]; then
  push_images
fi
