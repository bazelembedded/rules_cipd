""" Version info for the cipd client """

_CIPD_BASE_URL = "https://chrome-infra-packages.appspot.com"
_CIPD_VERSION = "git_revision:1897f73d5e9b48a00ac6935127751b18a8e2a6d7"

_CLIENT_URL_TEMPLATE = _CIPD_BASE_URL + "/client?platform={cipd_os}-{cipd_arch}&version={cipd_version}"

def extract_constraint_name(constraint):
    return Label(constraint).name

def client_repo_name_from_os_cpu_pair(platform):
    """Returns the name of the client repo for the given OS and CPU

    Args:
        platform: A tuple of (os, cpu) strings.
    Returns:
        The name of the client repo, e.g. "cipd_client_linux_x86_64"
    """
    if not platform[0].startswith("@platforms//os:"):
        fail("Invalid os: {}. Should start with @platforms//os:".format(
            platform[0],
        ))
    if not platform[1].startswith("@platforms//cpu:"):
        fail("Invalid cpu: {}. Should start with @platforms//cpu:".format(
            platform[1],
        ))
    return "_".join([
        "cipd_client",
        extract_constraint_name(platform[0]),
        extract_constraint_name(platform[1]),
    ])

def cipd_client_info(cipd_version):
    """Returns the CIPD client info for the given version """
    return {
        ("@platforms//os:linux", "@platforms//cpu:x86_64"): {
            "url": _CLIENT_URL_TEMPLATE.format(
                cipd_os = "linux",
                cipd_arch = "amd64",
                cipd_version = cipd_version,
            ),
            "sha256": "bc3ae4d3dfff7827930cfb92fa7aa067ae2428acb0d46c5c5269fe8268faa65b",
        },
        ("@platforms//os:macos", "@platforms//cpu:x86_64"): {
            "url": _CLIENT_URL_TEMPLATE.format(
                cipd_os = "mac",
                cipd_arch = "amd64",
                cipd_version = cipd_version,
            ),
            "sha256": "",
        },
        ("@platforms//os:windows", "@platforms//cpu:x86_64"): {
            "url": _CLIENT_URL_TEMPLATE.format(
                cipd_os = "windows",
                cipd_arch = "amd64",
                cipd_version = cipd_version,
            ),
            "sha256": "",
        },
    }
