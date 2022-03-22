#!/usr/bin/env bash

set -e

# environment
export WORKSPACE="./build"
export PATH="${PATH}:${GOPATH}/bin"
readonly PROJECT_DIR="."
readonly ARTIFACT_DIR="${WORKSPACE}/target"
readonly TEST_REPORTS="${WORKSPACE}/test_results"
export GO15VENDOREXPERIMENT=1

go version
go install github.com/kardianos/govendor

cd $PROJECT_DIR

go install github.com/mitchellh/gox
go get -u github.com/jstemmer/go-junit-report

go install ./...
go test -i ./...

gox -parallel=1 -arch=amd64 -os="linux darwin windows" \
  -output="${ARTIFACT_DIR}/{{.Dir}}-${PACKAGE_VERSION}-{{.OS}}-{{.Arch}}" \
  -ldflags="-X main.Version=${PACKAGE_VERSION}"

mkdir -p $TEST_REPORTS/junit && go test -v -timeout=10m ./... | \
  go-junit-report > $TEST_REPORTS/junit/alltests.xml

#go test -v -short -race -timeout=10m ./...
