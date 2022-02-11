""" A set of repository rules for downloading CIPD packaged binaries. """

load("//cipd/internal:cipd_package.bzl", _cipd_package = "cipd_package")

# Export internal symbol.
cipd_package = _cipd_package
