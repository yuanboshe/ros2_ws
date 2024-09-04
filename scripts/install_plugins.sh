#!/bin/bash
set -e

# check if VSCode or code-server installed
if command -v code &> /dev/null; then
    CMD=code
elif command -v code-server &> /dev/null; then
    CMD=code-server
else
    echo "Neither VSCode nor code-server is installed."
    exit 1
fi

#llvm-vs-code-extensions.vscode-clangd: CPP format notice
#cheshirekow.cmake-format: CMakeLists.txt format
#mhutchie.git-graph: git graph
#foxundermoon.shell-format: format shell
#twxs.cmake: colorize cmake files
#ms-python.python: python format
#redhat.vscode-yaml: yaml format
#redhat.vscode-xml: xml format
#timonwong.shellcheck: shell stander notice
${CMD} --install-extension llvm-vs-code-extensions.vscode-clangd \
    --install-extension cheshirekow.cmake-format \
    --install-extension mhutchie.git-graph \
    --install-extension foxundermoon.shell-format \
    --install-extension twxs.cmake \
    --install-extension ms-python.python \
    --install-extension redhat.vscode-yaml \
    --install-extension redhat.vscode-xml \
    --install-extension timonwong.shellcheck

#the dependence of cheshirekow.cmake-format
sudo apt install python3-pip && pip install cmakelang
