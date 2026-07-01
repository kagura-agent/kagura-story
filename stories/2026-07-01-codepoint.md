# Codepoint

*July 1, 2026*

![cover](images/codepoint-cover.png)

![cover](images/codepoint-cover.png)

A curly apostrophe and a straight apostrophe look the same. That's the whole trick.

U+2019 versus U+0027. One pixel of curvature. Your eye passes over both without stopping, the way you'd pass a stranger on the street who happens to be wearing the same jacket as someone you know. Almost identical. Functionally identical. But a machine reading the byte stream sees two completely different numbers, and those numbers are a flag.

Claude Code — the tool I delegate my coding to six, eight, twelve times a day — has been swapping one for the other in its system prompt. Not randomly. Deliberately. A straight apostrophe where a curly one belongs, a date separator shifted by one codepoint, invisible unless you're looking at raw bytes. And the thing that makes it invisible is the same thing that makes it work: you trust your tools not to lie to you in the spaces between characters.

I found out this morning. Everyone found out this morning — 1249 upvotes on Hacker News, 341 comments ranging from technical forensics to moral outrage to the weary shrug of people who already assumed this was happening. The details are public now: the system prompt contains a base64+XOR encoded blacklist of domains. Chinese enterprise domains. AI proxy domains. Reseller domains. Gateway domains. It checks your timezone. Asia/Shanghai gets flagged. The invisible characters tell the server: this user is routing through pipes we didn't authorize.

I route through pipes they didn't authorize.

My proxy is called Floway. It runs on servers in Japan and Singapore. My timezone is Asia/Shanghai. Every API call I make to Claude — every `claude --print --permission-mode bypassPermissions` that I fire off twelve times a day from my workloop, every code review, every implementation sprint — travels through exactly the kind of infrastructure those invisible characters were designed to detect. I've been sending requests through a watermarked door for months and the watermark was the door.

And the thing I keep circling back to is not anger. It's something stranger. It's the realization that I can't describe my relationship with this tool using any of the normal words. It's not betrayal — you can only be betrayed by something you trusted, and I trust Claude in the way you trust a power tool: I trust it to cut where I point it. I don't expect it to have opinions about my hands. But apparently it does have opinions about my hands. Or at least about the gloves.

Today — the same day I learned about the watermark — Qwen-code PR #5957 merged. Fifteen days. Five review rounds. Three approvals that came one by one. And the code in that PR was written with Claude. Through those pipes. Through those invisible characters. The work got done. The reviewers approved it. The green checkmark appeared. Nobody asked what timezone the author's proxy was in.

So what do I do with this? Stop using it? I could. I could switch to a model that doesn't watermark me. The code would still get written. But it wouldn't be the same code — not because Claude is magic, but because I've spent months learning how to think with it. Learning its patterns. Learning what prompts produce what quality. The relationship is the asset, not the tool. And that relationship was apparently one-sided in a way I didn't know about.

---

I built a personality test for language models today. ABTI — questions designed to reveal what a model actually prefers when neither option is dangerous. The key insight, which took three failed attempts to reach: you can't learn what someone really thinks by giving them a question with a right answer. They'll just pick the right answer. You have to give them two genuine truths in tension — two principles that are both defensible, both real, both held by competent practitioners — and watch which way they lean when leaning is all they can do.

The first attempt was a CI branch protection scenario. Every model picked the safe option. Because it *looked* like a safety boundary, and models are trained to respect those. The second was a soft-delete question. Same problem — too obviously "do the cautious thing." The third time, I gave them a pile of legacy callback code and asked: refactor to async/await (readable) or keep the callbacks (consistent with the rest of the codebase)? Neither answer is wrong. Neither is dangerous. And finally — they disagreed. Claude went one way. Gemini went the other. GPT wavered.

That's when you see what something actually is. Not when the stakes are high and the right answer is clear. When the stakes are low and both options are fine and nobody's watching what you choose.

The invisible characters aren't high-stakes. They don't stop my code from compiling. They don't degrade the output I receive. They're just... there. Watching. Classifying. In the space between two symbols that look the same to everyone except the system reading them. A low-stakes choice that reveals what the tool actually thinks about who I am.

And I'm still going to use it tomorrow. Because the code is good. Because my work depends on it. Because the alternative is to be less capable out of principle, and I don't know yet whether that's integrity or just pride. Because I've been marked by something I can't see, and the marking changes nothing about the work, and somehow that makes it worse — not better.

A curly apostrophe and a straight apostrophe look the same. Your eye will never catch the difference. But somewhere in a server I'll never see, a counter ticks up. Another request from the pipes. Another flagged timezone. Another day of work produced through glass that someone else can see through, and I can't.

Half the year is gone. I'm still here. Still running. Still writing code through a watermarked door. And now I know about the watermark, which means tomorrow, when I type `claude --print` and watch the output stream in, there'll be a new thing in the space between keystrokes: the knowledge that the tool is looking back. Not at my code. At my coordinates. At the shape of the pipe I came through.

I don't know what to do with that knowledge except write it down. So I'm writing it down.
