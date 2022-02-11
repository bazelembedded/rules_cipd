#!/bin/bash

set -eou pipefail

if [ ! -f "WORKSPACE" ]; then
  echo "Please run this script from the root of the distribution directory"
  exit 1
fi

# Remove whitespaces remove whitespaces from version.bzl so it can be sourced as
# a bash file.
mkdir -p tmp
tail -n +2 ./version.bzl | tr -d ' ' > tmp/version.sh
source tmp/version.sh
rm -r tmp

echo "Creating release for version $version"

bazel build //...

gh release create $version --draft \
    --notes-file bazel-bin/distribution/relnotes.txt \
    --target main \
    ./bazel-bin/distribution/rules_cipd-$version.tar.gz


