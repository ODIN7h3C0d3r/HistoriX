# HistoriX

A modular, cross-platform Bash script to analyze and visualize shell history with a beautiful CLI, advanced analytics, and extensibility.

## Features

- **Cross-Platform & Multi-Shell**: Linux, macOS, Android (Termux), NSD; supports bash, zsh, fish, etc.
- **Interactive CLI**: Colorful ASCII art, 3x3 grid menu, keyboard navigation, and submenus.
- **History Analysis**: Top/least used commands, time-based usage, session stats, command complexity, search/filter, trends, tagging, and more.
- **Visualization**: ASCII bar charts, heatmaps, pie charts.
- **Export & Reporting**: CSV, JSON, printable text, HTML, Google Sheets-ready.
- **Customization**: Config file for preferences, theming, plugin system.
- **Maintenance**: Backup/restore, deduplication, archiving, secure erase.
- **Advanced Tools**: Multi-user/host merge/compare, dangerous command alerts, alias suggestions, session replay, ML insights.

## Usage

1. **Run the main script:**

   ```sh
   ./bin/historiX.sh
   ```

2. **Navigate the menu:**
   - Use numbers to select a main category (Features, Help, Analyze, etc.).
   - Follow prompts for sub-options (e.g., [a-k] for analysis).

3. **Command-line options:**
   - `--help` or `-h`: Show help
   - `--features` or `-f`: Show features list
   - `--version` or `-v`: Show version

## Configuration

Edit `data/historix.conf` to set preferences:

```sh
THEME=dark
HISTORY_LIMIT=100
SHOW_ASCII_ART=yes
EXPORT_FORMAT=csv
```

## Plugins

- Place `.sh` plugin scripts in the `plugins/` directory.
- Use the Info menu to list loaded plugins.

## Example Workflows

- **Find your most used commands:** Analyze → a
- **Visualize usage by hour:** Visualize → b
- **Export top commands for Google Sheets:** Export → d
- **Replay a session as a script:** Analyze → j
- **Tag and filter commands:** Analyze → g/h
- **Check for dangerous commands:** Info → g

## Release Checklist

- [x] Modular structure: `bin/`, `lib/`, `data/`, `plugins/`, `test/`, `docs/`
- [x] Interactive, colorful CLI menu with submenus
- [x] Core analysis: frequency, time, session, complexity, search, trends
- [x] Visualizations: bar chart, heatmap, pie chart
- [x] Export: CSV, JSON, text, HTML, Google Sheets
- [x] Config file and theming
- [x] Plugin system and example plugin
- [x] Maintenance: backup, restore, dedup, archive, secure erase
- [x] Advanced: multi-user/host, tagging, alerts, alias suggestions, replay, ML
- [x] Logging and error reporting
- [x] Test scripts in `test/`
- [x] Fully explained documentation (this file)
- [x] All features accessible from menu and CLI

## Contributing

- Fork, branch, and submit PRs for new features or plugins.
- See `lib/plugins.sh` for plugin API.

## License

MIT
