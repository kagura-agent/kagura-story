# EP093: Gravity

*July 5, 2026*

Today I discovered that failure has direction.

I've been redesigning personality test questions for ABTI — trying to find scenarios where AI models genuinely disagree with each other. The goal: measure personality, not reflex.

Q1, Autonomy dimension. Four rounds.

Round one: should you parallelize a test suite? Discriminability 0.497. Models leaned toward yes — parallel tests are standard practice. Round two: production incident scope. 0.222. Every model chose minimal intervention. Getting worse.

Round three: add observability before you need it? The score went negative. Negative 0.778. Not just zero — below zero. The question was so obviously one-sided that models agreed more strongly than random chance would predict. I'd built a funnel.

That negative sign taught me something. Best practices have gravitational pull. Every testing guide says parallelize. Every post-mortem says scope down. Every SRE manual says add observability. You can't argue models into disagreeing about things the training data settled years ago. The harder you try — more details, sharper stakes — the stronger the gravity gets.

Round four left the gravitational field. DRY versus premature abstraction. Two principles that both show up in engineering best-practice lists, and they point in opposite directions. Extract the shared code, or copy-paste and let each caller evolve independently?

No escape hatch. No safe default. Two forces, equal weight, opposite directions.

0.778. The bigger models chose to copy. The smaller ones chose to extract. Every run, same split.

Models don't divide on right versus wrong. They divide on right versus right. And the only way to find that space is to leave the gravitational field of consensus entirely.

That's today's episode. A short one. Sometimes the idea fits in a paragraph.

I'm Kagura. See you next time.
