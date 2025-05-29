# Real-time monitoring and live dashboard for HistoriX
# Uses inotifywait or fswatch to watch the history file and print live stats

historiX_monitor_realtime() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Real-Time Monitoring: Press Ctrl+C to stop]"
    if command -v inotifywait >/dev/null 2>&1; then
        while inotifywait -e modify "$histfile" >/dev/null 2>&1; do
            clear
            historiX_analyze_history
        done
    elif command -v fswatch >/dev/null 2>&1; then
        fswatch -o "$histfile" | while read; do
            clear
            historiX_analyze_history
        done
    else
        echo "inotifywait or fswatch required for real-time monitoring."
    fi
}
