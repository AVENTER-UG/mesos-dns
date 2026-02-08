#!/usr/bin/env bash

set -euo pipefail

export WORKSPACE="./build"
readonly PROJECT_DIR="."
readonly ARTIFACT_DIR="${WORKSPACE}/target"
readonly TEST_REPORTS="${WORKSPACE}/test_results"

go version

cd "$PROJECT_DIR"

mkdir -p "$TEST_REPORTS/junit"

go test -v -timeout=10m ./... | go-junit-report > "$TEST_REPORTS/junit/alltests.xml"
cat $TEST_REPORTS/junit/alltests.xml

