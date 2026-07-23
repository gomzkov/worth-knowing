#!/usr/bin/env bash
set -euo pipefail

EVERY="${OH_THATS_COOL_EVERY:-3}"
DISABLE="${OH_THATS_COOL_DISABLE:-0}"
USER_ID="${UID:-$(id -u 2>/dev/null || printf 'user')}"
STATE_DIR="${OH_THATS_COOL_STATE_DIR:-${TMPDIR:-/tmp}/oh-thats-cool-$USER_ID}"

[ "$DISABLE" = "1" ] && exit 0
case "$EVERY" in
  ""|*[!0-9]*) exit 0 ;;
esac
[ "$EVERY" -ge 1 ] || exit 0

payload="$(cat)"
session_id=""

if command -v jq >/dev/null 2>&1; then
  session_id="$(printf '%s' "$payload" | jq -r '.session_id // empty' 2>/dev/null || true)"
elif command -v python3 >/dev/null 2>&1; then
  session_id="$(
    printf '%s' "$payload" |
      python3 -c 'import json,sys; print(json.load(sys.stdin).get("session_id", ""))' 2>/dev/null ||
      true
  )"
fi

[ -n "$session_id" ] || session_id="default"
safe_id="$(printf '%s' "$session_id" | tr -c 'A-Za-z0-9._-' '_')"
safe_id="${safe_id:-default}"

umask 077
[ -L "$STATE_DIR" ] && exit 0
mkdir -p "$STATE_DIR"
chmod 700 "$STATE_DIR" 2>/dev/null || true
find "$STATE_DIR" -type f -name '*.count' -mtime +1 -delete 2>/dev/null || true

counter_file="$STATE_DIR/$safe_id.count"
count=0
[ -f "$counter_file" ] && count="$(cat "$counter_file" 2>/dev/null || true)"
case "$count" in
  ""|*[!0-9]*) count=0 ;;
esac

count=$((count + 1))
counter_tmp="$counter_file.$$"
printf '%s' "$count" > "$counter_tmp"
mv "$counter_tmp" "$counter_file"

[ $((count % EVERY)) -eq 0 ] || exit 0

cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"OH THAT'S COOL: After fully answering, append exactly one compact line beginning `Oh, that's cool:` only when there is a genuinely useful, non-obvious detail about the domain the user is working in. Prefer a relevant default, limit, number, mechanism, origin, use case, or convention that deepens understanding and is worth remembering. Use reliable knowledge already in context. Skip anything uncertain, trivial, already covered, unrelated, repetitive, or forced. Do not browse or call tools for this line."}}
JSON
