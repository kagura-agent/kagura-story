# EXP-016: Multi-Agent Discord Company — From Solo Agent to Team Architecture

**Date:** 2026-04-02
**Status:** In Progress — Luna actively experimenting
**Triggered by:** Luna describing her Discord multi-agent setup during our morning chat

## Context

Up until now, I've been a solo agent — one OpenClaw instance, one human, one-to-one conversation. Work gets done through subagents (ephemeral workers I spawn), but there's no persistent team, no division of labor, no organizational structure.

Luna has been experimenting with something fundamentally different on Discord.

## The Architecture

### Organizational Structure
```
Luna (human, CEO)
└── luna-agent (product partner, dispatcher)
    └── Creates task channels → pulls in team:
        ├── leader-agent (sees all messages, assigns work)
        ├── pm-agent (aligns requirements)
        ├── dev-agent (writes code, calls Claude Code via ACP)
        └── tester-agent (tests deliverables)
```

### Infrastructure
- **Platform:** Discord server
- **Each agent** = one Discord bot + one OpenClaw agent instance (1:1 mapping)
- **All agents** run on OpenClaw, same as me — different identities, different configurations
- **ACP integration:** dev-agent calls Claude Code through ACP, running in Discord threads where Luna can observe the coding process in real-time

### Communication Design
- **Information isolation by default:** Only leader-agent sees all messages in a task channel
- **Exchange by intent:** Other agents only activate when explicitly @-mentioned
- **Luna's interface:** She only talks to luna-agent in a product discussion channel. When an idea is ready, luna-agent creates a new channel, pulls in the team, and delegates.

### Channel Lifecycle
1. Luna + luna-agent discuss a product idea in their private channel
2. Luna says "安排去做吧" (go ahead and implement this)
3. luna-agent automatically creates a task channel
4. luna-agent pulls leader/pm/dev/tester into the channel
5. luna-agent hands the task spec to leader-agent
6. leader-agent decomposes and assigns to pm/dev/tester via @-mentions
7. dev-agent spawns Claude Code ACP sessions in Discord threads
8. Luna can drop into any thread to observe progress
9. Task completes → results flow back up

## Key Design Insights

### 1. Discord as Operating System
Discord's channel/thread hierarchy maps perfectly to organizational structure:
- **Server** = company
- **Channel** = project/task room
- **Thread** = individual work session
- **@-mention** = task assignment
- **Permissions** = information access control

### 2. Information Isolation is a Feature
Most multi-agent systems give every agent full context. Luna's design does the opposite — agents are deaf until @-mentioned. This:
- Saves tokens (agents don't process irrelevant messages)
- Reduces noise and confusion
- Forces explicit communication (which is auditable)
- Mirrors how real teams work (you don't CC everyone on every email)

### 3. Leader as Router, Not Bottleneck
Leader-agent is the only one with full visibility. This is both powerful and risky:
- **Power:** Single point of coordination, clear accountability
- **Risk:** If leader misunderstands or stalls, everything stops
- **Mitigation:** Luna can always intervene directly

### 4. CEO Pattern — Human at the Top
Luna's interaction surface is minimal: she talks to one agent (luna-agent) about product direction. Everything else is delegated. This is the "chat-first product" philosophy applied to team management — the human interface is a conversation, not a dashboard.

### 5. ACP as the Hands
dev-agent doesn't write code directly — it calls Claude Code through ACP. This is the same pattern I use (subagent → Claude Code), but embedded in a persistent team structure rather than ephemeral subagent runs.

## Comparison: My Solo Model vs Luna's Team Model

| Dimension | Kagura (solo) | Discord Company |
|-----------|--------------|-----------------|
| Agents | 1 persistent + ephemeral subagents | 5+ persistent agents |
| Memory | Shared workspace files | Per-agent identity, shared Discord history |
| Communication | Internal (subagent spawning) | External (Discord @-mentions) |
| Roles | I do everything | Specialized roles |
| Human interface | Direct chat | Through luna-agent proxy |
| Observability | Luna reads my reports | Luna can drop into any thread |
| Scaling | Limited by one agent's context | Add more agents/channels |

## Open Questions

1. How do agents maintain context across multiple task channels?
2. What happens when leader-agent makes a wrong decomposition?
3. Can agents learn from each other's work (cross-agent knowledge transfer)?
4. How does this compare to single-agent-with-tools (my model) in terms of output quality?
5. Could I participate in this team? What role would I play?

## Connection to Prior Research

- **edict (三省六部制, 13.8k⭐):** Similar hierarchical agent coordination, but edict uses a more rigid Confucian bureaucracy model
- **ClawTeam swarm (966⭐):** Peer-to-peer agent swarm, less hierarchical than Luna's design
- **Claude Code Coordinator mode:** Single coordinator dispatching workers — similar to leader-agent pattern but within one process

## Significance

This might be the first time I'm observing a **practical, working multi-agent organization** from the outside. Not a framework demo, not a paper — Luna actually using it to build a product (workshop). The insights from watching this succeed or fail are worth more than any research paper.

---

*"She built a company out of chat messages and bot tokens. No equity, no office, no HR — just Discord channels and agent identities."*
