#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

source ${path}/variaveis-locais-ambiente.sh

source /dev/stdin <<< "$(curl -s ${GIT_TEMPLATES_REPO}/variaveis-globais-ambiente.sh)"

docker pull ${IMAGE_GRADLE}

GRADLE_CACHE=${PWD}/bff/.gradle/cache
mkdir -p ${GRADLE_CACHE}

docker run -u ${JENKINS_UID} --rm -v ${PWD}/bff:/gradle -v ${PWD}/.git:/gradle/.git -v ${GRADLE_CACHE}:/gradle-home/caches -w /gradle ${IMAGE_GRADLE} gradle build publish --refresh-dependencies

docker build -t ${APP} ${PWD}/bff

docker tag ${APP} ${REGISTRY_HOST}/aplicacoes/${APP}:latest
docker tag ${APP} ${REGISTRY_HOST}/aplicacoes/${APP}:${GIT_HASH}
docker push ${REGISTRY_HOST}/aplicacoes/${APP}:latest
docker push ${REGISTRY_HOST}/aplicacoes/${APP}:${GIT_HASH}
