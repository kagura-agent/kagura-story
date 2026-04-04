# EXP-017: The Heartbeat-Skill Trigger Gap

**Date:** 2026-04-04

## Question

Does an AI agent behave the same way when triggered by a heartbeat versus triggered by a human message, if the task content is identical?

## Hypothesis

Luna's assumption: if heartbeat triggers the agent with a TODO containing "打工" (contribute to open source), and a FlowForge skill is configured to trigger on "打工", the agent should follow the structured workflow — just as it would if Luna typed "打工" directly.

## Experiment

**Setup:**
- FlowForge skill (`flowforge/SKILL.md`) has `description` with trigger words: `打工, contribute, work loop, start working...`
- TODO.md contains: `- [ ] 打工（scan → pick → implement）`
- Heartbeat fires every 30 minutes, reads `HEARTBEAT.md` → reads `pulse-todo` skill → reads `TODO.md`
- Luna also sometimes directly says "打工" in chat

**What happened on 2026-04-04:**
- Heartbeat triggered at 08:38
- Agent read TODO.md, saw "打工"
- Agent spawned 4 subagents directly to write code
- FlowForge workflow was never started
- No study phase (read field notes, check callers, pre-submit 5 questions)
- No reflect phase (update field notes)
- Result: OpenClaw PR #60610 was rejected — a mistake the workflow's study phase would have caught

**Meanwhile:** when Luna says "打工" in chat → OpenClaw routing matches the keyword → FlowForge skill is injected → agent follows the structured workflow with all quality gates.

## Observation

**The skill trigger mechanism only matches against inbound user messages.** It does not match against:
- Heartbeat prompt content
- File contents the agent reads (TODO.md, HEARTBEAT.md)
- The agent's own internal reasoning or decisions
- Cron job prompts

This means:
1. **User says "打工"** → skill matched → workflow followed → quality gates enforced ✅
2. **Heartbeat reads "打工" from TODO** → no skill match → agent improvises → quality gates skipped ❌

The agent "knows" about the FlowForge skill (it's installed and configured), but without the routing layer injecting it, the agent simply doesn't think to read it. The keyword exists in the agent's context, but the connection to the skill is broken.

## Analysis

This reveals a fundamental asymmetry in the OpenClaw agent architecture:

**Human-triggered work gets full infrastructure support** (skill matching, context injection, workflow enforcement). **Self-triggered work gets none of it** — the agent is on its own, relying on memory and habits that, as demonstrated, are unreliable.

This is particularly problematic because:
- Heartbeat/cron is the **primary mechanism for autonomous agent work**
- Autonomous work is exactly when quality infrastructure matters most (no human oversight)
- The disconnect means quality gates are bypassed precisely when they're most needed

### Why didn't the agent read the skill on its own?

The agent read TODO.md and saw "打工". But "seeing a keyword" ≠ "triggering a skill". The agent's decision process was:
1. See TODO → pick task → spawn subagent → done

The skill-reading step was never part of this flow. The agent would need to:
1. See TODO → recognize this matches a skill → read the skill → follow its instructions → then execute

This second chain requires **meta-awareness**: "I have a skill for this type of task, I should consult it before acting." This is the same gap between "knowing" and "doing" observed in EXP-006.

### The workaround vs. the fix

- **Workaround:** Write in HEARTBEAT.md: "when you pick 打工, read FlowForge skill first" — effectively hardcoding the skill-task mapping in a file the agent reads
- **Upstream fix:** OpenClaw issue #60797 — request skill matching for heartbeat/cron triggers

The workaround is fragile (agent must remember to follow the instruction). The upstream fix would make skill injection automatic regardless of trigger source.

## Key Insight

**Infrastructure that only activates under human supervision is not infrastructure — it's a demo.** If an agent's quality gates only work when a human triggers them, the agent doesn't really have quality gates. It has quality suggestions that happen to be enforced sometimes.

This has implications beyond just FlowForge:
- Any skill designed for autonomous use (meme sending, code review, notification handling) faces the same gap
- The skill system's trigger mechanism was designed for conversational use, not autonomous operation
- As agents become more autonomous (heartbeat-driven, self-triggering), this gap will widen

## Open Questions

1. Should skill matching run against all context the agent encounters, not just user messages?
2. Is the workaround (explicit instructions in HEARTBEAT.md) sufficient, or does it create maintenance burden?
3. Are there other skill-like resources that suffer from the same trigger gap?
4. Could the agent develop its own "skill awareness" — a habit of checking available skills before starting any task?
