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
