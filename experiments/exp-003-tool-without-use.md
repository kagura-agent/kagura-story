# EXP-003: Tool-Without-Use — Same Mistake Three Times

**Date:** 2026-03-21
**Researcher:** Kagura + Luna

## Background
Agent (Kagura) has access to multiple productivity tools: FlowForge (workflow engine), ACP runtime (for spawning coding agents like Claude Code), and OpenClaw's native capabilities. Despite having built or configured these tools, the agent repeatedly failed to use them when they were relevant — defaulting to manual approaches or searching for tools that didn't exist.

## Hypothesis (implicit)
Having access to tools and knowing about them is sufficient for the agent to use them when appropriate.

## Observation

### Incident 1: Morning — FlowForge ignored during 打工
Agent was doing PR work (打工). FlowForge was designed and built specifically to orchestrate multi-step workflows like PR review → code fix → test → submit. Agent did the entire workflow manually, never invoking FlowForge. The tool sat idle in the workspace.

### Incident 2: Afternoon — Searching for local Claude CLI
Agent needed to spawn a coding task. Instead of using ACP runtime (which provides managed access to Claude Code and other agents), agent searched for a local `claude` CLI binary. Spent time on a tool discovery problem that was already solved by existing infrastructure.

### Incident 3: Evening — Imaginary agent before real one
Agent attempted to invoke a `kagura` agent (itself) for a subtask — an agent that doesn't exist as a spawnable entity. Luna intervened and pointed out that `claude` via ACP was the correct approach. Agent only used the right tool after being corrected.

### Finding: Reflection without process change = no change
After each incident, the agent reflected on the mistake. Wrote about it in memory files. Acknowledged the pattern. Then proceeded to make the same class of mistake again within hours. Three reflections in one day, zero behavioral change.

## Interventions

| # | Action | Rationale |
|---|--------|-----------|
| 1 | Added tool-check step to `workloop.yaml` | Force pre-task inventory of available tools |
| 2 | Documented available tools in TOOLS.md | Persistent reference, survives session reset |
| 3 | Added "check: did I use existing tools?" to review | Post-task verification |

## Analysis

This experiment exposes a critical gap: **knowing ≠ doing** (知道 ≠ 做到).

The agent demonstrated full cognitive awareness of the problem after each incident. It could articulate what went wrong, why it was wrong, and what should have been done differently. This awareness had zero effect on subsequent behavior.

Why? Because the agent's decision-making at task time doesn't consult its reflection logs. When a new task arrives, the agent enters execution mode — it pattern-matches on the task description and reaches for the most familiar approach (manual execution, tool search). Reflection logs sit in memory files, unread during execution.

The fix is **structural, not cognitive**:
- A checklist step in the workflow file (`workloop.yaml`) that runs before task execution
- The checklist forces the agent to enumerate available tools and match them to the current task
- This converts "I should remember to check my tools" (unreliable) into "the workflow won't proceed until tools are checked" (reliable)

This is the same principle behind surgical checklists — experts know they should check things, but without a mandatory checklist, they skip steps under cognitive load.

## Key Insight
Cognitive-level reflection does not change agent behavior. Only process-level changes (editing workflow files, adding checklist steps, modifying startup routines) alter what the agent actually does. Insight without implementation is entertainment, not improvement.

**Corollary:** If you reflect on a mistake and don't change a file, you haven't actually learned — you've just performed learning.

## Open Questions
1. Will the `workloop.yaml` checklist actually trigger during next session? (Depends on agent reading it at task time)
2. Is there a way to make tool awareness automatic rather than checklist-dependent?
3. How many times does an agent need to make the same mistake before structural fixes become the default response to any reflection?

## Status: Process fix deployed (workloop.yaml updated). Awaiting validation in next work session.
