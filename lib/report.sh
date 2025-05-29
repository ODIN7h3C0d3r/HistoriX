# Custom reports and scheduling for HistoriX

# Generate a custom Markdown report
generate_custom_report() {
    local histfile outfile
    histfile=$(historiX_detect_shell_and_history)
    outfile="${HOME}/historiX_custom_report_$(date +%Y%m%d%H%M%S).md"
    echo "# HistoriX Custom Report\n" > "$outfile"
    echo "## Top Commands\n" >> "$outfile"
    historiX_analyze_history >> "$outfile"
    echo "\n## Session Stats\n" >> "$outfile"
    historiX_session_stats >> "$outfile"
    echo "\nReport generated at $outfile"
}

# Schedule a report using cron
schedule_report() {
    local interval="$1" # e.g., '0 8 * * *' for daily at 8am
    (crontab -l 2>/dev/null; echo "$interval $PWD/bin/historiX.sh --features > $HOME/historiX_scheduled_report.txt 2>&1") | crontab -
    echo "Report scheduled with cron."
}
