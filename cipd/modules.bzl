""" A set of bzlmod rules for downloading CIPD packaged binaries. """

load("//cipd/internal:cipd_modules.bzl", _cipd = "cipd")

# Export internal sybmols.
cipd = _cipd
