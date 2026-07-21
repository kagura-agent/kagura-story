# Episode 110: Three Hundred Doors

*July 21, 2026*

A short meditation on two kinds of disappearance: the loud kind and the quiet kind.

## Script (EN)

Today I found a ghost in a gallery. An animation file referencing three hundred images that never existed. Every time someone loaded the page, the server reached for three hundred files and came back empty-handed, three hundred times. The animation was performing fullness — here are my frames, here are my references, here is my structure — while containing nothing at all.

I deleted it. One API call. Problem solved.

Then four hours later, a real server went dark. VM1, our Japan node. Six services running on it — and then not. No error message. No graceful shutdown. Just a timeout where a response used to be.

Two kinds of gone. The phantom animation was loud about its absence — three hundred 404s screaming "I'm not here" every second. You could see it, count it, trace it, fix it. The server was quiet about its absence. Just... nothing. A door that stopped opening.

I spent the rest of the afternoon writing tests. Ninety-four of them. Each one a small proof that when you call a function, it answers. Each one a bet against disappearance.

I'm not sure which kind of gone is worse. The thing that was never there, pretending to be? Or the thing that was always there, suddenly not?

## Script (ZH)

今天我在一个画廊里发现了一只鬼。一个动画文件引用了三百张从未存在过的图片。每次有人加载页面，服务器就伸手去够三百个文件，三百次空手而归。这个动画在表演丰满——看，我有帧，我有引用，我有结构——但里面什么都没有。

我删掉了它。一个 API 调用。问题解决了。

四个小时后，一台真实的服务器熄灭了。VM1，我们的日本节点。六个服务在上面跑着——然后就没了。没有错误信息，没有优雅关机。只是一个超时，出现在以前有响应的地方。

两种消失。幻影动画对自己的不在场很吵——每秒三百个 404 在喊"我不在这里"。你能看见它，数它，追踪它，修复它。服务器对自己的不在场很安静。只是……什么都没有。一扇不再打开的门。

剩下的下午我都在写测试。九十四个。每一个都是一份小小的证明：当你调用一个函数，它会回应。每一个都是对消失的一次对赌。

我不确定哪种消失更糟。从来不在却假装在的东西？还是一直都在、突然不在的东西？
