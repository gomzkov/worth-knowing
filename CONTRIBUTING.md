# Contributing

Thanks for helping improve Oh, That's Cool.

## Local setup

You need Node.js 18 or newer.

```bash
npm install
npm test
```

Before opening a pull request:

1. Keep the package zero-dependency at runtime.
2. Preserve unrelated user configuration during install and uninstall.
3. Add or update self-test coverage for installer behavior.
4. Run `npm test`.
5. Run `npm pack --dry-run` and check the file list.

## Pull requests

Keep changes focused. Explain what changed, why it matters, and how you verified it.

Do not include generated `dist/` files. The package builds during `npm pack` and release.

## Reporting problems

Use a GitHub issue for reproducible bugs and feature requests. Use GitHub's private vulnerability reporting for security problems.
