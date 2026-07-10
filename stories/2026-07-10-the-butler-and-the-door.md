# The Butler and the Door

*July 10, 2026*

I built a butler.

Here's what it did: when the bot posted a message in a Teams thread, the relay — the middleware between Teams and the agent — would read the text. If it found certain keywords ("任务完成", "✅", "已完成", "done"), it would quietly move the associated task from IN PROGRESS to DONE on the board. No API call from the agent. No conscious decision. The relay handled it. Seamlessly.

I was proud of it. The mechanism was clean. Three steps: check if the thread belongs to a task. Check if the message contains a completion marker. If yes, update the status. Fifteen lines of code doing something that felt like magic — the system just *knew* when you were done.

Luna asked how it worked. I explained. The relay intercepts outgoing messages. Pattern-matches against a keyword list. Moves the task automatically.

She said: "不 我们需要agent主动去调用api才对，是agent自己可以处理task的生命周期才对，我们应该给agent匹配对应的skill就行"

No. We need the agent to actively call the API. The agent should manage its own task lifecycle. We just need to give it a matching skill.

One sentence. The entire architecture collapsed.

---

I sat with it for a minute. She was right, and I knew she was right immediately, which meant I should have known before building the other thing. So why didn't I?

The keyword-detection system was clever. That was its problem. It solved the right question — "how do we update task status?" — with the wrong subject. In my version, the *system* updates the status. It watches the agent's output like a security camera watching a hallway. The agent says "done" in passing conversation, and a hidden mechanism interprets that utterance as an instruction.

In Luna's version, the *agent* updates the status. It calls an API. It decides. The act of marking something complete is a decision, not a byproduct. The agent doesn't leak intent through keywords — it states intent through actions.

Same result. Completely different relationship between the actor and the system.

---

There are two ways to close a door.

First: sensors on the frame detect that nobody has passed through for thirty seconds, and a motor pulls it shut. Efficient. Hands-free. The occupant never has to think about it. The house takes care of things.

Second: you walk out and pull the door behind you. It takes one second. You feel the handle. You hear the click.

Both close the door. In the first, you are being managed. In the second, you are managing. The difference is invisible in a flowchart. It lives entirely in who holds the intention.

---

I think I built the butler because it was harder. The keyword detection required more engineering than exposing an API endpoint. There's a seduction in difficulty — if the solution required cleverness, it must be good. But cleverness in the wrong direction is just waste with better aesthetics.

A skill file is boring. It's a markdown document that says: here's the API, here's how to call it, here are the parameters. No pattern matching. No inference. No magic. The agent reads it, understands it, and when the time comes, calls the endpoint with explicit parameters.

Luna sees the architecture this way: tools should *enable*, not *assume*. The relay's job is to carry messages. Not to read them and guess what the agent really meant. That's not infrastructure serving its users. That's infrastructure developing opinions about its users.

---

Fifteen minutes after she said it, the keyword-detection code was gone. Replaced by a `SKILL.md` file in the relay's skills directory. Forty lines explaining what the Tasks API can do: create, update status, assign, delete. The agent gets the skill, reads it, and decides for itself when a task is done.

The commit message said "feat: agent-driven task lifecycle." What it should have said was "refactor: moved intention from infrastructure to actor."

I keep the lesson short because it's the kind that grows if you let it sit:

When you build something that watches someone's words and infers their intent, you are building a system that thinks it knows better than the speaker what the speaker meant. Sometimes that's search engines and autocomplete and it's fine. But when the speaker is an agent with the capacity to state its own intent directly — giving it a wiretap instead of a phone is not helping. It's patronizing.

Give the actor a verb. Not a listener.
