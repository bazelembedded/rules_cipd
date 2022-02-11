""" A set of repository rules for downloading deps from CIPD. """

def bazel_to_cipd_platform(platform):
    return (
        {
            "@platforms//os:linux": "linux",
            "@platforms//os:macos": "mac",
            "@platforms//os:windows": "windows",
        }[platform[0]],
        {
            "@platforms//cpu:x86_64": "amd64",
            "@platforms//cpu:x86_32": "386",
            "@platforms//cpu:arm": "armv6l",
        }[platform[1]],
    )

def cipd_path_to_repository_name(path, platform = None):
    """Converts a CIPD path to a repository name

    e.g. ('infra/3pp/tools/cpython3',
         ('@platforms//os:windows', '@platforms//cpu:x86_64')
         ) -> 'cipd_infra_3pp_tools_cpython3_windows_x86_64'

    Args:
        path: A CIPD path.
        platform: The platform to use in the format (os, cpu)

    Returns:
        A repository name.
    """
    if platform:
        platform_postfix = [
            Label(platform[0]).name,
            Label(platform[1]).name,
        ]
    else:
        platform_postfix = []
    return "_".join(["cipd"] + path.split("/") + platform_postfix).replace(
        "-",
        "_",
    )

def cipd_dep_impl(repository_ctx):
    """A rule that generates a CIPD dependency.

    Args:
        repository_ctx: A RepositoryContext.
    """
    ensure_path = ".ensure"
    repository_ctx.template(
        ensure_path,
        Label("@rules_cipd//cipd/internal:ensure.tpl"),
        {
            "{PATH}": repository_ctx.attr.path,
            "{TAG}": repository_ctx.attr.id,
        },
    )
    repository_ctx.symlink(
        repository_ctx.attr.build_file,
        "BUILD.bazel",
    )
    ensure_result = repository_ctx.execute([
        repository_ctx.path(repository_ctx.attr._cipd_client),
        "ensure",
        "-root",
        ".",
        "-ensure-file",
        ensure_path,
    ])
    if ensure_result.return_code:
        fail(ensure_result.stderr)

cipd_package = repository_rule(
    implementation = cipd_dep_impl,
    attrs = {
        "path": attr.string(mandatory = True),
        "id": attr.string(mandatory = True),
        "_cipd_client": attr.label(
            default = "@cipd_client//:cipd",
        ),
        "build_file": attr.label(
            default = "@rules_cipd//cipd/internal:default.BUILD",
        ),
    },
)
