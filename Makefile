#Dockerfile vars

#vars
PROJECTNAME=mesos-dns
TAG=`git describe`
BRANCH=`git rev-parse --abbrev-ref HEAD`
BUILDDATE=`date -u +%Y-%m-%dT%H:%M:%SZ`

.PHONY: help build all docs

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "all"
			@echo ${TAG}

.DEFAULT_GOAL := all

build:
	@echo ">>>> Build binary"
	@CGO_ENABLED=0 GOOS=linux go build -o build/$(PROJECTNAME) -a -installsuffix cgo -ldflags "-X main.BuildVersion=${BUILDDATE} -X main.GitVersion=${TAG} -extldflags \"-static\"" .

deb: build
	@mkdir -p ./$(PROJECTNAME)-deb/usr/bin/
	@mkdir -p ./$(PROJECTNAME)-deb/etc/$(PROJECTNAME)/
	@mkdir -p ./$(PROJECTNAME)-deb/DEBIAN
	@chmod 0755 ./$(PROJECTNAME)-deb/DEBIAN
	@cp build/mesos-dns ./$(PROJECTNAME)-deb/usr/bin/	
	@printf "Package: $(PROJECTNAME)\nMaintainer: AVENTER <support@aventer.biz>\nVersion: $(TAG)\nPriority: optional\nArchitecture: amd64\nSection: misc\nDepends: libc6\nDescription: DNS Based service discovery for mesos\n" > $(PROJECTNAME)-deb/DEBIAN/control
	@dpkg-deb --build $(PROJECTNAME)-deb .
	@rm -rf ./$(PROJECTNAME)-deb

rpm: build
	@mkdir -p ~/rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS,tmp}	
	@cp build/$(PROJECTNAME) ~/rpmbuild/BUILD/
	@cd build; rpmbuild --define '_smp_mflags -j3'  --define "VERSION $(TAG)" -bb $(PROJECTNAME).spec

all: build-bin build-deb build-rpm
