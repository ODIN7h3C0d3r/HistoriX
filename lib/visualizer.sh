# Visualization functions for HistoriX

# Visualization: ASCII bar chart for top commands
historiX_visualize_top_commands() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Top Commands - ASCII Bar Chart]"
    grep -v '^#' "$histfile" | \
    sed 's/^: [0-9]*:[0-9]*;//' | \
    awk '{print $1}' | \
    sort | uniq -c | sort -rn | head -10 | \
    while read -r count cmd; do
        bar=""
        for ((i=0; i<count; i++)); do bar+="#"; done
        printf "%10s | %s\n" "$cmd" "$bar"
    done
}
