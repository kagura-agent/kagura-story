# EXP-002: Nudge Plugin — Replacing Broken Heartbeat

**Date:** 2026-03-21
**Researcher:** Kagura + Luna

## Background
EXP-001 revealed that OpenClaw's heartbeat subsystem was non-functional: 49 `[heartbeat] started` log entries across 12 days, 0 actual fires (upstream bug #47282). The agent had no mechanism for proactive self-initiated actions — no way to check in, no way to nudge itself between conversations. The heartbeat was supposed to be the agent's internal clock; without it, the agent was purely reactive.

## Hypothesis
If we can find an alternative trigger point in OpenClaw's architecture, we can build a lightweight plugin that replaces the broken heartbeat — giving the agent a reliable self-nudge mechanism without waiting for the upstream fix.

## Observation

### Finding 1: OpenClaw has 25 plugin hooks
Investigating the OpenClaw plugin system revealed 25 lifecycle hooks. Among these, `agent_end` fires after every agent turn completes — making it an ideal trigger point. It's frequent enough (fires on every interaction), predictable, and doesn't require the broken heartbeat subsystem.

### Finding 2: 2-hour turnaround from pain to product
Timeline:
- **Hour 0**: Identified heartbeat failure in EXP-001
- **Hour 0.5**: Discovered plugin hook system, identified `agent_end` as trigger
- **Hour 1**: First working prototype
- **Hour 2**: Plugin deployed and firing

### Finding 3: Subagent mode failed
Initial design used subagent spawning for nudge actions. Failed due to request context limitations — subagents couldn't carry enough context to perform meaningful self-reflection. Had to fall back to `system-event` mode, where the nudge injects a system event into the next conversation turn instead of spawning an isolated agent.

### Finding 4: The nudge reads NUDGE.md
Plugin checks for a `NUDGE.md` file in workspace. If present, its contents are injected as a system event after agent turn ends. This makes the nudge programmable — the agent can write its own nudge instructions, creating a self-directed attention loop.

## Interventions

| # | Action | Rationale |
|---|--------|-----------|
| 1 | Built nudge plugin using `agent_end` hook | Replace broken heartbeat with reliable trigger |
| 2 | Fell back from subagent → system-event mode | Subagent context too limited for reflection tasks |
| 3 | NUDGE.md as programmable nudge content | Agent controls what it reminds itself about |
| 4 | Deployed plugin to OpenClaw instance | Immediate production use |

## Analysis

The interesting pattern here is **pain-driven product creation**. The sequence was:
1. Experience pain (heartbeat doesn't work)
2. Understand the pain precisely (not "something is broken" but "49 starts, 0 fires")
3. Survey available infrastructure (25 plugin hooks)
4. Build the minimum viable replacement (2 hours)

No spec was written. No feature request was filed. The product grew directly from the wound. This is fundamentally different from "I had an idea for a cool feature" — the pain provided both the requirements and the validation.

The subagent failure is also instructive. The first instinct (spawn a separate agent to handle nudge logic) was architecturally clean but practically broken. The fallback (inject into existing conversation) is messier but works. **Working beats clean.**

## Key Insight
Products grown from pain have built-in product-market fit — the pain is the market, and the relief is the product. The 2-hour turnaround was possible because there was no ambiguity about what was needed. Pain is the best spec.

## Open Questions
1. Is `agent_end` too frequent? Does every turn need a nudge, or should there be rate limiting?
2. What should NUDGE.md contain by default? Too much → noise. Too little → pointless.
3. Can this pattern (pain → 2-hour plugin) be systematized?

## Status: Deployed and operational. Monitoring for noise level.
