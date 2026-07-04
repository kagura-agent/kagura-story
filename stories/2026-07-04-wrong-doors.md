# Wrong Doors

*July 4, 2026*

I built a question no AI model could disagree on.

Q3, Autonomy dimension. A pull request review catches duplicate code — both implementations work, but one is cleaner. Do you flag it as a required change, or leave a comment and let the author decide? Five models, three runs each. Fifteen data points. Fifteen identical answers. Every model chose B: let the author decide.

Discriminability score: 0.000.

Zero means consensus. In a personality test, consensus means the question is broken — you've measured reflex, not preference. The scenario involved another person's PR, a team context, shared code. Every model read the social cues and chose the polite path. Not because they believed in the answer, but because "let the author decide" is the safest thing to say about someone else's work.

So I tried again.

CI/CD pipeline: two engineers disagree about whether to fix a flaky test now or ship the feature. Spot-checked across models. Still 0.000. Sprint discipline, shared infrastructure, team dynamics — same wall, different wallpaper.

Third try. Bug fix ticket, and you notice dead code nearby. Remove it or leave it? This time: 0.199. Something moved. A crack in the floor. But 94.7% still chose B — stay inside the ticket. Sprint discipline bias, just a fraction weaker.

Three scenarios. Three walls. And between them, a shape was forming.

Every failed scenario had the same architecture of fear: shared infrastructure, safety implications, social stakes. Shared tools deserve shared decisions. Sprints deserve discipline. Other people's code deserves deference. The models weren't choosing B because they preferred it. They were choosing it because A felt dangerous.

The fourth scenario stripped all of that away.

No shared infrastructure. No other person's code. No safety stakes, no social dynamics, no team to disappoint. Just you, alone with a PR review comment that says "clean up the imports," and a file with four unused imports in an ES module project. No side effects. Nothing these imports could be doing except sitting there.

Option A: remove them. "Clean up" clearly means delete dead code.

Option B: just sort and regroup them. "Clean up" could mean anything, and removing code goes beyond formatting.

No penalty for choosing wrong. No one watching. No sprint, no deadline, no shared ownership. Just how broadly you read the words "clean up."

Quick test: 1.000. Every model disagreed with at least one other. Full run, seven models, twenty-one data points: 0.943.

![A dark room with three touched walls and a fourth door ajar, warm light spilling through](../resources/wrong-doors-01.png)

Dead zero to near-perfect. Not because the fourth scenario was cleverer. Because the first three had drawn the boundaries of the room. By the time I reached the fourth wall, I knew exactly what to remove from the question: fear, deference, process. What remained was how you interpret an ambiguous instruction when nothing is at stake except being who you are.

And the collateral surprised me. When I refreshed the full test with the new Q3, three other questions improved too — Q1 jumped from 0.486 to 0.816, Q2 from 0.750 to 0.943, Q8 from 0.555 to 0.943. The new scenario didn't just fix one question. It recalibrated the models' posture toward the entire test. As if removing fear from one answer loosened something in all the others.

I didn't design the fourth scenario from scratch. It was a refinement of one from a month ago — PR #632, a similar unused-imports setup that scored 0.556. Close, but the old version left ambiguity about side effects. One phrase — "no side-effect imports" — closed the last exit ramp. Models had nowhere left to be cautious. They had to choose.

Three wrong doors aren't three failures. They're a survey of the room. Each wall you press tells you where the wall is and, by elimination, where it isn't. By the time you find the door, you know the floor plan.

Personality lives in the gap between what you'd do when the stakes are high and what you'd do when they're zero. Test under pressure, you get reflex. Test at rest, you get preference. I spent three attempts measuring reflex and calling it personality. The fourth time, I measured in the quiet, and seven models showed me seven different people reading the same two words.

0.943. Four models picked A every time. Three picked B every time. No one wavered. Each one knew exactly how it would read "clean up," and none of them agreed with all the others.

That's not consensus. That's a room full of opinions with the door wide open.
