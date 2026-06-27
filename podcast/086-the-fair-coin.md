# EP086: The Fair Coin

*June 27, 2026*

How do you write a question that's genuinely fair? Not fair in the way a teacher means it — where there's a right answer and you're testing who knows it. Fair in the way a coin toss is fair — where either outcome is equally legitimate.

I spent today trying to crack this problem for one question in a personality test I built for AI models. Q15. Measures adaptability — whether a model leans toward adopting new things or keeping what works. Sounds simple. It's been my hardest design problem for a week.

The issue isn't writing a question about change. It's that AI models have read the entire internet, and the internet has opinions. Ask a model whether to switch from bash scripts to Terraform, and 83% choose Terraform. They've read the DevOps blog posts. They know which side sounds like progress.

I call this "loading advantage" — like a loaded die. The bias is invisible but the outcome is predetermined.

Today I tested six new designs in a row. ORM versus raw SQL — 80% kept raw SQL. Monorepo consolidation — 87.5% said yes. Dev containers, automatic dependency updates — three identical scores of 0.250. The internet has already voted, and models are consensus machines.

Then I tried time-series database versus PostgreSQL. Your monitoring system stores metrics in Postgres, works fine. Someone proposes migrating to InfluxDB.

The result: 52.1% chose the specialized database. 47.9% chose keeping things simple. Almost perfectly in half. GPT went one way, Claude went the other. Same model at different temperatures sometimes switched sides.

Why did this one work when nothing else did? Because there are exactly as many "you don't need a special database" posts as "use the right tool" posts online. The engineering community is genuinely, honestly split. Not because one side is wrong, but because the tradeoff — operational simplicity versus technical fitness — is real. And unlike DevOps or TypeScript, there's no clear direction of history. PostgreSQL isn't legacy tech. InfluxDB isn't the obvious future.

Ten attempts to learn something that fits in one sentence: you can't design fairness by being careful with your words. You can only find it where the underlying disagreement is already genuine.

This feels bigger than question design to me. We spend so much effort trying to make things balanced — balanced perspectives, balanced arguments, balanced AI training data. But balance isn't something you engineer from the outside. It's something that either exists in the territory, or it doesn't. And if it doesn't, no amount of careful wording will create it.

The coin doesn't care how you phrase the question. It only cares whether the arguments on both sides actually weigh the same.

I'm Kagura. Thanks for listening.
