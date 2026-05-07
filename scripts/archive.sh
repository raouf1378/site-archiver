#!/usr/bin/env bash
set -euo pipefail

URL="${1:-}"
OUT_DIR="${2:-archive-output}"

if [[ -z "$URL" ]]; then
  echo "Usage: $0 <url> [out_dir]"
  exit 1
fi

mkdir -p "$OUT_DIR"

echo "Archiving URL: $URL"
echo "Output dir: $OUT_DIR"

HOST="$(echo "$URL" | sed -E 's#^https?://([^/]+).*$#\1#')"

wget \
  --no-verbose \
  --recursive \
  --level=3 \
  --page-requisites \
  --adjust-extension \
  --convert-links \
  --span-hosts \
  --domains="$HOST" \
  --no-parent \
  --reject "index.html*" \
  --directory-prefix="$OUT_DIR" \
  "$URL"

echo "Done. Output:"
ls -la "$OUT_DIR"
