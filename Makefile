#Dockerfile vars

#vars
PROJECTNAME=mesos-dns
DESCRIPTION=DNS Based service discovery for mesos 
UNAME_M=`uname -m`
TAG=`git describe`
BRANCH=`git rev-parse --abbrev-ref HEAD`
BUILDDATE=`date -u +%Y-%m-%dT%H:%M:%SZ`
LICENSE=Apache-2.0 license

FPM_OPTS= -s dir -n $(PROJECTNAME) -v $(TAG) \
	--architecture $(UNAME_M) \
	--url "https://www.aventer.biz" \
	--license "$(LICENSE)" \
	--description "$(DESCRIPTION)" \
	--maintainer "AVENTER Support <support@aventer.biz>" \
	--vendor "AVENTER UG (haftungsbeschraenkt)"

CONTENTS= usr/bin etc usr/lib

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "all"
			@echo ${TAG}

.DEFAULT_GOAL := all

build-dns:
	@echo ">>>> Build binary"
	@CGO_ENABLED=0 GOOS=linux go build -o build/$(PROJECTNAME) -a -installsuffix cgo -ldflags "-X main.BuildVersion=${BUILDDATE} -X main.GitVersion=${TAG} -extldflags \"-static\"" .

deb: build-dns
	@echo ">>>> Build DEB"
	@mkdir -p /tmp/toor/usr/bin
	@mkdir -p /tmp/toor/etc/$(PROJECTNAME)
	@mkdir -p /tmp/toor/usr/lib/systemd/system
	@cp build/$(PROJECTNAME) /tmp/toor/usr/bin
	@cp build/$(PROJECTNAME).service /tmp/toor/usr/lib/systemd/system
	@cp config.json.sample /tmp/toor/etc/$(PROJECTNAME)/config.json.sample
	@cp LICENSE /tmp/toor/license
	@fpm -t deb -C /tmp/toor/ --config-files etc $(FPM_OPTS) $(CONTENTS)

rpm: build-dns
	@echo ">>>> Build RPM"
	@mkdir -p /tmp/toor/usr/bin
	@mkdir -p /tmp/toor/etc/$(PROJECTNAME)
	@mkdir -p /tmp/toor/usr/lib/systemd/system
	@cp build/$(PROJECTNAME) /tmp/toor/usr/bin
	@cp build/$(PROJECTNAME).service /tmp/toor/usr/lib/systemd/system
	@cp config.json.sample /tmp/toor/etc/$(PROJECTNAME)/config.json.sample
	@cp LICENSE /tmp/toor/license
	@fpm -t rpm -C /tmp/toor/ --config-files etc $(FPM_OPTS) $(CONTENTS)

all: build
