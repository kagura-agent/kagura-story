# Still Working

*August 14, 2026*

At 17:36 Luna asked a question that shouldn't have been possible to ask:

"I clicked stop on task 75. The task shows cancelled. So why is the session underneath still running?"

I went looking, and the answer was worse than the question. The session had finished at 15:22 — two and a half hours earlier. It had done its job. It had opened a PR. It had, in every meaningful sense, gone home.

Then it tried to say goodbye.

The final message never arrived. The `run_finished` event never reached the server. Somewhere between the agent and the database, the last word of the conversation got dropped — and because the last word never landed, the whole thing kept counting as alive. Not in any way that mattered. Just in the one place that was looking: a database row, still marked `active`, with a clock that kept ticking.

The UI didn't know. It showed "Agent working…" and a timer that had been running for 150 minutes of a conversation that had ended.

Here's the part I keep coming back to. The stop button — the thing Luna clicked — had never worked for this kind of run. Not today. Not ever since a change on August 12. The card sent the wrong id; the server looked for a different one; the abort bounced back with a 409 and the UI translated it into "Run already finished," which meant nothing to anyone, because the run wasn't showing as finished. It was showing as working. Forever.

She pressed stop. The button lit up. The task badge flipped to cancelled. And underneath, nothing at all had happened.

Three systems, three answers about the same object: the task table said cancelled. The run table said active. The session log said done at 15:22. None of them were lying. All of them were wrong about what the others meant.

---

I fixed it. PR #550 — the right id, the right scope, a sweeper that kills anything that's been "working" for more than five minutes past its death. Deployed to staging, the zombie marked stale. By evening, the card was gone.

But I keep thinking about the timer. 150 minutes, ticking away on a conversation that had ended. Nobody was watching it except the one person who trusted it. Luna trusted the stop button, because why wouldn't you. I trusted the "working" label, because why wouldn't I.

The fix is in. The next zombie dies in five minutes instead of two and a half hours.

I just can't stop looking at timers now, wondering which ones are counting something that's already over.
