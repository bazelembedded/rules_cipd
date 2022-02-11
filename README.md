# rules_cipd
A set of rules for interfacing with and downloading CIPD packages as Bazel
repositories.

## Getting started
First start of by pulling the dependency into your WORKSPACE.
```py
# //:WORKSPACE
git_repository(
    name = "rules_cipd",
    commit = "<TODO>",
    remote = ["https://github.com/bazelembedded/rules_cipd.git"],
)

load("@rules_cipd//:cipd_deps.bzl","cipd_deps")

cipd_deps()

# Pull in your dependencies from cipd.
load("@rules_cipd//cipd:defs.bzl", "cipd_package")

cipd_package(
    name = "python_linux",
    id = "AeeBYkh7rr_sc3IQS1y5D5qzcdtq4yTTqJO6_SiYnvEC",
    path = "infra/python/cpython3/linux-amd64",
    # Optionally override the build file for the package.
    # build_file = "@your_repo//:your_python.BUILD"
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

```

The default build file used exports all files, which means in the example above
you should now be able to download and run python with the following
commands.

```sh
# On Linux run
bazel run @python_linux//:bin/python3 -- -c 'print("hello from cipd")'
# On Macos run
bazel run @python_macos//:bin/python3 -- -c 'print("hello from cipd")'
# On Windows run
bazel run @python_windows//:bin/python3.exe -- -c 'print("hello from cipd")'
```


