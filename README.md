# HistoriX

![GitHub release (latest by date)](https://img.shields.io/github/v/release/ODIN7h3C0d3r/HistoriX?style=for-the-badge)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/ODIN7h3C0d3r/HistoriX/test.yml?style=for-the-badge)
![License: MIT](https://img.shields.io/github/license/ODIN7h3C0d3r/HistoriX?style=for-the-badge)
![Platform](https://img.shields.io/badge/platform-linux%20%7C%20macos%20%7C%20unix%20%7C%20android-blue?style=for-the-badge)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh%20%7C%20fish-green?style=for-the-badge)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=for-the-badge)

---

> **HistoriX** is the ultimate modular, extensible, and visually stunning Bash toolkit for analyzing, visualizing, and mastering your shell history. Designed for everyone—from casual users to power users and developers—HistoriX brings deep analytics, real-time monitoring, security, workflow automation, plugin extensibility, and beautiful ASCII/TUI/graphical output to your terminal.

---

## Table of Contents

- [Audience Sectors](#audience-sectors)
- [Feature Overview](#feature-overview)
- [Deep Dive: Feature Explanations](#deep-dive-feature-explanations)
- [Architecture & Diagrams](#architecture--diagrams)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Plugins & Extensibility](#plugins--extensibility)
- [Testing & Quality](#testing--quality)
- [Security & Privacy](#security--privacy)
- [Release Checklist](#release-checklist)
- [Developer & Modder Codemode](#developer--modder-codemode)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

---

## Audience Sectors


### 🟢 Normal Users

- Effortless, menu-driven analytics and visualization of your shell history.
- One-command setup, beautiful ASCII art, and safe defaults.


### 🟡 Power Users

- Advanced analytics, real-time monitoring, workflow detection, custom reports, and export.
- Tagging, session replay, dangerous command alerts, and multi-user/host support.


### 🔴 Developers & Modders

- Modular codebase, plugin API, shell integration, workflow automation, and code hooks.
- Full documentation, code comments, and developer-friendly structure.

---

## Feature Overview

| Category         | Features                                                                 |
|-----------------|--------------------------------------------------------------------------|
| **Core**        | Interactive CLI, ASCII art, theming, config, help, version, features      |
| **Analytics**   | Top commands, usage by hour, trends, session stats, complexity, dedup     |
| **Visualization** | ASCII bar/heatmap/pie, SVG/PNG export, printable/HTML reports           |
| **Export**      | CSV, JSON, text, Google Sheets, Markdown, HTML                           |
| **Security**    | Redaction, encrypted backup, audit log, secure erase                     |
| **Advanced**    | Real-time monitoring, workflow detection, session replay, ML insights     |
| **Plugins**     | Loader, metadata, versioning, sandboxing, plugin menu                    |
| **Shell Integration** | Prompt widget, completions, TUI widgets                             |
| **Automation**  | Workflow export, cron scheduling, backup/restore, archive                 |
| **Testing**     | Test suite, logging, audit                                               |

---

## Deep Dive: Feature Explanations


### 1. Interactive CLI & Menu System

- **Modern TUI:** 3x3 grid, colorized, keyboard-driven, with section headers and tips.
- **ASCII Art Banner:** Dynamic, colorized, and versioned. Instantly recognizable.
- **Configurable Themes:** Change color schemes and menu styles via `data/historix.conf`.


### 2. Analytics & Insights

- **Top Commands:** See your most-used commands, with frequency and trends.
- **Usage by Hour/Day/Month:** Heatmaps and bar charts show when you’re most active.
- **Session Stats:** Analyze session durations, command counts, and productivity.
- **Command Complexity:** Detect long/complex commands and optimize your workflow.
- **Deduplication:** Remove duplicate entries for cleaner analytics.
- **Tagging & Search:** Tag commands, search by keyword, regex, or date.
- **Trends & Patterns:** Visualize command usage over time, spot habits and anomalies.
- **Session Replay:** Replay command sessions for training or audit.
- **ML Insights:** Markov-based prediction of next likely commands.


### 3. Visualization

- **ASCII Charts:** Bar, pie, and heatmap visualizations directly in your terminal.
- **SVG/PNG Export:** Generate graphical charts using gnuplot for reports or sharing.
- **Printable/HTML Reports:** Export beautiful, shareable reports for documentation or review.


### 4. Real-Time Monitoring

- **Live Dashboard:** Watch your history file in real time (inotifywait/fswatch).
- **Instant Stats:** See analytics update as you work.
- **CLI Animations:** Spinners and progress bars for long-running/live features.


### 5. Security & Privacy

- **Redaction:** Automatically redact sensitive data (passwords, tokens, secrets) before export.
- **Encrypted Backup:** One-command GPG encryption for your history file.
- **Audit Log:** Every sensitive action is logged for review and compliance.
- **Secure Erase:** Safely delete history with confirmation and audit.


### 6. Export & Reporting

- **Multi-format Export:** CSV, JSON, text, HTML, Markdown, Google Sheets.
- **Custom Reports:** Build and schedule custom reports (Markdown, HTML, etc.) via cron.
- **Anonymization:** Remove or mask sensitive data before sharing.


### 7. Workflow Automation

- **Workflow Detection:** Find and export common command sequences as reusable scripts.
- **Session Replay:** Re-run or share your most productive sessions.
- **Automation Hooks:** Integrate with cron, backup, and external tools.


### 8. Plugin System

- **Loader & Manager:** Discover, load, and manage plugins from the menu.
- **Metadata & Versioning:** Plugins declare compatibility and version.
- **Sandboxing:** Plugins run in a controlled environment for safety.
- **Example Plugin:** See `plugins/example_plugin.sh` for a template.


### 9. Shell Integration

- **Prompt Widget:** Show analytics or tips in your shell prompt.
- **Completions Stub:** Start building custom completions for your favorite shell.
- **TUI Widgets:** Extend the menu with your own widgets.


### 10. Maintenance & Multi-User

- **Backup/Restore:** One-command backup and restore of your history.
- **Archive:** Move old history to safe storage.
- **Multi-user/host:** Merge and compare histories across systems.
- **Dangerous Command Alerts:** Warn about risky commands in your history.
- **Alias Suggestions:** Get smart alias recommendations based on usage.


### 11. Testing & Quality

- **Test Suite:** Automated tests for all features and edge cases.
- **Logging:** All actions and errors are logged for review.
- **Audit:** Security and privacy actions are always auditable.

---

## Architecture & Diagrams

### Modular Structure

```mermaid

graph TD;
    A[bin/historiX.sh (main)] --> B1(lib/ascii_art.sh)
    A --> B2(lib/menu.sh)
    A --> B3(lib/analyzer.sh)
    A --> B4(lib/visualizer.sh)
    A --> B5(lib/utils.sh)
    A --> B6(lib/features.sh)
    A --> B7(lib/plugins.sh)
    A -. on demand .-> C1(lib/monitor.sh)
    A -. on demand .-> C2(lib/security.sh)
    A -. on demand .-> C3(lib/report.sh)
    A -. on demand .-> C4(lib/workflow.sh)
    A -. on demand .-> C5(lib/visuals.sh)
    A -. on demand .-> C6(lib/shell_integration.sh)
    A -. on demand .-> C7(lib/cli_animations.sh)
    B7 --> D1(plugins/)
    A --> E1(data/historix.conf)
    A --> F1(test/test_basic.sh)

```

- **bin/historiX.sh:** Main entry, argument parsing, menu, and dynamic module sourcing.
- **lib/**: All features are modularized for maintainability and extensibility.
- **plugins/**: Drop-in plugins, loaded and managed via menu.
- **data/**: Config, audit log, and backups.
- **test/**: Automated test suite for CI and manual runs.

---

## Installation

```sh

git clone https://github.com/ODIN7h3C0d3r/HistoriX.git
cd HistoriX
chmod +x bin/historiX.sh

```

---

## Usage

### For Normal Users

```sh
./bin/historiX.sh
```

- Use the menu to explore features, analytics, and reports.
- No configuration required for basic use.

### For Power Users

- Use command-line options:

```sh
./bin/historiX.sh --help
./bin/historiX.sh --features
./bin/historiX.sh --version
```

- Edit `data/historix.conf` for advanced theming and preferences.
- Schedule reports, automate exports, and use advanced analytics.

### For Developers & Modders

- Explore the modular codebase in `lib/` and `bin/`.
- Add new features as modules, or extend the menu.
- Write plugins in `plugins/` with metadata and versioning.
- Use the provided test suite and logging for robust development.

---

## Configuration

- All user preferences, theming, and history file locations are set in `data/historix.conf`.
- Supports per-user and per-host overrides.

---

## Plugins & Extensibility

- Drop plugins in the `plugins/` directory.
- Use the Plugin Manager from the Advanced menu to list/load plugins.
- Plugins declare metadata, version, and compatibility.
- Example plugin: `plugins/example_plugin.sh`
- Plugins are sandboxed for safety.

---

## Testing & Quality

- Run the test suite:

```sh
bash test/test_basic.sh
```

- Tests all features, menu paths, and edge cases.
- CI-ready and logs all results.

---

## Security & Privacy

- Redact sensitive data before export.
- Encrypted backups with GPG.
- All sensitive actions are logged in `data/audit.log`.
- Secure erase and audit for compliance.

---

## Release Checklist

- [x] All features accessible from menu
- [x] All modules documented and tested
- [x] Plugin system and examples included
- [x] README and LICENSE present
- [x] Test suite passes
- [x] Code committed and pushed to GitHub

---

## Developer & Modder Codemode

### Project Structure

```text
HistoriX/
├── bin/
│   └── historiX.sh
├── lib/
│   ├── ascii_art.sh
│   ├── analyzer.sh
│   ├── cli_animations.sh
│   ├── features.sh
│   ├── menu.sh
│   ├── monitor.sh
│   ├── plugins.sh
│   ├── report.sh
│   ├── security.sh
│   ├── shell_integration.sh
│   ├── utils.sh
│   ├── visualizer.sh
│   ├── visuals.sh
│   └── workflow.sh
├── plugins/
│   └── example_plugin.sh
├── data/
│   └── historix.conf
├── test/
│   └── test_basic.sh
├── LICENSE
└── README.md
```

### Adding a New Feature Module

- Create a new `lib/yourfeature.sh`.
- Add a function (e.g., `historiX_yourfeature_menu`) and source it on demand in `bin/historiX.sh`.
- Add a menu entry in `lib/menu.sh`.
- Document your feature in the README.

### Writing a Plugin

- Place your script in `plugins/`.
- Add metadata at the top:

```bash
# Plugin: MyPlugin
# Version: 1.0
# Author: YourName
# Description: What this plugin does
```

- Use only safe, POSIX-compliant Bash.
- Avoid modifying user files unless necessary.

### Testing Your Code

- Add tests to `test/test_basic.sh`.
- Use `set -e` and output validation for robust checks.

### Contributing

- Fork, branch, and submit PRs with clear descriptions.
- Follow the modular structure and code style.

---

## How to Contribute

Pull requests, issues, and suggestions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) if available.

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

## Credits

Created by ODIN7h3C0d3r.ASCII art and menu design inspired by the open source community.

---

## Diagrams & Visuals

- See the [docs/](docs/) directory for more diagrams, screenshots, and usage examples.
- Example architecture diagram above uses Mermaid (rendered on GitHub or VS Code).

---
