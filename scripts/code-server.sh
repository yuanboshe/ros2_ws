#!/bin/bash

# 环境变量
cd "$(dirname "$0")" || exit $?
WORK_PATH=$(pwd)

#vscode-clangd: CPP格式化，提示等功能。首次打开CPP会要求下载后台程序。
code-server --install-extension llvm-vs-code-extensions.vscode-clangd


