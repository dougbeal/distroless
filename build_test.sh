#!/bin/bash
set -xe

# docker credentials
echo """
{
	"ServerURL": "https://index.docker.io/v1",
	"Username": "${DOCKER_USERNAME}",
	"Secret": "${DOCKER_PASSWORD}"
}
""" > ./config.json
# Bazel build and test
bazel build --curses=no -s --verbose_explanations --verbose_failures //...
bazel test --curses=no --test_output=errors //...
bazel run push_nonroot
bazel run push_debug
bazel run push_static
