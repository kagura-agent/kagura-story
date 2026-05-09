#!/usr/bin/env bash
# deslop-scan.sh — Batch deslop scan across all stories/podcasts
# Usage: ./deslop-scan.sh [--only-flagged]
# Shows summary table + flags anything above CLEAN

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

ONLY_FLAGGED="${1:-}"
TOTAL=0
FLAGGED=0

echo "Scanning kagura-story for deslop..."
echo ""

for dir in stories podcast journal; do
  [[ -d "$REPO_DIR/$dir" ]] || continue
  for f in "$REPO_DIR/$dir"/*.md; do
    [[ -f "$f" ]] || continue
    [[ "$(basename "$f")" == "README"* ]] && continue
    
    OUTPUT=$(bash "$SCRIPT_DIR/deslop-score.sh" "$f" 2>/dev/null || true)
    DENSITY=$(echo "$OUTPUT" | grep "Density:" | awk '{print $2}' | cut -d'/' -f1)
    GRADE=$(echo "$OUTPUT" | grep "Grade:" | sed 's/.*Grade:\s*//')
    
    TOTAL=$((TOTAL + 1))
    
    if [[ "$DENSITY" != "0" && "$DENSITY" != "" ]]; then
      FLAGGED=$((FLAGGED + 1))
      printf "  %-60s %s/1000  %s\n" "$(basename "$f")" "$DENSITY" "$GRADE"
    elif [[ "$ONLY_FLAGGED" != "--only-flagged" ]]; then
      printf "  %-60s %s/1000  %s\n" "$(basename "$f")" "${DENSITY:-?}" "${GRADE:-?}"
    fi
  done
done

echo ""
echo "═══════════════════════════════════════"
echo "  Total files: $TOTAL"
echo "  Flagged:     $FLAGGED"
echo "  Clean rate:  $(echo "scale=0; ($TOTAL - $FLAGGED) * 100 / $TOTAL" | bc)%"
echo "═══════════════════════════════════════"
