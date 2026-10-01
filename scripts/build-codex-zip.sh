#!/bin/sh
# The ZIP the OpenAI plugin portal takes: one plugin root, Codex manifest
# only. The Claude manifest is left out so there is no doubt which is read.
set -eu
cd "$(dirname "$0")/../plugins/soggyhotdog"
version=$(python3 -c "import json; print(json.load(open('.codex-plugin/plugin.json'))['version'])")
out="../../dist/soggyhotdog-codex-$version.zip"
mkdir -p ../../dist
rm -f "$out"
zip -qr "$out" .codex-plugin .mcp.json skills assets README.md -x '*.DS_Store'
echo "$out"
