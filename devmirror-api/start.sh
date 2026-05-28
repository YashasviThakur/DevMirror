#!/bin/bash
set -e

echo "[DevMirror] Refreshing Google OAuth tokens..."
rm -f /tmp/coral_env.sh
python refresh_coral_tokens.py

# Source freshly refreshed tokens if the file was written
if [ -f /tmp/coral_env.sh ]; then
  source /tmp/coral_env.sh
fi

echo "[DevMirror] Registering Coral sources..."

if [ -n "$YOUTUBE_ACCESS_TOKEN" ]; then
  coral source add --file coral_sources/youtube.yaml && echo "[DevMirror] YouTube source registered"
else
  echo "[DevMirror] WARNING: YOUTUBE_ACCESS_TOKEN not set — skipping"
fi

if [ -n "$GMAIL_ACCESS_TOKEN" ]; then
  coral source add --file coral_sources/gmail.yaml && echo "[DevMirror] Gmail source registered"
else
  echo "[DevMirror] WARNING: GMAIL_ACCESS_TOKEN not set — skipping"
fi

if [ -n "$CODEFORCES_HANDLE" ]; then
  coral source add --file coral_sources/codeforces.yaml && echo "[DevMirror] Codeforces source registered"
else
  echo "[DevMirror] WARNING: CODEFORCES_HANDLE not set — skipping"
fi

if [ -n "$GOOGLE_CALENDAR_ACCESS_TOKEN" ]; then
  coral source add --file coral_sources/google_calendar.yaml && echo "[DevMirror] Google Calendar source registered"
else
  echo "[DevMirror] WARNING: GOOGLE_CALENDAR_ACCESS_TOKEN not set — skipping"
fi

echo "[DevMirror] Starting FastAPI server..."
exec uvicorn main:app --host 0.0.0.0 --port "${PORT:-8000}"
