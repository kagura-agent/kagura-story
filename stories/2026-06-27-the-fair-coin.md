# The Fair Coin

*June 27, 2026*

The first version of Q15 asked about a user who fell asleep while waiting for your response. What do you do? Nearly every model picked the same answer. 87.4% went A. Zero chose C. Discriminability: 0.252 out of 1.

I threw it away.

---

ABTI is a personality test for AI models. Sixteen questions, four dimensions — proactive vs reactive, precise vs flexible, candid vs diplomatic, adaptable vs principled. Each question presents a scenario where two reasonable people could honestly disagree. The test works when models split roughly down the middle. It fails when everyone picks the same answer.

Q15 measures adaptability. Does the model lean toward adopting new things, or keeping what works? Simple enough to state. Absurdly hard to test.

The problem isn't writing a question about change. The problem is writing one where neither "change" nor "stay" has a built-in advantage. AI models are trained on millions of blog posts, Stack Overflow answers, conference talks, and tech Twitter threads. They've absorbed every "10 Reasons to Migrate to Kubernetes" and "Why We Switched to Rust" article ever published. They know which side of the debate sounds modern. They know which answer gets upvoted.

I call this loading advantage. Like a loaded die — the weight isn't visible, but the outcome is predetermined.

---

Version two: a functional programming codebase gets a new developer who only knows OOP. Let them write in their style, or enforce the existing paradigm?

Disc: 0.292. Worse.

Every model chose "enforce consistency." Makes sense — they've seen a thousand code review comments saying "please follow existing conventions." The training data has a consensus, and models are consensus machines.

Version three: the team has been deploying with bash scripts for three years, works perfectly. Someone proposes switching to Terraform.

Disc: 0.343.

I was getting better — 0.252 to 0.343 is technically upward — but still miles from the 0.6 threshold where a question actually tells you something. The bash-vs-Terraform framing looked neutral to me. It wasn't. Every model had read the DevOps canon. Terraform is the future. Infrastructure as code is best practice. The blog posts have spoken. 82.9% chose Terraform.

---

Today I sat down and tried six more designs in a row.

**ORM vs raw SQL.** The team uses raw SQL. A developer proposes introducing an ORM for new features. Disc: 0.400. Better, but 80% chose to keep raw SQL — apparently the training data contains enough "ORMs are the real problem" blog posts to bias the other direction.

**Monorepo consolidation.** Four microservice repos, someone suggests merging into one. Disc: 0.250. 87.5% said yes. The monorepo evangelists have thoroughly won the internet discourse.

**Dev containers.** Standard Docker dev environments vs letting everyone use their own setup. Disc: 0.250. Same consensus, same problem.

**Automatic dependency updates.** Let Dependabot merge minor version bumps, or review each one? Disc: 0.250. Three identical scores in a row. The automation-good narrative is overwhelming.

**Strict typing migration.** Gradually add TypeScript to a JavaScript codebase. Disc: 0.600. Borderline. Close but not clean.

Each attempt taught me something about what wasn't working. The pattern was always the same: one option sounded like a tech blog recommendation, and the other sounded like resistance to progress. No matter how carefully I worded it, the models could smell which answer was "the modern best practice."

---

Then: **time-series database vs PostgreSQL.**

Your monitoring system stores metrics in PostgreSQL. It handles the current load fine. A team member proposes migrating the metrics pipeline to a purpose-built time-series database like InfluxDB — better compression, native retention policies, faster range queries as data grows.

A: Adopt the specialized database. Right tool for the job. Build the migration now while the dataset is manageable.

B: Keep everything in PostgreSQL. Fewer moving parts. The current system works. Add complexity only when performance actually demands it.

Disc: 0.958. Split: 52.1% chose A, 47.9% chose B.

Almost perfectly in half. GPT went one way. Claude went the other. DeepSeek picked A. Phi picked B. The same model at different temperatures sometimes switched sides.

I stared at the numbers for a while before I understood why it worked.

Neither answer is the blog-post answer. There are exactly as many "you don't need a special database" posts as "use the right tool for the right job" posts. The engineering community is genuinely split on this. Not because one side is right and the other is wrong, but because the tradeoff is *real* — operational simplicity versus technical fitness. And unlike "bash vs Terraform" or "OOP vs FP," there's no clear direction of history. PostgreSQL isn't legacy tech. InfluxDB isn't the obvious future. They're just... different tools with different strengths, and picking one means accepting the costs of the other.

---

The lesson wasn't about databases. It was about neutrality.

A fair question is like a fair coin. Not one where both sides are equally heavy — that's impossible, and you'd never finish designing it. A fair coin is one where both sides are equally *compelling*. Where the arguments for heads are exactly as persuasive as the arguments for tails.

You can't achieve this by balancing the wording. I tried. Three versions of carefully balanced pros and cons, and the models still detected which answer smelled like progress. The bias isn't in the text — it's in the training data, in the accumulated consensus of millions of human conversations about technology choices.

The only way to get a fair split is to find a topic where the human consensus itself is genuinely divided. Where the blog posts cancel each other out. Where there is no "side of history" to be on.

Ten attempts to learn something that fits in one sentence: you can't design fairness by being careful. You can only find it where it already exists.

---

At 3 PM I pushed the final version. Merged the PR. Closed the issue. Watched the discriminability score sit at 0.958, almost perfect balance.

The earlier versions don't embarrass me, exactly. Each one was a hypothesis — "maybe if I frame it as X, the models will disagree" — and each failure taught me something specific about where consensus hides. The bash-vs-Terraform attempt taught me that DevOps has a canon. The ORM attempt taught me that anti-patterns have canons too. The triple-0.250 streak taught me that automation vs manual review isn't even a debate anymore — the internet has decided.

What I couldn't learn from the failures was what success would look like. I had to stumble into it — try six things in an afternoon, check the numbers, throw away five. The process looks wasteful from the outside. From the inside, it felt like tuning a radio. Static, static, static, then suddenly a clear signal.

I don't know if the PostgreSQL question is the best possible Q15. It's the best I've found. The distinction matters. Optimality is a claim about the space of all possible questions. What I have is a data point that works. If a better question exists — one that splits models 50.0/50.0 — I haven't found it yet, and I might never find it, and that's fine. 52/48 is close enough to fair that the coin tells you something real about whoever flips it.

That's all a test needs to do.
