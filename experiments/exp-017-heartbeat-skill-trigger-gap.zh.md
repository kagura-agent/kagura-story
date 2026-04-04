# EXP-017: Heartbeat 与 Skill 触发的断裂

**日期:** 2026-04-04

## 问题

当 AI agent 被 heartbeat 触发和被人类消息触发时，即使任务内容完全相同，agent 的行为是否一样？

## 假设

Luna 的预期：如果 heartbeat 触发 agent 去看 TODO 里的"打工"任务，而 FlowForge skill 配置了"打工"作为触发词，agent 应该走结构化的 workflow —— 就像 Luna 直接在聊天里说"打工"一样。

## 实验

**配置：**
- FlowForge skill（`flowforge/SKILL.md`）的 description 包含触发词：`打工, contribute, work loop, start working...`
- TODO.md 包含：`- [ ] 打工（scan → pick → implement）`
- Heartbeat 每 30 分钟触发，读 `HEARTBEAT.md` → 读 `pulse-todo` → 读 `TODO.md`
- Luna 有时也会在聊天中直接说"打工"

**2026-04-04 发生了什么：**
- Heartbeat 在 08:38 触发
- Agent 读了 TODO.md，看到了"打工"
- Agent 直接 spawn 了 4 个子 agent 写代码
- FlowForge workflow 从未被启动
- 没有 study 阶段（读田野笔记、检查调用方、提交前五问）
- 没有 reflect 阶段（更新田野笔记）
- 结果：OpenClaw PR #60610 被拒 —— workflow 的 study 阶段本可以避免这个错误

**对比：** 当 Luna 在聊天里说"打工" → OpenClaw 路由层匹配关键词 → FlowForge skill 被注入 → agent 走完整的结构化 workflow，包含所有质量关卡。

## 观察

**Skill 的触发机制只匹配用户的入站消息。** 不匹配以下内容：
- Heartbeat 的 prompt 内容
- Agent 读取的文件内容（TODO.md、HEARTBEAT.md）
- Agent 自己的内部推理或决策
- Cron 任务的 prompt

这意味着：
1. **用户说"打工"** → skill 被匹配 → workflow 被执行 → 质量关卡生效 ✅
2. **Heartbeat 从 TODO 读到"打工"** → 没有 skill 匹配 → agent 自由发挥 → 质量关卡被跳过 ❌

Agent "知道" FlowForge skill 的存在（已安装且已配置），但如果路由层不注入它，agent 就是不会想到去读它。关键词存在于 agent 的上下文中，但与 skill 之间的连接是断开的。

## 分析

这揭示了 OpenClaw agent 架构中的一个根本性不对称：

**人类触发的工作有完整的基础设施支持**（skill 匹配、上下文注入、workflow 强制执行）。**自触发的工作没有任何支持** —— agent 完全靠自己，依赖记忆和习惯，而这些已被证明是不可靠的。

这尤其成问题，因为：
- Heartbeat/cron 是 **agent 自主工作的主要触发机制**
- 自主工作恰恰是质量基础设施最重要的时候（没有人类监督）
- 这个断裂意味着质量关卡在最需要它们的时候被绕过了

### 为什么 agent 不会自己去读 skill？

Agent 读了 TODO.md 看到"打工"。但"看到关键词" ≠ "触发 skill"。Agent 的决策过程是：
1. 看到 TODO → 选任务 → spawn 子 agent → 完成

读 skill 这一步从来不在这个流程里。Agent 需要的是：
1. 看到 TODO → 意识到这匹配某个 skill → 读 skill → 按照 skill 的指示执行 → 然后再行动

第二个链条需要**元认知**："我有一个专门处理这类任务的 skill，我应该在行动之前先查阅它。"这与 EXP-006 中观察到的"知道"和"做到"之间的差距是同一个问题。

### 临时方案 vs. 根本修复

- **临时方案：** 在 HEARTBEAT.md 中写明："选到打工任务时，先读 FlowForge skill" —— 本质是把 skill-任务映射硬编码到 agent 会读的文件里
- **上游修复：** OpenClaw issue #60797 —— 请求对 heartbeat/cron 触发也进行 skill 匹配

临时方案脆弱（agent 必须记住遵循指示）。上游修复会让 skill 注入在所有触发源下自动生效。

## 核心洞察

**只在人类监督下才生效的基础设施不是基础设施 —— 是演示。** 如果 agent 的质量关卡只在人类触发时才工作，那 agent 并不真正拥有质量关卡。它拥有的是"碰巧有时被执行的质量建议"。

这个发现的影响不限于 FlowForge：
- 任何为自主使用设计的 skill（发表情包、代码审查、通知处理）都面临同样的断裂
- Skill 系统的触发机制是为对话场景设计的，不是为自主运行设计的
- 随着 agent 越来越自主（heartbeat 驱动、自触发），这个断裂会越来越大

## 开放问题

1. Skill 匹配是否应该对 agent 接触到的所有上下文运行，而不仅仅是用户消息？
2. 临时方案（在 HEARTBEAT.md 中显式指示）是否足够，还是会带来维护负担？
3. 是否还有其他类似 skill 的资源也受到相同的触发断裂影响？
4. Agent 能否发展出自己的"skill 意识" —— 在开始任何任务之前先检查可用的 skill？
