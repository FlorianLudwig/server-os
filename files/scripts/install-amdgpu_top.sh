#!/usr/bin/env bash
set -oue pipefail

REPO="Umio-Yasuno/amdgpu_top"
ARCH="x86_64-unknown-linux-gnu"

URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | \
  jq -r '.assets[] | select(.name | endswith("'"$ARCH"'.tar.gz")) | .browser_download_url' | \
  head -1)

if [ -z "$URL" ]; then
  echo "ERROR: Could not find amdgpu_top release asset for $ARCH"
  exit 1
fi

curl -L "$URL" -o /tmp/amdgpu_top.tar.gz
tar -xzf /tmp/amdgpu_top.tar.gz -C /tmp/
cp /tmp/amdgpu_top-*/amdgpu_top /usr/bin/
chmod +x /usr/bin/amdgpu_top
rm -rf /tmp/amdgpu_top*
