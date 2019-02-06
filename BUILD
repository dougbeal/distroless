package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_bundle")

container_bundle(
    name = "all",
    images = {
        "github.com/dougbeal/distolress/nonroot:debug": "//nonroot:debug"
    },
)

load("@io_bazel_rules_docker//contrib:push-all.bzl", "container_push")

container_push(
    name = "publish",
    bundle = ":all",
    format = "Docker",
    registry = "hub.docker.com",
    repository = "dougbeal/distolress",
    tag = "latest",
)
