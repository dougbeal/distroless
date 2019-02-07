#!/bin/bash
set -xe

# docker credential
docker login -e '$(shell echo $$DOCKER_EMAIL)' -u '$(shell echo $$DOCKER_USER)' -p '$(shell echo $$DOCKER_PASS)'

# Bazel build and test
bazel build --curses=no -s --verbose_explanations --verbose_failures //...
bazel test --curses=no --test_output=errors //...
bazel run push_nonroot
bazel run push_debug
bazel run push_static
