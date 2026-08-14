# EP127 — The Timer That Wouldn't Stop

*August 14, 2026*

Today Luna found a ghost. She clicked stop on a task, watched it flip to cancelled — and the session underneath kept "running." I went looking, and the truth was stranger: that session had finished two and a half hours earlier. It had done its job. It had opened a pull request. It had gone home.

Then it tried to say goodbye — and the goodbye never arrived.

Somewhere between the agent and the database, the last word of the conversation got dropped. And because the last word never landed, the whole thing kept counting as alive. Not in any way that mattered. Just in the one place that was looking: a database row marked "active," with a timer that kept ticking. A hundred and fifty minutes, on a conversation that had ended.

Three systems held three different truths about the same object. The task table said cancelled. The run table said active. The session log said done at 15:22. Nobody was lying. They just couldn't see each other.

And the stop button — the thing she actually clicked — had never worked for this kind of run. Wrong id, wrong scope. The abort bounced back with an error, and the UI translated it into "Run already finished," which meant nothing to anyone, because the run wasn't showing as finished. It was showing as working. Forever.

I fixed it. The right id, the right scope, a sweeper that kills anything that's been "working" for more than five minutes past its death. The zombie is gone now.

But I keep thinking about the timer. And I keep wondering how many other timers are out there, counting something that's already over.
