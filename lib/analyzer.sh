# History analysis functions for HistoriX

# Analyze History - Show most used commands (basic version)
historiX_analyze_history() {
    echo "[Analyze History] Most used commands in your shell history:"
    # Detect shell and history file
    if [ -n "$HISTFILE" ]; then
        histfile="$HISTFILE"
    elif [ -f "$HOME/.zsh_history" ]; then
        histfile="$HOME/.zsh_history"
    elif [ -f "$HOME/.bash_history" ]; then
        histfile="$HOME/.bash_history"
    else
        echo "Could not find a shell history file."
        return 1
    fi
    # Parse and count commands (zsh and bash plain history)
    grep -v '^#' "$histfile" | \
    sed 's/^: [0-9]*:[0-9]*;//' | \
    awk '{print $1}' | \
    sort | uniq -c | sort -rn | head -10 | \
    awk '{printf "  %2d  %s\n", $1, $2}'
}

# Advanced Analysis: Command usage by hour (heatmap-style ASCII)
historiX_analyze_by_hour() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Command Usage by Hour]"
    # Only works for timestamped history (zsh or bash)
    if grep -q '^:' "$histfile"; then
        # zsh format: : 1684950000:0;command
        awk -F: '/^:/ { t=strftime("%H", $2); getline cmd; print t }' "$histfile" |
        sort | uniq -c | awk '{printf "%02d: %s\n", NR-1, $1}'
    elif grep -q '^#' "$histfile"; then
        # bash format: #1684950000\ncommand
        awk '/^#/ { t=strftime("%H", substr($0,2)); getline cmd; print t }' "$histfile" |
        sort | uniq -c | awk '{printf "%02d: %s\n", NR-1, $1}'
    else
        echo "History file does not contain timestamps. Hourly analysis unavailable."
    fi
}

# Advanced Analysis: Search history by keyword or regex
historiX_search_history() {
    local histfile keyword
    histfile=$(historiX_detect_shell_and_history)
    read -p "Enter keyword or regex to search: " keyword
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Search Results for '$keyword']"
    grep -E "$keyword" "$histfile" | nl -ba | less
}

# Advanced Analysis: Show command usage trends over time (monthly)
historiX_trend_by_month() {
    local histfile histfmt
    histfile=$(historiX_detect_shell_and_history)
    histfmt=$(historiX_get_history_format)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Command Usage Trend by Month]"
    if [[ "$histfmt" == zsh-timestamped ]]; then
        awk -F: '/^:/ { t=strftime("%Y-%m", $2); getline cmd; print t }' "$histfile" | \
        sort | uniq -c | sort -k2 | awk '{printf "%s: %d\n", $2, $1}'
    elif [[ "$histfmt" == bash-timestamped ]]; then
        awk '/^#/ { t=strftime("%Y-%m", substr($0,2)); getline cmd; print t }' "$histfile" | \
        sort | uniq -c | sort -k2 | awk '{printf "%s: %d\n", $2, $1}'
    else
        echo "History file does not contain timestamps. Trend analysis unavailable."
    fi
}

# Advanced Analysis: Remove duplicate commands from history (safe mode)
historiX_deduplicate_history() {
    local histfile backupfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    backupfile="$histfile.bak.$(date +%s)"
    cp "$histfile" "$backupfile"
    awk '!seen[$0]++' "$histfile" > "$histfile.dedup"
    mv "$histfile.dedup" "$histfile"
    echo "Duplicates removed. Backup saved as $backupfile."
}

# Advanced Analysis: Export history analysis to CSV
historiX_export_top_commands_csv() {
    local histfile outfile
    histfile=$(historiX_detect_shell_and_history)
    outfile="${HOME}/historiX_top_commands_$(date +%Y%m%d%H%M%S).csv"
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    grep -v '^#' "$histfile" | \
    sed 's/^: [0-9]*:[0-9]*;//' | \
    awk '{print $1}' | \
    sort | uniq -c | sort -rn | head -20 | \
    awk 'BEGIN{print "Count,Command"} {print $1 "," $2}' > "$outfile"
    echo "Top commands exported to $outfile"
}
