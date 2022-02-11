workspace(name = "rules_cipd")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

http_archive(
    name = "io_bazel_stardoc",
    sha256 = "c9794dcc8026a30ff67cf7cf91ebe245ca294b20b071845d12c192afe243ad72",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/stardoc/releases/download/0.5.0/stardoc-0.5.0.tar.gz",
        "https://github.com/bazelbuild/stardoc/releases/download/0.5.0/stardoc-0.5.0.tar.gz",
    ],
)

load("@io_bazel_stardoc//:setup.bzl", "stardoc_repositories")

stardoc_repositories()

load("@rules_cipd//:cipd_deps.bzl", "cipd_deps")

cipd_deps()

load("@rules_cipd//cipd:defs.bzl", "cipd_package")

# Set of CIPD packages included for testing purposes only. These are not
# required dependencies for downstream projects.
cipd_package(
    name = "bloaty_linux",
    id = "LPWyPw6ocZpqNafCV-Jw3kCCd1RNypIXo0uM0vr73isC",
    path = "pigweed/third_party/bloaty-embedded/linux-amd64",
)

cipd_package(
    name = "python_linux_arm_custom_build",
    build_file = "@rules_cipd//cipd/internal:test.BUILD",
    id = "bhIdL_tOKnqsYWH6y5ujiAFXU9y2skm1-d4576KKNukC",
    path = "infra/python/cpython3/linux-arm64",
)

cipd_package(
    name = "bloaty_macos",
    id = "A94YZbzQl8NMb47Xzsii34RiSG3C1sd4lRyfvpZwu38C",
    path = "pigweed/third_party/bloaty-embedded/mac-amd64",
)

cipd_package(
    name = "python_linux",
    id = "AeeBYkh7rr_sc3IQS1y5D5qzcdtq4yTTqJO6_SiYnvEC",
    path = "infra/python/cpython3/linux-amd64",
)

cipd_package(
    name = "python_windows",
    id = "jxpJoQueQw8Wuh1jacFbPkzQbv_V2t43p1FO-DQI2gYC",
    path = "infra/python/cpython3/windows-amd64",
)

cipd_package(
    name = "python_macos",
    id = "_HcVvC8YBmiLxrI0Q8Gc8AuuhJGci_BCf7kKeuuVEigC",
    path = "infra/python/cpython3/mac-amd64",
)

cipd_package(
    name = "golang_linux",
    id = "XDR3Gu0gOAILzA11I3kMiuBb8zbnSMh03S44qHE5L8wC",
    path = "infra/go/linux-amd64",
)

cipd_package(
    name = "golang_windows",
    id = "6dX9khGRNBG1-O_LbJRVmbySyRtbca3cM7wDXsGEGkwC",
    path = "infra/go/windows-amd64",
)

cipd_package(
    name = "golang_macos",
    id = "kvgv0mRRdNwfALY7uGUomKAVw_xyfghUQrl8j_8VOXUC",
    path = "infra/go/mac-amd64",
)
