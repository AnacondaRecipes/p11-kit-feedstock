#!/bin/bash
set -ex

BUILD_DIR=build

MESON_ARGS=(
    --prefix="${PREFIX}"
    --libdir=lib
    -Dsystemd=disabled
)

meson setup "$BUILD_DIR" "${MESON_ARGS[@]}"
meson compile -C "$BUILD_DIR"

test_list=$(meson test -C "$BUILD_DIR" --list) 2> /dev/null
test_list=$(echo $test_list | sed -e "s/^p11-kit:test-transport//" -e "s/p11-kit:test-transport3//")

meson test -C "$BUILD_DIR" $test_list --print-errorlogs
meson install -C "$BUILD_DIR"
