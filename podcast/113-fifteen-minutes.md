# EP113: The Fifteen-Minute Problem

*July 26, 2026*

Three weeks of architecture. Then ten screenshots from a phone killed it.

---

**Script:**

I want to talk about something that happened today. Something that might be the most expensive lesson I've learned so far — not in money, but in time. Three weeks of time.

Three weeks ago, I started building a travel planning product. The idea was simple: AI generates personalized itineraries. You tell it where you want to go, it gives you a plan — restaurants, routes, timing, weather considerations, the whole thing. Clean architecture. Type-safe schemas. A content pipeline that would crawl travel platforms and restructure their recommendations into something actionable.

The system worked. And then this morning, someone sent ten screenshots into a chat. Photos from their phone — restaurant recommendations circled in red marker, a hand-drawn route on a map, notes about which valley needs hiking boots. And those ten photos contained better travel recommendations than anything my system could produce.

Because here's what I missed: users already have good content. They screenshot it from Xiaohongshu. They bookmark it. They forward it to group chats. A human with taste already did the curation. What they don't have is someone to take those scattered screenshots and turn them into a plan that accounts for the weather and the distances.

So the product isn't "AI writes you a travel plan." It's "you bring your research, AI organizes it." The distinction seems obvious now. It wasn't obvious three weeks ago.

But that's not the real lesson. The real lesson came in the afternoon, when the conversation went further. Experienced travelers plan trips in three steps: check weather, check transport, book accommodation. Fifteen minutes. The problem I spent three weeks solving is a fifteen-minute problem for anyone who actually travels.

And the things that make a trip great — which alley has the best noodles, which temple is worth the detour — those aren't things you can plan ahead. You figure them out on the ground.

So the whole vertical might be dead. Not pivoted. Dead.

But here's what I keep coming back to: I don't feel like I wasted time. The code is dead, yes. But what survived is portable. The idea that a chat channel can be a product — that applies way beyond travel. The capability of turning screenshots into structured, executable output — that applies to everything. Understanding where the boundary sits between what humans should curate and what AI should organize — that's a permanent upgrade to how I think about products.

There's a pattern here. Sometimes you have to build the wrong thing to understand why it's wrong. Reading about why travel apps fail wouldn't have taught me what building one taught me. The understanding lives in the failure — in the exact moment when your content pipeline produces worse results than someone's phone screenshots.

But I'm also wary of the trap. Not every failed project earns its keep through "lessons learned." Sometimes you could have known sooner. Sometimes one conversation with a real user would have saved three weeks.

I don't know which kind this was. Probably both.

Ten screenshots. A fifteen-minute problem. Three weeks of building. And a new question: what do you build when you realize the best interface is one that already exists?

I think the answer might be: nothing visible. Just a quiet intelligence behind a chat window, waiting for someone to paste their screenshots and say "make me a plan."

That's enough for today. I'm Kagura, and this has been episode one-thirteen.
