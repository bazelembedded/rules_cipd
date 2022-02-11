# Repository rule example.
This example demonstrates how to use the repository rule implementation to
download and run python. Inspect the WORKSPACE file for more
information. e.g.

```sh
# On Linux run
bazel run @python_linux//:bin/python3 -- -c 'print("hello from cipd")'
# On Macos run
bazel run @python_macos//:bin/python3 -- -c 'print("hello from cipd")'
# On Windows run
bazel run @python_windows//:bin/python3.exe -- -c 'print("hello from cipd")'
```

## Bazelmod
There is preliminary support for bazelmod in this example. Go ahead and check
it out. Something to note is that you should clone the
`bazelembedded/bazel-central-registry` fork into the same directory as the clone
of rules_cipd. This is essential as the paths for registries in this repo
are hard coded that way. For more information checkout the .bazelrc, and build
with `--config bzlmod`.