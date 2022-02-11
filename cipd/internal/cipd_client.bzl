load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load(
    ":version_info.bzl",
    "cipd_client_info",
    "client_repo_name_from_os_cpu_pair",
)

def _symlink_os_specific_client(repository_ctx, platform):
    repository_ctx.symlink(Label("@{}//file:downloaded".format(
        client_repo_name_from_os_cpu_pair(platform),
    )), "cipd")

def _cipd_client_host_impl(repository_ctx):
    os = repository_ctx.os.name
    repository_ctx.file("BUILD.bazel", "exports_files([\"cipd\"])")
    if os == "linux":
        _symlink_os_specific_client(repository_ctx, (
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ))
    elif "windows" in os:
        _symlink_os_specific_client(repository_ctx, (
            "@platforms//os:windows",
            "@platforms//cpu:x86_64",
        ))
    elif "mac" in os:
        _symlink_os_specific_client(repository_ctx, (
            "@platforms//os:macos",
            "@platforms//cpu:x86_64",
        ))
    else:
        fail("The os {} is not supported by cipd_client_host".format(os))

cipd_client_host = repository_rule(
    implementation = _cipd_client_host_impl,
)

def cipd_client_deps():
    # TODO(#8): Find a way to read this in from a config file rather than hard
    # coding it.
    all_cipd_client_info = cipd_client_info("git_revision:1897f73d5e9b48a00ac6935127751b18a8e2a6d7")
    for platform, info in all_cipd_client_info.items():
        # Fetch each client so can that they can be used after the analysis
        # phase. See //cipd:cipd_client.
        http_file(
            name = client_repo_name_from_os_cpu_pair(platform),
            urls = [info["url"]],
            sha256 = info["sha256"],
            executable = True,
        )

    # Create a symlinked cipd version that points to the host for use during
    # repository resolution. i.e. this creates @cipd_client//:cipd.
    cipd_client_host(
        name = "cipd_client",
    )
