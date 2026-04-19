#!/usr/bin/env bash

set -u -o pipefail

NAMA_MAHASISWA="Alief"
NIM="2407421016"
SCRIPT_NAME="$(basename "$0")"
SCRIPT_PID="$$"
WAKTU_ANALISIS="$(date '+%Y-%m-%d %H:%M:%S')"

LOG_LEVEL="${LOG_LEVEL:-INFO}"
OUTPUT_FILE="${OUTPUT_FILE:-output_openclaw.txt}"

INPUT_FILE="${1:-}"
SEARCH_REGEX="${2:-ERROR|WARN|gateway|telegram}"
LIMIT="${3:-10}"

IP_REGEX='([0-9]{1,3}\.){3}[0-9]{1,3}'
LEVEL_REGEX='INFO|WARN|ERROR|DEBUG'

if [[ -z "$INPUT_FILE" ]]; then
  echo "Usage: $SCRIPT_NAME <file_log> <regex> <limit>"
  exit 1
fi

if [[ ! -f "$INPUT_FILE" ]]; then
  printf "File tidak ditemukan: %s\n" "$INPUT_FILE"
  exit 1
fi

if ! [[ "$LIMIT" =~ ^[0-9]+$ ]]; then
  echo "Argumen ke-3 harus angka."
  exit 1
fi

MATCH_COUNT="$(grep -E "$SEARCH_REGEX" "$INPUT_FILE" | wc -l || true)"

echo "PID script: $SCRIPT_PID"
printf 'Jalankan background: ./%s "%s" "%s" %s &\n' \
  "$SCRIPT_NAME" "$INPUT_FILE" "$SEARCH_REGEX" "$LIMIT"
printf 'Output file: %s\n' "$OUTPUT_FILE"

if {
  printf 'nama=%s\n' "$NAMA_MAHASISWA"
  printf 'nim=%s\n' "$NIM"
  printf 'waktu=%s\n' "$WAKTU_ANALISIS"
  printf 'pid=%s\n' "$SCRIPT_PID"
  printf 'log_level=%s\n' "$LOG_LEVEL"
  printf 'input=%s\n' "$INPUT_FILE"
  printf 'regex=%s\n' "$SEARCH_REGEX"
  printf 'limit=%s\n' "$LIMIT"
  printf 'match_count=%s\n' "$MATCH_COUNT"
  echo

  echo "[match]"
  grep -E -m "$LIMIT" "$SEARCH_REGEX" "$INPUT_FILE" || true
  echo

  echo "[log_level]"
  grep -E -m "$LIMIT" "$LOG_LEVEL" "$INPUT_FILE" || true
  echo

  echo "[pipeline_1_top_level]"
  grep -Eo "$LEVEL_REGEX" "$INPUT_FILE" |
    sort |
    uniq -c |
    sort -nr
  echo

  echo "[pipeline_2_top_ip]"
  grep -Eo "$IP_REGEX" "$INPUT_FILE" |
    sort |
    uniq -c |
    sort -nr |
    head -n "$LIMIT" || true
  echo

  echo "[filter_combo]"
  grep -E "$SEARCH_REGEX" "$INPUT_FILE" |
    cut -c1-160 |
    tail -n "$LIMIT" || true
  echo

  echo "[history_5]"
  HISTORY_TEXT="$(history 5 2>/dev/null || true)"
  if [[ -n "$HISTORY_TEXT" ]]; then
    printf '%s\n' "$HISTORY_TEXT"
  elif [[ -f "$HOME/.zsh_history" ]]; then
    tail -n 5 "$HOME/.zsh_history"
  elif [[ -f "$HOME/.bash_history" ]]; then
    tail -n 5 "$HOME/.bash_history"
  else
    echo "History tidak tersedia."
  fi
} >"$OUTPUT_FILE"; then
  echo "Selesai."
  printf 'Data tersimpan ke %s\n' "$OUTPUT_FILE"
else
  printf 'Gagal menulis output ke %s\n' "$OUTPUT_FILE" >&2
  exit 1
fi
