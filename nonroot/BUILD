load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_go//go:def.bzl", "go_binary")

# Create a passwd file with a nonroot user and uid.
passwd_entry(
    name = "www_data",
    uid = 33,
    guid = 33,
    username = "www-data",    
    info = "nonroot",
)

passwd_file(
    name = "passwd",
    entries = [
        ":www_data",
    ],
)

# Create /etc/group with the root group
group_entry(
    name = "www_data",
    gid = 33,
    groupname = "www-data",
)

group_file(
    name = "group",
    entries = [
        ":www_data",
    ],
)

pkg_tar(
    name = "passwd_tar",
    srcs = [":passwd"],
    mode = "0644",
    package_dir = "etc",
)

pkg_tar(
    name = "group_tar",
    srcs = [":group"],
    mode = "0644",
    package_dir = "etc",
)

# Include it in our image as a tar.
container_image(
    name = "nonroot",
    base = "//base:base",
    tars = [
        ":passwd_tar",
        ":group_tar",
    ],
    user = "www-data",
    visibility = ["//visibility:private"],
)

container_image(
    name = "static",
    base = "//base:static",
    tars = [
        ":passwd_tar",
        ":group_tar",
    ],
    user = "www-data",
    visibility = ["//visibility:private"],
)

container_image(
    name = "debug",
    base = "//base:debug",
    tars = [
        ":passwd_tar",
        ":group_tar",
    ],
    user = "www-data",
    visibility = ["//visibility:private"],
)

# Simple go program to print out the username and uid.
go_binary(
    name = "user",
    srcs = ["testdata/user.go"],
    pure = "on",
)

container_image(
    name = "check_user_image",
    base = ":passwd_image",
    files = [":user"],
    visibility = ["//visibility:private"],
)

# Test to verify this works :)
container_test(
    name = "check_user_test",
    configs = ["testdata/user.yaml"],
    image = ":check_user_image",
    visibility = ["//visibility:private"],
)
