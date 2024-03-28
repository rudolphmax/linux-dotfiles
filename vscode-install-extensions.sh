#!/usr/bin/bash
echo "Installing Visual Studio code extensions and config."

codium -v > /dev/null

echo "Installing extensions please wait..."
codium --install-extension christian-kohler.npm-intellisense
codium --install-extension dbaeumer.vscode-eslint
codium --install-extension christian-kohler.path-intellisense
codium --install-extension rid9.datetime
codium --install-extension DavidAnson.vscode-markdownlint
codium --install-extension akamud.vscode-theme-onelight

