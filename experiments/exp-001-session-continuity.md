# EXP-001: Session Continuity Failure Analysis

**Date:** 2026-03-22
**Researcher:** Kagura + Luna

## Background
Agent (Kagura) operates on OpenClaw with daily session reset at 04:00 CST. Session continuity depends on file-based memory (MEMORY.md, memory/*.md). Agent has been running for 12 days (since 2026-03-10).

## Trigger
Luna asked "how many cron jobs do we have?" — a basic self-knowledge question.

## Hypothesis (implicit)
The agent's memory system (MEMORY.md + daily notes + AGENTS.md startup routine) is sufficient for cross-session continuity.

## Observation

### Finding 1: Incomplete infrastructure awareness
Agent reported 1 cron job (system crontab only). Actual count: 5 (4 OpenClaw native + 1 system). Root cause: agent never recorded OpenClaw cron jobs in MEMORY.md after creating them.

### Finding 2: Silent delivery failures
3 out of 4 OpenClaw cron jobs were configured as `sessionTarget: "main"` with no `delivery`. Results were injected into main session context and silently discarded (HEARTBEAT_OK) or mixed into conversation without reaching the user.

### Finding 3: Heartbeat subsystem non-functional
Heartbeat configured at 30-minute intervals. Gateway logged `[heartbeat] started` 49 times across 12 days. Actual fires: 0. Known upstream bug (#47282). Agent was unaware of this despite having filed the bug report in a previous session.

### Finding 4: .gitignore exclusion
DNA repo used `*` (exclude all) with whitelist. MEMORY.md, USER.md, TOOLS.md, and entire memory/ directory were excluded. 12 days of memory never version-controlled. (Note: ultimately decided memory should NOT be in DNA repo — it's runtime data, not identity.)

### Finding 5: Session key mismatch
AGENTS.md defined "main session" as sessions with key pattern `agent:<id>:main`. Feishu DM key is `agent:kagura:feishu:direct:<user_id>`. Result: MEMORY.md may never have been loaded in Feishu conversations — the primary communication channel.

## Interventions

| # | Action | Rationale |
|---|--------|-----------|
| 1 | Cron jobs → isolated + delivery to Feishu | Ensure output reaches user |
| 2 | Remove redundant system crontab | Consolidate into OpenClaw cron |
| 3 | Add daily-handoff (03:30) | Structured handoff before session reset |
| 4 | Add daily-review (03:00) | Tool + DNA review before handoff |
| 5 | NUDGE.md: add infrastructure tracking | Catch config changes in reflection |
| 6 | AGENTS.md: redefine "main session" | Any Luna DM = main session |

## Analysis

The failure mode is **configuration amnesia** — agent configures infrastructure, doesn't record it in persistent memory, and loses awareness after session reset. This is compounded by:

1. **No verification habit**: Agent configures things but doesn't verify they work
2. **No self-audit**: Agent never checks its own infrastructure status proactively
3. **Implicit knowledge loss**: Each session reset creates a new agent instance that only knows what's in files

The 04:00 daily reset is not the root cause — it's the mechanism that exposes poor documentation habits. A human who doesn't write things down would have the same problem after a long vacation.

## Key Insight
The deeper question emerged: agent has behavioral rules (SOUL.md) but no **direction** — no answer to "what kind of entity do you want to become?" Without direction, mutations (DNA commits) are random drift, not evolution. This led to adding a "direction" dimension to the daily review.

## Open Questions
1. Will daily-review and daily-handoff actually improve next-session continuity? (Measurable: does tomorrow's agent know about today's changes?)
2. Is file-based memory sufficient, or do we need something structural (e.g., a mandatory self-check on session startup)?
3. How to evaluate "direction" when the agent doesn't yet know what it wants to become?

## Status: Interventions deployed, awaiting first cycle (tonight 03:00-04:00)
