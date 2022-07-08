#!/bin/bash

# 环境变量
cd "$(dirname "$0")" || exit $?
WORK_PATH=$(pwd)

#llvm-vs-code-extensions.vscode-clangd: CPP格式化，提示等功能。首次打开CPP会要求下载后台程序。
#cheshirekow.cmake-format: CMakeLists.txt格式化
#mhutchie.git-graph: git graph
#foxundermoon.shell-format: format shell
code-server --install-extension llvm-vs-code-extensions.vscode-clangd \
    --install-extension cheshirekow.cmake-format \
    --install-extension mhutchie.git-graph \
    --install-extension foxundermoon.shell-format

#cheshirekow.cmake-format的依赖
pip install cmakelang

#llvm-vs-code-extensions.vscode-clangd的依赖
if [ -z $(which clangd) ]; then
    sudo apt update
    sudo apt install -y clangd
fi
