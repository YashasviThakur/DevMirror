#!/bin/bash
set -e

# Register Coral sources using tokens from Railway env vars
echo "[DevMirror] Registering Coral sources..."

if [ -n "$YOUTUBE_ACCESS_TOKEN" ]; then
  coral source add --file coral_sources/youtube.yaml && echo "[DevMirror] YouTube source registered"
else
  echo "[DevMirror] WARNING: YOUTUBE_ACCESS_TOKEN not set — YouTube Coral source skipped"
fi

if [ -n "$GMAIL_ACCESS_TOKEN" ]; then
  coral source add --file coral_sources/gmail.yaml && echo "[DevMirror] Gmail source registered"
else
  echo "[DevMirror] WARNING: GMAIL_ACCESS_TOKEN not set — Gmail Coral source skipped"
fi

if [ -n "$CODEFORCES_HANDLE" ]; then
  coral source add --file coral_sources/codeforces.yaml && echo "[DevMirror] Codeforces source registered"
else
  echo "[DevMirror] WARNING: CODEFORCES_HANDLE not set — Codeforces Coral source skipped"
fi

echo "[DevMirror] Starting FastAPI server..."
exec uvicorn main:app --host 0.0.0.0 --port "${PORT:-8000}"
