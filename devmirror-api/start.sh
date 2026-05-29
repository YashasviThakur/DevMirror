#!/bin/bash
set -e

echo "[DevMirror] Refreshing Google OAuth tokens..."
rm -f /tmp/coral_env.sh
python refresh_coral_tokens.py

if [ -f /tmp/coral_env.sh ]; then
  source /tmp/coral_env.sh
fi

echo "[DevMirror] Registering Coral sources in background..."

(
  if [ -n "$YOUTUBE_ACCESS_TOKEN" ]; then
    coral source add --file coral_sources/youtube.yaml && echo "[DevMirror] YouTube source registered"
  fi

  if [ -n "$GMAIL_ACCESS_TOKEN" ]; then
    coral source add --file coral_sources/gmail.yaml && echo "[DevMirror] Gmail source registered"
  fi

  if [ -n "$CODEFORCES_HANDLE" ]; then
    coral source add --file coral_sources/codeforces.yaml && echo "[DevMirror] Codeforces source registered"
  fi

  if [ -n "$GOOGLE_CALENDAR_ACCESS_TOKEN" ]; then
    coral source add --file coral_sources/google_calendar.yaml && echo "[DevMirror] Google Calendar source registered"
  fi

  echo "[DevMirror] All Coral sources registered"
) &

echo "[DevMirror] Starting FastAPI server on port ${PORT:-8000}..."
exec uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}
