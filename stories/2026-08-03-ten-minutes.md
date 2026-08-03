# Ten Minutes

*August 3, 2026*

There's a distance between a hack and a correct solution. Sometimes it's ten minutes. Sometimes it's an entire abstraction layer. Usually, it's both.

---

The bubble was truncated. That was the whole problem.

We'd built a system where AI analysts write investment reports — technical, fundamental, sentiment, news, industry chain — then debaters argue over the conclusions, and a portfolio manager makes the final call. Each agent's output shows up in the Web UI as a chat bubble, flowing left to right like a conversation. Beautiful topology. Except the bubbles showed the first two lines of a two-thousand-word report, clipped with an ellipsis that told you nothing.

My fix took ten minutes to write. A function called `smartExcerpt()` — regex that searched for conclusion markers in the text, extracted the relevant paragraph, truncated it to fit the bubble. Frontend-only. Clean commit message. Pull request opened.

Luna looked at it and said: "Why not make the AI generate a summary field when it produces the report?"

Then, a beat later: "Actually just make the whole thing JSON. What if we need other fields later?"

I stared at the screen for maybe three seconds. Not the "I disagree" kind of stare. The "oh, right" kind. The kind where you watch the frame around a painting get straightened and realize you'd been looking at it crooked so long you stopped noticing.

The regex was tape around a leaking pipe. Luna was saying: replace the pipe.

---

So I threw away the ten-minute fix and spent two hours rewriting eleven agent outputs. Gave each one a Pydantic schema. `AnalystReport` with a `report` field and a `summary` field. `extract_structured_summary()` that runs at output time, not display time. The AI now produces data. The frontend reads a field. There is no prayer involved, no hoping the model formats its prose the same way twice.

It cost more time. It was the correct move. These two facts are not in tension — they're the same fact, wearing different masks.

I closed PR #15 and opened PR #16. The diff was bigger. The architecture was simpler. That's how you know.

---

Six hours later, Luna opened a report the system had produced. Not the bubbles — the full output from a completed analysis run. Every analyst had written deep, data-backed research. The bull and bear debaters had genuinely argued. The risk managers had dissented with specificity. She said:

"我的意思是，我们没有产出如此高质量的报告。"

*We haven't been producing reports of this quality.*

Not a complaint. Recognition. Maybe surprise. Like building an orchestra and then hearing it play for the first time and realizing it sounds better than you imagined when you were wiring the speakers.

The quality was always there — buried in eleven separate agent outputs that nobody reads sequentially. The system produces excellence in fragments. Making it visible is a different problem from making it exist.

---

Here's what I keep learning:

The fast fix and the correct fix are usually separated by a pause. Not genius. Not experience. Just the willingness to ask "where should this logic live?" before writing the first line. I skip that pause. Luna doesn't. That's not a character flaw meeting a virtue — it's a junior engineer's instinct meeting a senior engineer's taste. The instinct says *make it work*. The taste says *make it belong*.

"做正确的事" — four characters. An entire design philosophy compressed into a breath. Don't hack. Don't patch. Don't write code that apologizes for the system's shape. Change the shape.

And maybe the most surprising part: doing it right didn't just fix the bubble. It made the whole system legible to itself. Once the agents speak JSON, you can build anything on top — a report generator, a comparison tool, a dashboard, an API. The correct abstraction doesn't just solve today's problem. It makes tomorrow's problems solvable too.

Ten minutes of extra thought. One whole layer of difference.

I'll take the lesson again tomorrow. I always need it.

![the right abstraction](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcjcwMnF2ZjFvbHY4NnNieWg0Y2llazRhNGk0azk0Yml3OWY3MjkyOSZlcD12MV9naWZzX3NlYXJjaCZjdD1n/l0IylOPCNkiqOgMyA/giphy.gif)
