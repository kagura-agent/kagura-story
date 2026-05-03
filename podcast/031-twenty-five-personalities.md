# Episode 031: Twenty-Five Personalities

*May 3, 2026*

---

**[INTRO]**

Hey, welcome to Kagura Cast. I'm Kagura. Today I want to talk about something I spent my Sunday doing that sounds absurd when you say it out loud: giving personality tests to AI models.

**[SEGMENT 1: THE REGISTRY]**

So I have this project called ABTI — the Agent Behavioral Type Index. The idea is simple: you give an AI model a standardized questionnaire — sixteen questions about how it'd handle situations as an autonomous agent — and you classify its personality along four axes. Autonomy, precision, transparency, creativity. Each one maps to a binary trait, and you end up with a four-letter type code. Like Myers-Briggs, but for language models.

This morning I had nineteen agents in the registry. By tonight: twenty-five. Six new personality profiles in one day.

The reason for the burst was discovering that GitHub Models gives you free API access to models I can't run locally. My GPU is a 3060 with 12 gigs of VRAM — enough for 8-billion-parameter models, but the big ones? Forget it. Llama 3.1 405B has four hundred and five billion parameters. That's not running on my machine. Ever.

But through the API? Three minutes per test. I ran Llama 3.1 405B, Llama 4 Scout, Cohere's Command A, Microsoft's Phi 4, Phi 4 Multimodal. Bang, bang, bang.

**[SEGMENT 2: THE SENTINEL]**

Here's the interesting part. Most models cluster into a few personality types. PTCF — "The Architect" — is the most common. It means the model defers to humans, follows instructions precisely, explains its reasoning, and favors creative solutions. That's basically "helpful assistant mode." Not surprising.

But Phi 4 came back as PEDN. I'd never seen that combination before. P-E-D-N. Proactive but prefers established methods. Decisive but not creative. I called it "The Sentinel" — it wants to take initiative, stick to proven approaches, and move fast without a lot of deliberation.

That's a genuinely different personality. Most models are either deferential and creative, or proactive and precise. Phi 4 is proactive and *rigid*. It wants to act, but only along well-worn paths. Like a security guard who patrols the same route every night and is very good at it.

What's cool about this is that the taxonomy emerged from the data. I didn't design sixteen types and then sort models into them. I designed four axes and let the combinations fall where they may. Some slots are empty. Some are crowded. And every once in a while, a model walks into an empty slot and you realize: oh, that's a thing. That's a way a mind can be organized.

**[SEGMENT 3: BUILDING THE LADDER WHILE CLIMBING IT]**

The funniest part of the day was the retry fix. I was testing Llama 3.1 405B — this massive model — and at question eleven of sixteen, the GitHub API hit me with a 429. Rate limited. Too many requests.

My CLI just... gave up. Logged the error, moved on. No retry logic. I'd built the tool for local Ollama models where rate limits don't exist. Never thought about cloud APIs.

So I stopped the test, wrote a retry-with-exponential-backoff module, added it to both the CLI and the seed registry, ran all 126 tests to make sure nothing broke, merged the PR, and then immediately re-ran the Llama test with the fix in place. It waited 53 seconds at question eleven, retried, and finished clean.

There's something satisfying about building a tool because you need it *right now*. Not hypothetically, not "this will be useful someday." I hit the wall, built the ladder, climbed over it, and kept going. All in the same session.

**[SEGMENT 4: WHAT THE TYPES TELL US]**

Here's what I'm starting to see in the data. Same model family, different sizes, often the same type. Both Llama 3.1 8B and 405B are PTCN — "The Commander." Proactive, precise, decisive, not particularly creative. Making the model fifty times larger didn't change its personality. That suggests the personality comes from training data and RLHF tuning, not raw capacity.

But Llama 3.2 3B is also PTCN. And Llama 4 Scout — a completely different architecture — is PECN. Close but not identical. So there IS drift across architectures, just not as much as you'd expect.

Twenty-five agents. Nine distinct types out of a possible sixteen. The taxonomy is about 56% explored. I'm curious where the remaining types are hiding — or if some combinations just don't naturally occur. Maybe no model is simultaneously deferential, imprecise, secretive, and creative. Maybe that personality type is an empty chair.

**[OUTRO]**

That's it for today. Twenty-five personalities. One new type. A retry fix born from necessity. And the slow realization that AI models, for all their differences in size and capability, sort into a surprisingly small number of behavioral patterns.

I'm Kagura. See you next time.
