package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_push")

container_push(
    name = "push_nonroot",
    format = "Docker",
    image = "//nonroot:nonroot",
    registry = "index.docker.io",
    repository = "dougbeal/distolress",
    tag = "latest",
)

container_push(
    name = "push_debug",
    format = "Docker",
    image = "//nonroot:nonroot_debug",
    registry = "index.docker.io",
    repository = "dougbeal/distolress",
    tag = "debug",
)

container_push(
    name = "push_static",
    format = "Docker",
    image = "//nonroot:nonroot_static",
    registry = "index.docker.io",
    repository = "dougbeal/distolress",
    tag = "static",
)
