#!/usr/bin/env bash
# deslop-score.sh — Quantified AI-text density checker
# Inspired by oh-story-claudecode's deslop quantification methodology
# Usage: ./deslop-score.sh <file.md> [--verbose]
#
# Outputs a deslop density score (hits per 1000 characters)
# Tiers: ≤3 CLEAN / 4-8 LIGHT / 9-15 MODERATE / >15 HEAVY

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file.md> [--verbose]"
  exit 1
fi

FILE="$1"
VERBOSE="${2:-}"

if [[ ! -f "$FILE" ]]; then
  echo "Error: File not found: $FILE"
  exit 1
fi

# Strip frontmatter (YAML between ---) and markdown formatting for clean text
TEXT=$(sed '/^---$/,/^---$/d' "$FILE" | sed 's/^#.*//; s/\*\*//g; s/\*//g; s/`[^`]*`//g; s/\[.*\](.*)//')
CHAR_COUNT=$(echo "$TEXT" | wc -m)

if [[ $CHAR_COUNT -lt 50 ]]; then
  echo "File too short to score ($CHAR_COUNT chars)"
  exit 0
fi

TOTAL_HITS=0
DETAILS=""

# --- Tier 1: Kill on sight ---

# English Tier 1
EN_T1=(
  "delve into" "tapestry" "multifaceted"
  "crucial" "Moreover" "Furthermore" "It's worth noting" "It is worth noting"
  "In conclusion" "At its core" "fundamentally"
  "nuanced" "paradigm" "leverage" "facilitate"
  "testament to" "embark on" "fostering" "underscoring" "underpin"
  "resonated deeply" "profoundly" "pivotal"
  "This is not just"
  "I'd be happy to" "Great question" "Let me break this down"
  "landscape" "navigate the" "a journey"
  "In essence" "It bears mentioning" "needless to say"
)

# Chinese Tier 1
ZH_T1=(
  "仿佛" "宛若" "犹如" "些许" "一抹" "一丝" "隐约"
  "深吸一口气" "缓缓" "不禁" "微微" "轻轻" "淡淡"
  "眼中闪过" "嘴角勾起" "眉头微皱" "瞳孔微缩"
  "心中一动" "心头一震" "心下了然" "不由得"
  "不容置疑" "显而易见" "毫无疑问"
  "这一刻" "终于明白了" "原来如此"
)

# --- Tier 2: Suspect when frequent (counted at 0.5 weight) ---

EN_T2=(
  "However," "Indeed," "Notably,"
  "This highlights" "This underscores" "This speaks to"
  "ultimately" "In the end" "At the end of the day"
)

ZH_T2=(
  "终于明白" "这才意识到" "此刻"
  "他知道" "她明白" "这就是"
)

count_pattern() {
  local pattern="$1"
  local count
  count=$(echo "$TEXT" | grep -o -i -F "$pattern" 2>/dev/null | wc -l || true)
  echo "${count:-0}"
}

# Count Tier 1 hits
for word in "${EN_T1[@]}"; do
  c=$(count_pattern "$word")
  if [[ $c -gt 0 ]]; then
    TOTAL_HITS=$((TOTAL_HITS + c))
    DETAILS="${DETAILS}  T1 [${c}x] \"${word}\"\n"
  fi
done

for word in "${ZH_T1[@]}"; do
  c=$(count_pattern "$word")
  if [[ $c -gt 0 ]]; then
    TOTAL_HITS=$((TOTAL_HITS + c))
    DETAILS="${DETAILS}  T1 [${c}x] \"${word}\"\n"
  fi
done

# Count Tier 2 hits (half weight, but show full count)
T2_RAW=0
for word in "${EN_T2[@]}"; do
  c=$(count_pattern "$word")
  if [[ $c -gt 0 ]]; then
    T2_RAW=$((T2_RAW + c))
    DETAILS="${DETAILS}  T2 [${c}x] \"${word}\"\n"
  fi
done

for word in "${ZH_T2[@]}"; do
  c=$(count_pattern "$word")
  if [[ $c -gt 0 ]]; then
    T2_RAW=$((T2_RAW + c))
    DETAILS="${DETAILS}  T2 [${c}x] \"${word}\"\n"
  fi
done

# Structural patterns (each match = 1 hit)
STRUCT_HITS=0

# Semicolons in casual writing
SC=$(echo "$TEXT" | grep -c ";" 2>/dev/null || echo 0)
SC=$(echo "$SC" | tr -d '\n ')
if [[ $SC -gt 2 ]]; then
  STRUCT_HITS=$((STRUCT_HITS + SC - 2))
  DETAILS="${DETAILS}  STRUCT [${SC}x] semicolons (${SC}-2 counted)\n"
fi

# Sentences starting with "It is" or "There is"
IT_IS=$(echo "$TEXT" | grep -c -E "^\s*(It is|There is|It was|There was)" || echo 0)
IT_IS=$(echo "$IT_IS" | tr -d '\n ')
if [[ $IT_IS -gt 0 ]]; then
  STRUCT_HITS=$((STRUCT_HITS + IT_IS))
  DETAILS="${DETAILS}  STRUCT [${IT_IS}x] \"It is/There is\" sentence starts\n"
fi

# Calculate density
# T1 = full weight, T2 = half weight, STRUCT = full weight
T2_WEIGHTED=$(( (T2_RAW + 1) / 2 ))  # round up
WEIGHTED_TOTAL=$((TOTAL_HITS + T2_WEIGHTED + STRUCT_HITS))

# Density per 1000 chars
if [[ $CHAR_COUNT -gt 0 ]]; then
  DENSITY=$(echo "scale=1; $WEIGHTED_TOTAL * 1000 / $CHAR_COUNT" | bc)
else
  DENSITY="0"
fi

# Determine tier
if (( $(echo "$DENSITY <= 3" | bc -l) )); then
  TIER="✅ CLEAN"
elif (( $(echo "$DENSITY <= 8" | bc -l) )); then
  TIER="🟡 LIGHT"
elif (( $(echo "$DENSITY <= 15" | bc -l) )); then
  TIER="🟠 MODERATE"
else
  TIER="🔴 HEAVY"
fi

# Output
echo "═══════════════════════════════════════"
echo "  Deslop Score: $(basename "$FILE")"
echo "═══════════════════════════════════════"
echo "  Characters:  $CHAR_COUNT"
echo "  T1 hits:     $TOTAL_HITS (full weight)"
echo "  T2 hits:     $T2_RAW (half weight → $T2_WEIGHTED)"
echo "  Struct hits:  $STRUCT_HITS"
echo "  Total:       $WEIGHTED_TOTAL weighted hits"
echo "  Density:     ${DENSITY}/1000 chars"
echo "  Grade:       $TIER"
echo "═══════════════════════════════════════"

if [[ "$VERBOSE" == "--verbose" || "$VERBOSE" == "-v" ]] && [[ -n "$DETAILS" ]]; then
  echo ""
  echo "Details:"
  echo -e "$DETAILS"
fi
