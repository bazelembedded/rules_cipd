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