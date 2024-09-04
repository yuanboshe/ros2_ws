#!/bin/bash
set -e

# if want to sequential build, set OPTION_SEQUENTIAL="--executor sequential"
colcon build ${OPTION_SEQUENTIAL} \
    --merge-install \
    --symlink-install \
    --cmake-args "-DCMAKE_BUILD_TYPE=${BUILD_TYPE:=RelWithDebInfo}" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
    -Wall -Wextra -Wpedantic
