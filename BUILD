package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_push")

container_push(
    name = "push_nonroot",
    format = "Docker",
    image = ":nonroot",
    registry = "hub.docker.com",
    repository = "dougbeal/distolress",
    tag = "latest",
)

# container_push(
#     name = "push_debug",
#     format = "Docker",
#     image = ":nonroot_debug",
#     registry = "hub.docker.com",
#     repository = "dougbeal/distolress",
#     tag = "latest",
# )

# container_push(
#     name = "push_static",
#     format = "Docker",
#     image = ":nonroot_static",
#     registry = "hub.docker.com",
#     repository = "dougbeal/distolress",
#     tag = "latest",
# )
