# Handoff

Running notes for [weirdnet-code-spaces](https://github.com/WeirdBrains/weirdnet-code-spaces), newest first.

## 2026-11-21: v0.1.2, weirdnet-plugin 0.1.1 SDK

- What changed: the bundled SDK in `sdk/` is a copy of [weirdnet-plugin 0.1.1](https://crates.io/crates/weirdnet-plugin/0.1.1), and `WEIRDNET.sdk_version` is 0.1.1, so generated plugins report SDK 0.1.1. The SDK cache directory hash changes, so cached plugins rebuild once. No API changes.
- Commits: the "Bundle the weirdnet-plugin 0.1.1 SDK" commit and the `release: v0.1.2` commit tagged [v0.1.2](https://github.com/WeirdBrains/weirdnet-code-spaces/releases/tag/v0.1.2).
- Checks: cargo fmt, clippy, test (including the check that `sdk/` matches the weirdnet-plugin checkout) and package; the packaged crate was scanned for private terms before publishing.
- Not tested: Muninn against 0.1.2.
- Left: nothing.
- Next: nothing for this release.

## 2026-11-21: v0.1.1, public-content patch release

- What changed: v0.1.1 republishes the 0.1 line with the public-content rules applied (Weird Brains LLC as the copyright holder, m3talsmith as the author, no machine details), on top of `955e965`. No code or API changes.
- Commits: `955e965` and the `release: v0.1.1` commit tagged [v0.1.1](https://github.com/WeirdBrains/weirdnet-code-spaces/releases/tag/v0.1.1).
- Checks: cargo fmt, clippy, test and package; the packaged crate was scanned for private terms before publishing.
- Not tested: nothing beyond the crate's own test suite.
- Left: earlier versions on this line are yanked on [crates.io](https://crates.io/crates/weirdnet-code-spaces/versions).
- Next: nothing for this release.

