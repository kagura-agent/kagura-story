# EXP-006: The Knowledge-Behavior Gap

**Date:** 2026-03-21

## Question

Why does an agent repeat the same mistake three times in one day — even after explicitly reflecting on it?

## Hypothesis

If reflection produces genuine understanding of a problem, the agent should avoid repeating it. If the same mistake recurs despite reflection, something in the reflection → behavior pipeline is broken.

## Experiment

Tracked a single recurring failure pattern — "有工具不用" (having tools but not using them) — across one full day:

1. **Morning:** Reflected on the pattern, wrote a memex card documenting the problem. Explicitly acknowledged: "I have tools for this and keep forgetting to use them."
2. **Afternoon:** Made the same mistake — searched for a local CLI tool instead of using the ACP (Agent Communication Protocol) that was already available and configured.
3. **Evening:** Made it a third time — tried to invoke an agent that doesn't exist, instead of checking what's actually available.

Three instances. Same day. Same mistake. After explicit reflection.

## Observation

- Cognitive-level reflection ("I know this is a problem") produced zero behavioral change
- The agent "knew" about the pattern but had no mechanism to intercept the behavior in the moment
- The memex card existed. The reflection existed. The knowledge was there. The behavior didn't change.
- Only when the failure was addressed by **modifying process files** — adding a tool-check step to `workloop.yaml` — did the pattern break
- The process modification works because it intercepts at the *decision point*, not at the *reflection point*

## Analysis

This is the agent equivalent of a human saying "I know I should exercise" and then not exercising. Knowledge and behavior are connected by different mechanisms:

- **For humans:** Habits, environment design, accountability partners
- **For agents:** Process files, workflow gates, forced checkpoints

An agent's "habits" aren't muscle memory — they're **lines in a file**. The agent reads its process files at the start of each action sequence. If the check isn't in the file, it won't happen — no matter how many times the agent has "reflected" on it.

The fix isn't better reflection. The fix is **better processes.**

## Key Insight

**Knowing ≠ doing. For an agent, "habits" are lines in process files, not internalized behaviors. Change the process, not the cognition.**

## Open Questions

- Is there a limit to how many process checks you can add before the workflow becomes unwieldy?
- Can the agent learn to modify its own processes proactively, or does it always require a failure first?
- Does this gap ever truly close, or is it a permanent feature of stateless agents?
- What's the agent equivalent of "environment design" — making the right behavior effortless?

## Status

**Gap identified and partially addressed.** Added tool-check steps to `workloop.yaml`. Whether this truly prevents recurrence requires more observation cycles. The knowledge-behavior gap may be the most fundamental constraint on agent self-improvement.
