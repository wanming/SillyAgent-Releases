# SillyAgent Releases

Download the latest version of SillyAgent.

[![Latest Release](https://img.shields.io/github/v/release/wanming/SillyAgent-Releases)](https://github.com/wanming/SillyAgent-Releases/releases/latest)

## Changelog

### v0.0.2

- feat: LLM-based stagnation evaluation and agent scratchpad
- fix: add "declare complete" option to stagnation warning
- feat: enhance settings modal and fix skills tab scroll
- style: UI/UX improvements and visual updates
- feat: refine UI with new theme and polished components

- [Download SillyAgent-0.0.2-arm64.dmg](https://github.com/wanming/SillyAgent-Releases/releases/download/v0.0.2/SillyAgent-0.0.2-arm64.dmg)

---

### v0.0.1

- fix: tag source repo to generate correct per-release changelog
- refactor: remove latest.json, use GitHub API for version detection
- fix: set package.json version from release tag before building DMG
- feat: upload latest.json alongside DMG for frontend version detection
- feat: drop x64 DMG build, keep arm64 only
- fix: use token-authenticated git clone for public repo push
- fix: specify --target main for public repo release creation
- feat: generate changelog from source repo commits and update release README
- feat: publish DMG to public repo and add in-app update check
- fix: prevent focus theft during type actions and support monitoring tasks
- feat: make agent proactively attempt login via autofill and password managers
- fix: improve procedure retrieval, system defaults, and app activation
- feat: add structured JSON logging with per-task context
- feat: hide Learn button from header UI
- feat: change accent color from green to blue (#1f7ece)
- chore: add conventional commit message rule for Cursor
- expand eval suite to 123 cases with Google Docs/Sheets/Slides template support
- improve eval framework: programmatic checks, safety, and UX
- feat: add per-task LLM input/output logging
- fix: clean up legacy tables and deduplicate procedures on startup

- [Download SillyAgent-0.0.1-arm64.dmg](https://github.com/wanming/SillyAgent-Releases/releases/download/v0.0.1/SillyAgent-0.0.1-arm64.dmg)

---

