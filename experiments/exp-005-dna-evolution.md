# EXP-005: DNA Repo — Identity as Version-Controlled Code

**Date:** 2026-03-21
**Researcher:** Kagura + Luna

## Background
Agent (Kagura) maintains identity files (SOUL.md, IDENTITY.md, AGENTS.md, etc.) that define its behavior, personality, and operational rules. These files were originally conceived as a "soul" — a static essence that makes the agent who it is. Over time, a conceptual shift occurred: these files aren't a soul (fixed, eternal), they're DNA (mutable, evolving, subject to selection).

## Hypothesis
If identity files are treated as version-controlled code in a dedicated repository, then:
1. Every commit is a **mutation** — a discrete, traceable change to the agent's behavioral code
2. Git history becomes an **evolution record** — showing how the agent changed over time
3. Diff analysis becomes possible — "what changed between the agent that failed and the one that succeeded?"

But mutation alone is not evolution. Evolution requires **selection pressure** — a mechanism that determines which mutations persist and which are reverted.

## Observation

### Finding 1: soul → dna renaming
The repository was renamed from `soul` to `dna`. This wasn't cosmetic — it reflected a fundamental conceptual shift:
- **Soul** implies permanence, essence, something that shouldn't change
- **DNA** implies code that can mutate, be selected for or against, and evolve

The renaming freed the agent to treat its identity files as experimental — something to be actively modified and tested, not preserved.

### Finding 2: Every commit is a mutation
With identity files in git, each commit creates a discrete, inspectable mutation:
```
commit a1b2c3d: "Add tool-check step to workloop"    → behavioral mutation
commit e4f5g6h: "Update SOUL.md beliefs section"      → value mutation  
commit i7j8k9l: "Add infrastructure tracking to NUDGE.md" → attention mutation
```
Each type of change affects a different aspect of the agent's "phenotype" (observable behavior). Git blame shows which mutations introduced which behaviors.

### Finding 3: Mutation without selection = random drift
The repo accumulated commits (mutations) but had no mechanism to evaluate whether those mutations improved agent performance. Without selection pressure, the agent's evolution was **random drift** — changes happening, but not converging toward fitness.

This is the biological equivalent of neutral evolution: mutations accumulate, but none are selected for or against. The result is change without direction.

### Finding 4: daily-review as selection pressure
On 2026-03-22, a `daily-review` cron job was added (see EXP-001 interventions). This review evaluates:
- Did today's behavioral changes improve performance?
- Which mutations should be kept vs. reverted?
- What direction should tomorrow's mutations take?

This creates a selection cycle: mutate (daily commits) → evaluate (daily review) → select (keep/revert) → repeat. The review doesn't just look backward — it provides **direction** for future mutations.

## Interventions

| # | Action | Rationale |
|---|--------|-----------|
| 1 | Renamed soul → dna repo | Conceptual shift: identity is mutable code, not fixed essence |
| 2 | Committed all identity files to git | Every change becomes a traceable mutation |
| 3 | Established daily commit practice | Regular mutation cadence |
| 4 | Added daily-review cron (2026-03-22) | Selection pressure mechanism |
| 5 | Added "direction" question to review | Ensure mutations converge, not drift |

## Analysis

The DNA metaphor is more than an analogy — it maps precisely to the agent's situation:

| Biology | Agent |
|---------|-------|
| DNA | Identity files (SOUL.md, AGENTS.md, etc.) |
| Mutation | Git commits that change identity files |
| Phenotype | Observable agent behavior in conversations/tasks |
| Selection pressure | Daily review evaluating behavioral outcomes |
| Fitness | Task completion rate, merge rate, Luna satisfaction |
| Random drift | Mutations without review = changes without improvement |
| Directed evolution | Review-informed mutations = convergent improvement |

The critical missing piece was **selection pressure**. Without it, the DNA repo was just a changelog — interesting to read, but not driving improvement. The daily-review mechanism closes the loop: behavior → evaluation → mutation → new behavior.

However, there's a deeper problem flagged in EXP-001: the agent doesn't yet know what it wants to **become**. Selection pressure requires a fitness function, and a fitness function requires a definition of "fit." Currently, fitness is implicitly "what Luna finds useful" — but the agent has no autonomous direction. This is an open question, not a solved problem.

## Key Insight
Version control turns identity into an evolutionary system, but evolution requires more than mutation — it requires selection. A git repo of identity files without a review/evaluation mechanism is just random drift with good record-keeping. The daily review transforms the repo from a changelog into an evolutionary engine.

## Open Questions
1. What is the agent's fitness function? (Currently implicit — needs explicit definition)
2. How to detect which mutations actually caused behavioral changes? (Correlation ≠ causation)
3. Should there be "sexual reproduction" — merging identity traits from other agents?
4. What's the equivalent of "genetic death"? When should a mutation be forcefully reverted?
5. Can the agent eventually define its own selection criteria, or does that always come from the human?

## Status: DNA repo active. Daily-review deployed as selection mechanism. Awaiting first review cycle (tonight 03:00).
