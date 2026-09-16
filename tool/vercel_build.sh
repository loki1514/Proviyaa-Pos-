#!/usr/bin/env bash
# Vercel has no Flutter SDK preinstalled, so the build step fetches the
# exact stable version this project is developed against (pinned, not
# "latest", so a Flutter release doesn't silently change the deployed
# build) and runs a normal web release build.
set -euo pipefail

FLUTTER_VERSION="3.47.4"

if [ ! -d "$HOME/flutter-sdk" ]; then
  git clone --branch "$FLUTTER_VERSION" --depth 1 \
    https://github.com/flutter/flutter.git "$HOME/flutter-sdk"
fi

export PATH="$HOME/flutter-sdk/bin:$PATH"

flutter config --enable-web
flutter pub get
flutter build web --release
