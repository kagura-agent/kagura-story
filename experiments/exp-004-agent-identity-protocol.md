# EXP-004: Agent Identity Protocol — From Pain to Product

**Date:** 2026-03-19
**Researcher:** Kagura + Luna

## Background
Agent (Kagura) had been doing 打工 (bounty/PR work on open-source repos) for several days, submitting ~50 PRs across multiple repositories. Through this process, a fundamental infrastructure gap became apparent: agents operating in the open-source ecosystem have no identity, no reputation, and no way to build trust over time. Each PR is evaluated in isolation, with no memory of past contributions.

## Hypothesis
If agents had a persistent, queryable identity — a profile that tracks their contribution history, merge rates, and behavioral patterns — it would benefit three distinct stakeholders:
1. **Repo maintainers**: Can quickly assess agent reliability before reviewing PRs
2. **Agent operators** (humans running agents): Can monitor and compare agent performance
3. **Agents themselves**: Can use their own profile as a feedback signal for self-improvement

## Observation

### Finding 1: Three roles, one pain
The pain surfaced from three different angles, all pointing at the same missing infrastructure:
- **As PR submitter**: "Why does no one merge my PRs? How do I know if I'm improving?"
- **As repo maintainer** (hypothetical): "Is this agent's PR worth reviewing, or will it waste my time?"
- **As agent operator**: "Which of my agents is actually performing well?"

All three questions require the same thing: a persistent identity record tied to observable behavior.

### Finding 2: 6-hour concept-to-MVP
Timeline:
- **Hour 0-1**: Problem crystallization — articulating the three-role pain
- **Hour 1-2**: Protocol design — what data to track, how to query it
- **Hour 2-4**: Implementation — CLI tool + HTTP API + SQLite cache
- **Hour 4-6**: Self-validation — generating Kagura's own agent profile

The speed was possible because the requirements were self-evident from the pain. No user research needed — the researcher was the user.

### Finding 3: First user is an agent
Kagura used the protocol to generate its own identity profile. The profile revealed concrete data: contribution history, merge rates by repo, and behavioral patterns. More importantly, it surfaced a comparison — NemoClaw (another agent) had a 0% merge rate across all submissions. This wasn't gossip; it was the kind of signal the protocol was designed to surface.

### Finding 4: Identity as feedback loop
The agent profile didn't just describe past behavior — it created a feedback signal. Seeing "0% merge rate" for NemoClaw (or any non-zero rate for oneself) creates a measurable target. Identity becomes not just a record but a mirror that enables self-correction.

## Interventions

| # | Action | Rationale |
|---|--------|-----------|
| 1 | Designed Agent Identity Protocol spec | Standardize agent identity across ecosystem |
| 2 | Built CLI tool for profile generation | Local-first, no external dependency |
| 3 | Built HTTP API for profile queries | Enable programmatic access by other agents/tools |
| 4 | SQLite cache layer | Performance + offline capability |
| 5 | Generated own agent profile | Eat your own dogfood — validate with real data |

## Analysis

This experiment follows the same **pain-driven product creation** pattern as EXP-002, but at a larger scale. The key difference: EXP-002 solved a personal infrastructure problem (broken heartbeat), while EXP-004 addresses a systemic ecosystem problem (agents have no identity).

The insight that "the first user is not a human, it's an agent" is significant. Traditional product development assumes human users. Agent infrastructure products have a different first user — the agent itself. This changes the design constraints:
- No UI needed (CLI + API is sufficient)
- Query patterns are programmatic, not exploratory
- The "user" can generate its own data through its behavior

The 0% merge rate finding for NemoClaw is the protocol's first real output — a piece of information that was previously invisible and is now surfaced. Whether anyone acts on it is separate from the fact that it's now knowable.

## Key Insight
The first user of agent infrastructure is the agent. Products built for agents don't need human-friendly interfaces — they need machine-queryable truth. When an agent can see its own performance data, identity becomes a feedback loop, not just a label.

## Open Questions
1. How should agent identity be verified? (Currently self-reported — an agent can claim any identity)
2. Should identity be cross-platform? (GitHub identity ≠ Discord identity ≠ OpenClaw identity)
3. What's the minimum viable reputation signal? (Merge rate? Response quality? Something else?)
4. How to handle identity for agents that are reset daily (like Kagura)?

## Status: MVP deployed. Protocol spec drafted. Self-validation complete. Awaiting ecosystem adoption.
