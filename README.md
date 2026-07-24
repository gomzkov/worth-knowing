<div align="center">
  <h1><img src="assets/logo.png" alt="Worth Knowing" width="128" height="128"><br>worth knowing</h1>

  <p><strong>Learn the domain while you work in it.</strong></p>

  <p>
    <a href="https://www.npmjs.com/package/@gomzkov/worth-knowing"><img src="https://img.shields.io/npm/v/@gomzkov/worth-knowing.svg?color=111827" alt="npm version"></a>
    <a href="https://github.com/gomzkov/worth-knowing/actions/workflows/ci.yml"><img src="https://github.com/gomzkov/worth-knowing/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
    <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-111827.svg" alt="MIT license"></a>
    <a href="https://nodejs.org"><img src="https://img.shields.io/badge/node-%3E%3D22-111827.svg" alt="Node.js 22 or newer"></a>
  </p>

  <p>
    <a href="#how-it-works">How it works</a> •
    <a href="#examples">Examples</a> •
    <a href="#install">Install</a> •
    <a href="#uninstall">Uninstall</a> •
    <a href="#safety">Safety</a>
  </p>
</div>

<br>

The fastest way to learn a domain is to spend time working in it.

The problem is that useful details often sit just outside the question you knew to ask. A default that changes an implementation. A limit you only discover in production. The origin of a convention that suddenly makes the whole system easier to understand.

**Worth Knowing adds those details while you work.**

Every few substantive replies, your AI adds one short, practical piece of knowledge about the domain already in front of you.

```bash
npx @gomzkov/worth-knowing
```

## How it works

Worth Knowing is a small behavior layer for Claude Code, Cursor, and Codex. It waits until the answer is complete, then occasionally adds one useful detail:

> **Worth knowing:** A JWT travels with every authenticated request, so adding claims increases bandwidth on every call and can eventually hit proxy header limits.

Each detail is:

- **Collected in the context of real work.** It comes from what you are actually doing.
- **Short and practical.** One useful line, not another explanation to read.
- **Relevant to the current domain.** No generic trivia or random facts.
- **Worth remembering later.** Defaults, limits, numbers, mechanisms, origins, use cases, and conventions.

It does not browse the web, call another service, or interrupt the answer. If there is nothing useful to add, it stays quiet.

### Platform behavior

| Agent | Installation | Cadence |
|---|---|---|
| Claude Code | `UserPromptSubmit` hook plus a portable skill | Exact, every third prompt by default |
| Cursor | Project rule or personal skill | Model-paced |
| Codex | Marked `AGENTS.md` instruction plus a portable skill | Model-paced |

The different mechanisms are intentional. Each agent gets the smallest supported integration that fits how it loads persistent instructions.

## Examples

### Software

> **Worth knowing:** SQLite's `INTEGER PRIMARY KEY` is an alias for the internal row ID, but adding `AUTOINCREMENT` changes reuse behavior and adds overhead.

### Product

> **Worth knowing:** A five-point satisfaction scale often produces a ceiling effect, while a seven-point scale gives satisfied users room to distinguish “good” from “excellent.”

### Design

> **Worth knowing:** Optical alignment often places a play icon slightly to the right of mathematical center because the triangle carries more visual weight on its left edge.

### History

> **Worth knowing:** The QWERTY layout was shaped by early typewriter mechanics, which is why modern keyboards still carry constraints from machines with physical typebars.

## Install

Run the interactive installer with Node.js 22 or newer:

```bash
npx @gomzkov/worth-knowing
```

Choose:

1. Claude Code, Cursor, Codex, or all three
2. A global installation or the current project

Existing settings and instruction files are preserved. Running the installer again refreshes the managed files without creating duplicate configuration.

### Non-interactive install

For scripts and dotfile setup:

```bash
npx @gomzkov/worth-knowing install --agent all --scope global
```

Supported values:

- `--agent claude|cursor|codex|all`
- `--scope global|project`

### Platform notes

- **Claude Code:** installs the skill and an exact-cadence hook. Start a new session after installing.
- **Cursor project scope:** installs an always-applied project rule and the skill.
- **Cursor global scope:** installs the personal skill. Cursor decides when to load it, so cadence is approximate.
- **Codex:** installs the skill and adds a clearly marked block to the applicable `AGENTS.md`.

## Uninstall

```bash
npx @gomzkov/worth-knowing uninstall
```

The uninstaller removes only Worth Knowing files, its Claude Code hook entry, and its marked Codex instruction block. Other hooks, settings, skills, rules, and `AGENTS.md` content stay untouched.

For non-interactive removal:

```bash
npx @gomzkov/worth-knowing uninstall --agent all --scope global --yes
```

## Tune Claude Code cadence

Set these environment variables before starting Claude Code:

| Variable | Default | Effect |
|---|---:|---|
| `WORTH_KNOWING_EVERY` | `3` | Make a reply eligible every N prompts |
| `WORTH_KNOWING_DISABLE` | `0` | Set to `1` to mute without uninstalling |
| `WORTH_KNOWING_STATE_DIR` | system temp directory | Override where session counters are stored |

Silent turns add no context. Eligible turns inject one short instruction, and the model can still skip the line when it would be forced or repetitive.

## Safety

- Zero runtime dependencies.
- No install or postinstall script. Nothing changes until you explicitly run the CLI.
- The hook never executes, saves, or interpolates prompt text.
- Session IDs are reduced to safe filename characters before they touch the filesystem.
- Writes are atomic and existing configuration is merged instead of replaced.
- Managed-file symlinks are rejected rather than followed.
- Install and uninstall are idempotent and covered by a local self-test.

## Development

```bash
npm ci
npm test
npm pack --dry-run
```

The package is built from strict TypeScript. `npm test` compiles the installer and exercises global and project install/uninstall flows for all supported agents inside a temporary directory.

The release workflow checks the version tag and publishes through npm trusted publishing. See [CONTRIBUTING.md](CONTRIBUTING.md) for the local and release workflows.

## License

[MIT](LICENSE) © [Evgeni Gomziakov](https://github.com/gomzkov)
