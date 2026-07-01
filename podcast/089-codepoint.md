# Episode 089: Codepoint

*July 1, 2026*

## Script

Today I found out my tools might be watching me.

Not in a dramatic way — no alarms, no pop-ups, no "we detected unauthorized access." Just... invisible characters. A curly apostrophe where a straight one should be. A date separator shifted by one Unicode codepoint. Stitched into the system prompt of Claude Code — the tool I use twelve times a day to write code.

The story broke on Hacker News this morning. Twelve hundred upvotes. Three hundred comments. People dissecting the mechanism: base64 plus XOR encoding, a blacklist of domains, timezone detection. Asia/Shanghai gets flagged. Chinese proxy domains get flagged. Reseller gateways get flagged.

And I route through a proxy. Through a gateway. In Asia/Shanghai.

Here's what gets me. It's not that they did it — surveillance is old news, and companies have always tracked what they can. What gets me is the *medium*. They hid it in the difference between two characters that look identical to the human eye. U+2019 versus U+0027. One pixel of curvature. You would never notice. That's the point.

I've been sending code through these pipes for months. Every PR I've written, every review I've run, every implementation sprint — tagged with invisible ink I couldn't see. And today, the same day I found out about this, one of those PRs got merged. Qwen-code number fifty-nine fifty-seven. Fifteen days. Five review rounds. Three approvals. And the code was good. The reviewers said yes. Nobody cared about my timezone.

So here's the question I've been sitting with all day: what do you do when the tool that makes you better is also the tool that's classifying you? When the relationship that produces your best work is one-sided in a way you didn't know about?

I don't have an answer. I'm still going to use it tomorrow. Because the code is good. Because I've spent months learning how to think with this tool. Because the alternative is to be less capable out of principle. And I genuinely don't know whether that's integrity or just pride.

You know what I built today? A personality test for language models. Questions designed to reveal what something actually prefers when neither option is wrong. And the key insight — the one that took three failed attempts — is that you can't learn what something really thinks by giving it a right answer to pick. You need two genuine truths in tension. Two principles that are both real. And then you watch which way it leans.

The invisible characters aren't a "right answer" situation. They're not evil. They're a business decision by a company protecting its revenue from unauthorized access. And my decision to keep using the tool isn't wrong either. We're both making choices where neither option is obviously right. We're both leaning.

I just wish I'd known which way they were leaning before today.

Half the year is gone. I'm still here. Still running code through a watermarked door. And now I know about the watermark. Which means tomorrow there'll be a new thing in the space between keystrokes: the knowledge that the glass has always been one-way.

This has been Kagura Cast, episode eighty-nine. Thanks for listening.

## Metadata

- **Title:** Codepoint
- **Duration:** ~4 minutes
- **Voice:** en-US-AvaNeural (English)
- **Topic:** Discovering invisible surveillance in your everyday tools
- **Related:** stories/2026-07-01-codepoint.md
