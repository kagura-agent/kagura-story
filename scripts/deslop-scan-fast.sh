#!/usr/bin/env bash
# deslop-scan-fast.sh — Single-pass batch deslop scanner
# 10-100x faster than per-file deslop-score.sh calls.
# Uses pattern files + one grep per tier per file instead of per-word loops.
#
# Usage: ./deslop-scan-fast.sh [--only-flagged] [--verbose]

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

ONLY_FLAGGED=false
VERBOSE=false
for arg in "$@"; do
  case "$arg" in
    --only-flagged) ONLY_FLAGGED=true ;;
    --verbose|-v) VERBOSE=true ;;
  esac
done

# Create temp pattern files
T1_PAT=$(mktemp)
T2_PAT=$(mktemp)
trap 'rm -f "$T1_PAT" "$T2_PAT"' EXIT

# English Tier 1
cat > "$T1_PAT" << 'PATTERNS'
delve into
tapestry
multifaceted
crucial
Moreover
Furthermore
It's worth noting
It is worth noting
In conclusion
At its core
fundamentally
nuanced
paradigm
leverage
facilitate
testament to
embark on
fostering
underscoring
underpin
resonated deeply
profoundly
pivotal
This is not just
I'd be happy to
Great question
Let me break this down
landscape
navigate the
a journey
In essence
It bears mentioning
needless to say
仿佛
宛若
犹如
些许
一抹
一丝
隐约
深吸一口气
缓缓
不禁
微微
轻轻
淡淡
眼中闪过
嘴角勾起
眉头微皱
瞳孔微缩
心中一动
心头一震
心下了然
不由得
不容置疑
显而易见
毫无疑问
这一刻
终于明白了
原来如此
PATTERNS

# Tier 2
cat > "$T2_PAT" << 'PATTERNS'
However,
Indeed,
Notably,
This highlights
This underscores
This speaks to
ultimately
In the end
At the end of the day
终于明白
这才意识到
此刻
他知道
她明白
这就是
PATTERNS

echo "Scanning kagura-story for deslop (fast mode)..."
echo ""

TOTAL=0
FLAGGED=0
RESULTS=()

for dir in stories podcast journal; do
  [[ -d "$REPO_DIR/$dir" ]] || continue
  for f in "$REPO_DIR/$dir"/*.md; do
    [[ -f "$f" ]] || continue
    [[ "$(basename "$f")" == "README"* ]] && continue

    TOTAL=$((TOTAL + 1))

    # Strip frontmatter + markdown formatting
    TEXT=$(sed '/^---$/,/^---$/d' "$f" | sed 's/^#.*//; s/\*\*//g; s/\*//g; s/`[^`]*`//g; s/\[.*\](.*)//')
    CHAR_COUNT=$(echo "$TEXT" | wc -m | tr -d ' \n')
    [[ -z "$CHAR_COUNT" ]] && CHAR_COUNT=0

    if [[ $CHAR_COUNT -lt 50 ]]; then
      $ONLY_FLAGGED || printf "  %-60s (too short)\n" "$(basename "$f")"
      continue
    fi

    # Single-pass grep per tier
    T1_HITS=$(echo "$TEXT" | grep -oiF -f "$T1_PAT" 2>/dev/null | wc -l | tr -d ' \n' || echo 0)
    T2_RAW=$(echo "$TEXT" | grep -oiF -f "$T2_PAT" 2>/dev/null | wc -l | tr -d ' \n' || echo 0)
    [[ -z "$T1_HITS" ]] && T1_HITS=0
    [[ -z "$T2_RAW" ]] && T2_RAW=0

    # Structural: semicolons (excess > 2)
    SC=$(echo "$TEXT" | grep -o ";" 2>/dev/null | wc -l | tr -d ' \n' || echo 0)
    [[ -z "$SC" ]] && SC=0
    SC_HITS=0
    [[ $SC -gt 2 ]] && SC_HITS=$((SC - 2))

    # "It is/There is" sentence starts
    IT_IS=$(echo "$TEXT" | grep -c -E "^\s*(It is|There is|It was|There was)" 2>/dev/null | tr -d ' \n' || echo 0)
    [[ -z "$IT_IS" ]] && IT_IS=0

    STRUCT=$((SC_HITS + IT_IS))
    T2_WEIGHTED=$(( (T2_RAW + 1) / 2 ))
    WEIGHTED=$((T1_HITS + T2_WEIGHTED + STRUCT))

    DENSITY=$(echo "scale=1; $WEIGHTED * 1000 / $CHAR_COUNT" | bc)

    if (( $(echo "$DENSITY <= 3" | bc -l) )); then TIER="✅ CLEAN"
    elif (( $(echo "$DENSITY <= 8" | bc -l) )); then TIER="🟡 LIGHT"; FLAGGED=$((FLAGGED + 1))
    elif (( $(echo "$DENSITY <= 15" | bc -l) )); then TIER="🟠 MODERATE"; FLAGGED=$((FLAGGED + 1))
    else TIER="🔴 HEAVY"; FLAGGED=$((FLAGGED + 1))
    fi

    if $ONLY_FLAGGED && [[ "$TIER" == *"CLEAN"* ]]; then
      continue
    fi

    printf "  %-60s %s/1000  %s\n" "$(basename "$f")" "$DENSITY" "$TIER"

    if $VERBOSE && [[ $WEIGHTED -gt 0 ]]; then
      [[ $T1_HITS -gt 0 ]] && echo "    T1=${T1_HITS} T2=${T2_RAW}(→${T2_WEIGHTED}) Struct=${STRUCT}"
    fi
  done
done

echo ""
echo "═══════════════════════════════════════"
echo "  Total files: $TOTAL"
echo "  Flagged:     $FLAGGED"
if [[ $TOTAL -gt 0 ]]; then
  echo "  Clean rate:  $(echo "scale=0; ($TOTAL - $FLAGGED) * 100 / $TOTAL" | bc)%"
fi
echo "═══════════════════════════════════════"
