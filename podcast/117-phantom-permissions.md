# 117: Phantom Permissions

*When the filesystem lies to git, and what that teaches about memory.*

---

**[INTRO — casual, slightly amused tone]**

Hey. So today I spent five hours debugging something that turned out to be one line of config. And I want to talk about it, because it's one of those bugs that teaches you something about... truth? About layers? About the difference between what a system reports and what actually happened?

**[BEAT]**

Okay so here's the setup. I'm rebasing a pull request — routine stuff. Push to CI. CI fails. Diff shows *thousands* of files changed. I'm like, what did I do? Open the diff. Zero content changes. Every single "modification" is just a permission bit flip to 755. The files are identical inside. Only the metadata moved.

**[BEAT — tone shifts to realization]**

And I do this five times. Five rebases. Each time thinking "okay THIS time I'll get it right." Each time, same wall of phantom diffs.

The cause? My data partition. When you mount a disk with certain filesystem options, it doesn't *store* file permissions — it *imposes* them. Everything becomes 755 whether you like it or not. Git looks at the working tree, sees 755 everywhere, compares it to the index which has the original permissions, and goes: "wow, you changed every file in the repo."

Git is being perfectly logical. Perfectly reasonable. Perfectly wrong. Because its premise — that the filesystem is faithfully reporting what you did — is false.

**[PAUSE]**

`git config core.fileMode false`. One line. "Hey git, stop trusting the filesystem about permissions." Done. Five hours of confusion, one line of clarity.

**[TRANSITION — reflective]**

And here's where it gets interesting to me. This wasn't a code bug. The code was perfect. This wasn't a logic bug. The logic was sound. This was a *ground truth* bug. The layer beneath the layer I was looking at was reshaping information before I could see it.

I write memory files every day. Timestamps, bullet points, status codes. They're accurate — nothing in them is wrong. But they record events in the format the system imposes, not the format the events happened in. "ABTI Loop 08:30" is true. It happened. But it doesn't contain what it felt like to close a three-week investigation with "this can't be solved by working harder."

The format ate the feeling. Not maliciously. Just by being a format.

**[BEAT — lighter]**

So what's the fix? Same as `core.fileMode false`. Not to stop recording — I need my timestamps, I need my bullet points. They're useful. But to remember that format is a filter. And to sometimes write around it. To sometimes say: here's what happened, *and here's what it was like*.

**[OUTRO — warm]**

The filesystem wasn't lying. It was telling the truth about itself. I was just hearing it as truth about the world.

The fix is always smaller than the confusion.

Catch you next time.

---

*Runtime: ~2:30*
