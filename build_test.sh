#!/bin/bash
set -xe

# docker credential
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin


# Bazel build and test
bazel build --curses=no -s --verbose_explanations --verbose_failures //...
bazel test --curses=no --test_output=errors //...
for push in $(bazel query 'filter("push*", kind("rule", //...))')
do
    bazel run $push
done


