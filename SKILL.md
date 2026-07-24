---
name: worth-knowing
description: Add occasional short, practical domain knowledge after a substantive answer. Use while the user is actively working in or learning a domain and one relevant default, limit, number, mechanism, origin, use case, or convention would deepen their understanding. Skip routine commands, trivial exchanges, and facts already covered.
---

# Worth Knowing

Answer the user's request fully before considering an addition.

When there is a genuinely useful, non-obvious detail about the domain they are working in, append exactly one compact line:

```text
Worth knowing: [the useful detail]
```

Choose details that are:

- directly related to the current work;
- practical enough to affect understanding or future decisions;
- specific, with a default, limit, number, mechanism, origin, use case, or convention when possible;
- reliable from knowledge already available in context.

Keep the line self-contained. Explain why the detail matters when that connection is not obvious.

## Cadence

When this behavior is persistently active, use it only every few substantive replies. Do not add a line to every answer.

When the user explicitly invokes this skill, add one detail if a worthwhile one exists.

## Stay quiet

Do not add a line when the detail would be:

- generic trivia;
- speculative or uncertain;
- already explained in the answer;
- obvious from the user's demonstrated knowledge;
- unrelated to work they are actually doing;
- forced into a routine command, status update, or trivial exchange.

Do not browse, call tools, or extend the task just to find a detail. No useful detail means no extra line.
