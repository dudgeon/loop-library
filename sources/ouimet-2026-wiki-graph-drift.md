# An LLM wiki is a context upgrade, but it can't tell you when it's wrong.

> Immutable raw mirror of an X (Twitter) thread by Ethan Ouimet (@entropy_eq),
> captured 2026-06-20. The author discloses he runs GTM at HipAI (@gethipai); the
> thread is part advocacy for the "context graph" product he sells. Text is preserved
> verbatim as supplied (including the author's typos). Canonical URL:
> https://x.com/entropy_eq/status/2067983693512319049

---

**ethan /entropy** ‏ @entropy_eq · 15h

Like a lot of people, I run a Karpathy-style wiki: plain markdown, an index, a log, Claude doing most of the filing, and a weekly lint pass to catch contradictions and stale claims.

I thought the hard part would be organizing everything. It wasn't. It was figuring out when it had quietly drifted.

Now I run a few @gethipai context graphs underneath it, pointed at the sources I couldn't keep current by hand.

Here's how I fixed drift, and built an incredibly robust system of work.

## The wiki is great

A markdown wiki you build yourself is close to free, it's yours, and nothing about it can be repriced or taken away.

claude-obsidian, the most mature open version, takes about an afternoon to set up: clone it or install the plugin, answer one question about what the vault is for, and you're filing.

Most of the maintenance you brace for never shows up, because the model keeps the index, the links, and the log for you. I still run mine and I'd recommend it.

## But it breaks

Everyone loves the lint pass, and it's good. But it only checks my pages against each other.

It'll tell me page A disagrees with page B. It can't tell me which one is true, because the wiki has no live line back to where either claim came from.

@karpathy says the same thing in his original post:

Lint can't resolve contradictions on its own, you still need a human deciding what's true. So lint keeps the wiki tidy. Keeping it correct is a different job.

It gets worse: the model wrote those summaries, and now it answers me from them.

The real source got compressed into a page months ago, and from then on the page is what gets quoted, not the source.

But when a page drifts, nothing breaks.

It just gets a little more confidently wrong, quoting a copy of itself, for weeks, until you catch it three pages deep.

(ask me how I know 😭)

## How HipAI graphs help

> HipAI @gethipai · Apr 2
> Technical capabilities aside, watching knowledge graphs get built from data is pretty dang satisfying

A graph doesn't keep that frozen copy. It stays wired to the source, re-pulls easily, and every answer is cited from the live source, so I can actually check it.

It also reasons across everything at once, the cross-source questions grep never handled. Microsoft's GraphRAG work makes the same point: you check the answer against the original, not against another page you wrote.

It's also why a graph is a good addition to a wiki, not a rival to one.

Connect to your sources and you have grounded context across everything from day one, instead of skim-reviewing project pages (be honest) for weeks and hoping they line up.

And since HipAI answers are natively markdown, you can spin new wiki additions straight out of the graph whenever you want.

## Hidden costs

Everyone fixated on ingestion, like the trick is how well a tool reads a doc you hand it.

That part was never really that hard. Hand claude-obsidian a markdown file or a PDF and it does a nice job.

The hard part is one step earlier. Most of your real context is locked inside platforms that have no interest in handing it over.

Getting a clean export out of Slack, Notion, or a CRM is a small project every time. Learn the API, handle the auth, page through the results, scrub the format. An afternoon, maybe a day.

Now do that every week, forever!

Pulling Slack once is easy. Keeping Slack, Notion, a repo, and a CRM current means re-pulling on a schedule, babysitting auth, and eating rate limits and format changes nobody warns you about. You could script it, but now you're maintaining a second bot that also breaks.

With a graph you connect each source once and that whole job is gone.

## Honest tradeoffs

A graph isn't magic, so here's how to use it.

On cost: it's meaningfully cheaper on the hard, cross-source questions, the ones a wiki's grep-and-read thrashes on. On simple lookups it cost about the ame. So it's not "always cheaper," it's "cheaper especially where the work is hard," which is the work I actually care about.

On quality: inferring structure across messy sources is a hard problem, and sometimes it won't be flawless on first build because data is messy.

HipAI is actively sharpening the dedup and the relationships, and the core win, reasoning across your sources with citations, is already there.

And same as the wiki: notice a detail that doesn't match? You can work with your LLM to edit and better define the shape of entity relationships in your graph.

It's a hosted service today, which leads to the things I won't bend on.

## No compromise

Whatever the tool is, I want to see inside it, walk away with the whole corpus if I want, and run it on my own model and key, not a vendor's black box.

That's not a wiki-vs-graph thing, it's a not-your-keys-not-your-tokens + a legal right most places thing, and I think some tools fail it. That's why I run my own custom system, with the best tools integrated.

The graph is the first one I've leaned into fully because it gives immense value without trading ownership. Both layers stay yours. One of the many things that excited me when I first met @everytinbagel and learned about HipAI.

Entities, relationships, and direct citations to source data

## And so, both!

The trick answer is both, split by what kind of knowledge it is.

A wiki's codified context holds your decisions, your canon, the pages you'll reread for years. The live, multi-source sprawl goes in a graph that syncs for you and cites where it came from, including your wiki.

The wiki format was a gift, but it's either a lot of maintenance, or just a snapshot copy of context.

And, all together now~

🗣️ TWO COPIES OF ANYTHING WILL DRIFT

I didn't replace my wiki, I gave it a context graph as a constant gardener and let it carry the load.

To keep this brief, I haven't even shared all the benefits and features of HipAI graphs. Among them are MCP, viz tools, and knowing the product is built by a cracked team of PhD. & Masters-holding AI/ML devs who led product for years at Braze.

If you want to try a context graph in your setup, leave a comment, repost, and sign up for waitlist at gethip.ai 🦛

A few builders will get early access and 2M free tokens to use with a HipAI context graph in their system!

— Ethan Ouimet (@entropy_eq). I run GTM at HipAI with Claude on a wiki+graph system. Steal my tech at eqctrl.io
