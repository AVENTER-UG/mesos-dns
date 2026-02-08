#Dockerfile vars

#vars
PROJECTNAME=mesos-dns
DESCRIPTION=DNS Based service discovery for mesos 
UNAME_M=`uname -m`
IMAGENAME=${PROJECTNAME}
REPO=avhost
TAG=v0.9.4
BRANCH=`git rev-parse --abbrev-ref HEAD`
BUILDDATE=`date -u +%Y-%m-%dT%H:%M:%SZ`
LICENSE=Apache-2.0 license
VERSION_TU=$(subst -, ,$(TAG:v%=%))
BUILD_VERSION = $(word 1,$(VERSION_TU))
IMAGEFULLNAME=${REPO}/${IMAGENAME}
LASTCOMMIT=$(shell git log -1 --pretty=short | tail -n 1 | tr -d " " | tr -d "UPDATE:")
BUILDDATE=$(shell date -u +%Y%m%d)
BRANCH=$(shell git symbolic-ref --short HEAD | xargs basename)
BRANCHSHORT=$(shell echo ${BRANCH} | awk -F. '{ print $$1"."$$2 }')
DISTRO   := $(shell lsb_release -is | tr '[:upper:]' '[:lower:]')$(shell lsb_release -rs | tr -d .)
PKG_REL   = 1.$(DISTRO)

FPM_OPTS= -s dir -n $(PROJECTNAME) -v $(BUILD_VERSION) \
	--architecture $(UNAME_M) \
	--url "https://www.aventer.biz" \
	--license "$(LICENSE)" \
	--description "$(DESCRIPTION)" \
	--maintainer "AVENTER Support <support@aventer.biz>" \
	--vendor "AVENTER UG (haftungsbeschraenkt)" \
  --iteration $(PKG_REL)

CONTENTS= usr/bin etc usr/lib


ifeq (${BRANCH}, master) 
        BRANCH=latest
        BRANCHSHORT=latest
endif


build-bin:
	@echo ">>>> Build binary"
	@CGO_ENABLED=0 GOOS=linux go build -o build/$(PROJECTNAME) -a -installsuffix cgo -ldflags "-X main.BuildVersion=${BUILDDATE} -X main.GitVersion=${TAG} -extldflags \"-static\"" .

build-docker:
	@echo ">>>> Build Docker: latest"
	@docker build --build-arg TAG=${TAG} --build-arg BUILDDATE=${BUILDDATE} -t ${IMAGEFULLNAME}:latest .

push:
	@echo ">>>> Publish docker image: " ${BRANCH}
	@docker buildx create --use --name buildkit
	@docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=mode=max --push --build-arg TAG=${TAG} --build-arg BUILDDATE=${BUILDDATE} -t ${IMAGEFULLNAME}:latest .
	@docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=mode=max --push --build-arg TAG=${TAG} --build-arg BUILDDATE=${BUILDDATE} -t ${IMAGEFULLNAME}:${BRANCH} .
	@docker buildx build --platform linux/amd64,linux/arm64 --sbom=true --provenance=mode=max --push --build-arg TAG=${TAG} --build-arg BUILDDATE=${BUILDDATE} -t ${IMAGEFULLNAME}:${BRANCHSHORT} .
	@docker buildx rm buildkit

deb: build-bin
	@echo ">>>> Build DEB"
	@mkdir -p /tmp/toor/usr/bin
	@mkdir -p /tmp/toor/etc/$(PROJECTNAME)
	@mkdir -p /tmp/toor/usr/lib/systemd/system
	@cp build/$(PROJECTNAME) /tmp/toor/usr/bin
	@cp build/$(PROJECTNAME).service /tmp/toor/usr/lib/systemd/system
	@cp config.json.sample /tmp/toor/etc/$(PROJECTNAME)/config.json.sample
	@cp LICENSE /tmp/toor/license
	@fpm -t deb -C /tmp/toor/ --config-files etc $(FPM_OPTS) $(CONTENTS)

rpm: build-bin
	@echo ">>>> Build RPM"
	@mkdir -p /tmp/toor/usr/bin
	@mkdir -p /tmp/toor/etc/$(PROJECTNAME)
	@mkdir -p /tmp/toor/usr/lib/systemd/system
	@cp build/$(PROJECTNAME) /tmp/toor/usr/bin
	@cp build/$(PROJECTNAME).service /tmp/toor/usr/lib/systemd/system
	@cp config.json.sample /tmp/toor/etc/$(PROJECTNAME)/config.json.sample
	@cp LICENSE /tmp/toor/license
	@fpm -t rpm -C /tmp/toor/ --config-files etc $(FPM_OPTS) $(CONTENTS)

sboom:
	syft dir:. > sbom.txt
	syft dir:. -o json > sbom.json

seccheck:
	grype --add-cpes-if-none .

imagecheck:
	trivy image ${IMAGEFULLNAME}:latest

update-gomod:
	go get -u

test:
	go test ./resolver -run TestSortRRsByClientSubnet_A -v

check: sboom seccheck
all: check build-docker imagecheck
