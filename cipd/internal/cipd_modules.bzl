""" Internal implementations for cipd rules """

load(":cipd_package.bzl", "cipd_package", "cipd_path_to_repository_name")
load(":cipd_client.bzl", "cipd_client_deps")

def cipd_client_impl(module_ctx):
    """ Downloads and installs CIPD client. """
    cipd_client_deps()

    # Fetch real cipd deps
    for mod in module_ctx.modules:
        for package in mod.tags.package:
            cipd_package(
                name = cipd_path_to_repository_name(package.path),
                id = package.id,
                path = package.path,
                build_file = package.build_file,
            )

cipd_package_tag = tag_class(attrs = {
    "path": attr.string(mandatory = True, doc = "CIPD package name."),
    "id": attr.string(mandatory = True, doc = "CIPD package id."),
    "build_file": attr.label(doc = "Build file to use for this package."),
})

cipd = module_extension(
    implementation = cipd_client_impl,
    tag_classes = {"package": cipd_package_tag},
)
