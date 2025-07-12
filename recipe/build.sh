#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

if [[ "$target_platform" == "osx-64" || "$target_platform" == "osx-arm64" ]]; then
    echo "Building for macOS"
else
    # Install menuinst
    install -Dm0644 "${RECIPE_DIR}/menu.json" "${PREFIX}/Menu/${PKG_NAME}_menu.json"
    install -Dm0644 crates/zed/resources/app-icon.png "$PREFIX/Menu/zed.png"
fi

if [[ "$target_platform" == "osx-arm64" && "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" ]]; then
  export CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_PREFIX_PATH=${PREFIX}"
fi

# Set Cargo build profile
# LTO=thin is already the default, and fat just takes too much memory
export CARGO_PROFILE_RELEASE_STRIP=symbols

# Check licenses
cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml
export CFLAGS="$CFLAGS -D_BSD_SOURCE"

# Build package
cargo build --release --package zed --package cli

# Install package
install -Dm0755 target/${CARGO_BUILD_TARGET}/release/cli "$PREFIX/bin/zed"
install -Dm0755 target/${CARGO_BUILD_TARGET}/release/zed "$PREFIX/lib/zed/zed-editor"
