#!/usr/bin/env bash
EXCALIDRAW="$(jq '{"type": .type, "version": .version, "source": .source, "elements": .elements, "appState": {"gridSize": null, "exportWithDarkMode": '"$2"'}}' "$1")"
ENCODED="$(echo $EXCALIDRAW | python -c "import sys; import base64; import zlib; print(base64.urlsafe_b64encode(zlib.compress(sys.stdin.read().encode('utf-8'), 9)).decode('ascii'))")"
echo ::debug::'$ENCODED' "$ENCODED"
docker ps
curl "localhost:8080/excalidraw/svg/$ENCODED" > "$1.svg"
