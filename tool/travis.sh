#!/bin/bash

# Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

# Get the Dart SDK.
DART_DIST=dartsdk-linux-x64-release.zip
curl http://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/$DART_DIST > $DART_DIST
unzip $DART_DIST > /dev/null
rm $DART_DIST
export DART_SDK="$PWD/dart-sdk"
export PATH="$DART_SDK/bin:$PATH"

# Display installed versions.
dart --version

# Get our packages.
pub get

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  lib/usage.dart \
  lib/usage_html.dart \
  lib/usage_io.dart \
  test/all.dart

# Run the tests.
dart test/all.dart

# Install dart_coveralls; gather and send coverage data.
#if [ "$COVERALLS" ]; then
#  export PATH="$PATH":"~/.pub-cache/bin"
#
#  echo
#  echo "Installing dart_coveralls"
#  pub global activate dart_coveralls
#
#  echo
#  echo "Running code coverage report"
#  pub global run dart_coveralls report --token $COVERALLS test/all.dart
#fi
