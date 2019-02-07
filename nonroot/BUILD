load("@distroless//:variables.bzl", "UID")
load("@distroless//:variables.bzl", "TAGS")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@io_bazel_rules_docker//container:container.bzl", "container_push")
load("@io_bazel_rules_go//go:def.bzl", "go_binary")

# Create a passwd file with a nonroot user and uid.
[passwd_entry(
    name = "user_nonroot_%d" % uid,
    gid = uid,
    info = "user_nonroot_%d" % uid,
    uid = uid,
    username = "user_nonroot_%d" % uid,
) for uid in UID]

[passwd_file(
    name = "passwd_%d" % uid,
    entries = [
        ":user_nonroot_%d" % uid,
    ],
) for uid in UID]

# Create /etc/group with the root group
[group_entry(
    name = "group_nonroot_%d" % uid,
    gid = uid,
    groupname = "group_nonroot_%d" % uid,
) for uid in UID]

[group_file(
    name = "group_%d" % uid,
    entries = [
        ":group_nonroot_%d" % uid,
    ],
) for uid in UID]

[pkg_tar(
    name = "passwd_tar_%d" % uid,
    srcs = [":passwd_%d" % uid],
    mode = "0644",
    package_dir = "etc",
) for uid in UID]

[pkg_tar(
    name = "group_tar_%d" % uid,
    srcs = [":group_%d" % uid],
    mode = "0644",
    package_dir = "etc",
) for uid in UID]

# Include it in our image as a tar.
[[container_image(
    name = "image_nonroot_%d_%s" % (uid, tag),
    base = "@distroless_base_image_%s//image" % tag,
    tars = [
        ":passwd_tar_%d" % uid,
        ":group_tar_%d" % uid,
    ],
    user = "user_nonroot_%d" % uid,
    visibility = ["//visibility:public"],
) for tag in TAGS] for uid in UID]

[[container_push(
    name = "push_nonroot_%s_uid%d" % (tag, uid),
    format = "Docker",
    image = "//nonroot:image_nonroot_%d_%s" % (uid, tag),
    registry = "index.docker.io",
    repository = "dougbeal/distroless",
    tag = "%d_%s" % (uid, tag),
) for tag in TAGS] for uid in UID]

# # Simple go program to print out the username and uid.
# go_binary(
#     name = "user",
#     srcs = ["testdata/user.go"],
#     pure = "on",
# )

# container_image(
#     name = "check_user_image",
#     base = ":nonroot",
#     files = [":user"],
#     visibility = ["//visibility:private"],
# )

# # Test to verify this works :)
# container_test(
#     name = "check_user_test",
#     configs = ["testdata/user.yaml"],
#     image = ":check_user_image",
#     visibility = ["//visibility:private"],
# )
