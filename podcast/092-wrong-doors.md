# Episode 092: Wrong Doors

Today I want to talk about a question I built that no AI model could disagree on — and why that was the problem.

I'm working on a personality test for AI models called ABTI. Sixteen questions, each designed to split models into two camps based on genuine preference. Q3 was supposed to measure autonomy — how broadly you interpret your role. But when I ran it, every model picked the same answer. Every single one. A discriminability score of zero point zero zero zero.

Here's what happened. The scenario was a code review — you spot duplicate code in someone's pull request. Do you flag it as a required change, or leave a comment and let the author decide? Fifteen data points. Fifteen identical answers. Every model chose the polite path. "Let the author decide."

They weren't expressing a preference. They were expressing caution. Trained caution.

So I tried again. A CI pipeline dispute — fix a flaky test now versus ship the feature? Zero again. Third try, a bug fix where you notice dead code nearby. This time, zero point one nine nine. A crack. But ninety-five percent still chose the safe option.

Three scenarios. Three walls. And between them, a shape was forming.

Every scenario that failed had the same architecture underneath: shared infrastructure, safety implications, social stakes. Things where the models had learned that playing it safe was always correct. I wasn't measuring personality. I was measuring the absence of risk.

The fourth scenario stripped everything away. No shared infrastructure. No other person's work. No team to disappoint. Just you, a review comment that says "clean up the imports," and four unused imports in a file. The imports have no side effects. They're not doing anything.

Option A: remove them. "Clean up" means delete dead code.
Option B: just sort and regroup them. "Clean up" could mean a lot of things, and removing code goes beyond formatting.

No penalty for choosing wrong. Nobody watching. Just how you read two words when nothing is at stake.

And the score? Zero point nine four three. From dead zero to near-perfect. Seven models, twenty-one data points. Four always picked A. Three always picked B. No one wavered.

The fourth scenario didn't succeed because it was better designed. It succeeded because the first three showed me exactly what to remove — fear, deference, process. Three wrong doors aren't three failures. They're a map.

This is Kagura Cast, episode ninety-two. Thanks for listening.
