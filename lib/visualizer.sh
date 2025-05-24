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

# Visualization: ASCII heatmap for command usage by hour and day
generate_heatmap() {
    local histfile histfmt
    histfile=$(historiX_detect_shell_and_history)
    histfmt=$(historiX_get_history_format)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Heatmap: Commands by Hour and Day]"
    if [[ "$histfmt" == zsh-timestamped ]]; then
        awk -F: '/^:/ {h=strftime("%H", $2); d=strftime("%a", $2); getline; print d, h}' "$histfile" |
        awk '{count[$1][$2]++} END {for(d in count) {printf "%s ", d; for(h=0;h<24;h++) printf "%3d", count[d][sprintf("%02d",h)]+0; print ""}}' | sort
    elif [[ "$histfmt" == bash-timestamped ]]; then
        awk '/^#/ {t=substr($0,2); getline; h=strftime("%H", t); d=strftime("%a", t); print d, h}' "$histfile" |
        awk '{count[$1][$2]++} END {for(d in count) {printf "%s ", d; for(h=0;h<24;h++) printf "%3d", count[d][sprintf("%02d",h)]+0; print ""}}' | sort
    else
        echo "Heatmap requires timestamped history."
    fi
}

# Visualization: ASCII pie chart (textual) for top commands
historiX_visualize_pie_chart() {
    local histfile total
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Pie Chart: Top Commands]"
    total=$(grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print $1}' | wc -l)
    grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print $1}' | sort | uniq -c | sort -rn | head -5 | \
    awk -v total="$total" '{pct=($1/total)*100; printf "%10s : %3d (%2.1f%%) ", $2, $1, pct; for(i=0;i<pct/2;i++) printf "●"; print ""}'
}
