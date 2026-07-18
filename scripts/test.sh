#!/usr/bin/env bash
# Deploy the datapack into the Paper test server and start it with a given world generator.
#
# Usage: scripts/test.sh <generator>
#   generator — world preset name under the plots namespace (e.g. plot, adventure)
#               Sets level-type to plots:<generator>

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATAPACK_DIR="$ROOT/datapack"
RUN_DIR="$ROOT/run"
WORLD_DIR="$RUN_DIR/world"
DATAPACKS_DIR="$WORLD_DIR/datapacks"
PAPER_JAR="paper-26.2-62.jar"
PACK_ZIP_NAME="SneakyWorldGen.zip"
NAMESPACE="${WORLDGEN_NAMESPACE:-plots}"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <generator>" >&2
  echo "  generator  World preset id under ${NAMESPACE}: (e.g. plot, adventure)" >&2
  exit 1
fi

GENERATOR="$1"
LEVEL_TYPE="${NAMESPACE}:${GENERATOR}"
# server.properties requires a backslash before the colon
LEVEL_TYPE_PROP="${NAMESPACE}\\:${GENERATOR}"

if [[ ! -d "$DATAPACK_DIR" ]]; then
  echo "error: datapack directory not found: $DATAPACK_DIR" >&2
  exit 1
fi

if [[ ! -f "$DATAPACK_DIR/pack.mcmeta" ]]; then
  echo "error: missing pack.mcmeta in $DATAPACK_DIR" >&2
  exit 1
fi

if [[ ! -f "$RUN_DIR/$PAPER_JAR" ]]; then
  echo "error: Paper jar not found: $RUN_DIR/$PAPER_JAR" >&2
  exit 1
fi

# Stop a previous test server so world files can be wiped.
if pgrep -f "$PAPER_JAR" >/dev/null 2>&1; then
  echo "Stopping existing Paper server..."
  pkill -f "$PAPER_JAR" || true
  for _ in $(seq 1 30); do
    if ! pgrep -f "$PAPER_JAR" >/dev/null 2>&1; then
      break
    fi
    sleep 0.5
  done
  if pgrep -f "$PAPER_JAR" >/dev/null 2>&1; then
    echo "error: Paper server did not exit; refusing to wipe world" >&2
    exit 1
  fi
fi

mkdir -p "$DATAPACKS_DIR"

echo "Zipping datapack → $PACK_ZIP_NAME"
TMP_ZIP="$(mktemp --suffix=.zip)"
rm -f "$TMP_ZIP"
# pack.mcmeta must sit at the zip root
(cd "$DATAPACK_DIR" && zip -qr "$TMP_ZIP" .)
mv -f "$TMP_ZIP" "$DATAPACKS_DIR/$PACK_ZIP_NAME"

echo "Wiping world (keeping datapacks/)..."
shopt -s dotglob nullglob
for entry in "$WORLD_DIR"/*; do
  base="$(basename "$entry")"
  if [[ "$base" == "datapacks" ]]; then
    continue
  fi
  rm -rf "$entry"
done
shopt -u dotglob nullglob

echo "Configuring level-type=$LEVEL_TYPE"
PROPS="$RUN_DIR/server.properties"
if [[ ! -f "$PROPS" ]]; then
  echo "error: server.properties not found: $PROPS" >&2
  exit 1
fi
if grep -q '^level-type=' "$PROPS"; then
  sed -i "s/^level-type=.*/level-type=${LEVEL_TYPE_PROP}/" "$PROPS"
else
  echo "level-type=${LEVEL_TYPE_PROP}" >> "$PROPS"
fi

echo "Starting $PAPER_JAR (--nogui) with generator '$LEVEL_TYPE'..."
cd "$RUN_DIR"
exec java -jar "$PAPER_JAR" --nogui
