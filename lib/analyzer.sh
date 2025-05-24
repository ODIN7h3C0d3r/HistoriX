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

# Export: Full history as JSON
historiX_export_history_json() {
    local histfile outfile
    histfile=$(historiX_detect_shell_and_history)
    outfile="${HOME}/historiX_full_history_$(date +%Y%m%d%H%M%S).json"
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Exporting full history as JSON]"
    echo '[' > "$outfile"
    grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{gsub("\"", "\\\""); printf "  \"%s\",\n", $0}' | sed '$ s/,$//' >> "$outfile"
    echo ']' >> "$outfile"
    echo "Full history exported to $outfile"
}

# Export: Printable report (text)
historiX_export_printable_report() {
    local histfile outfile
    histfile=$(historiX_detect_shell_and_history)
    outfile="${HOME}/historiX_report_$(date +%Y%m%d%H%M%S).txt"
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[HistoriX Report]" > "$outfile"
    echo "Top Commands:" >> "$outfile"
    grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print $1}' | sort | uniq -c | sort -rn | head -10 >> "$outfile"
    echo >> "$outfile"
    echo "Session Stats:" >> "$outfile"
    # Simple session stats (count)
    grep -v '^#' "$histfile" | wc -l | awk '{print "Total commands:", $1}' >> "$outfile"
    echo "Report exported to $outfile"
}

# Session and Duration Stats: Analyze session lengths and idle times
historiX_session_stats() {
    local histfile histfmt
    histfile=$(historiX_detect_shell_and_history)
    histfmt=$(historiX_get_history_format)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Session and Duration Stats]"
    if [[ "$histfmt" == zsh-timestamped ]]; then
        awk -F: '/^:/ {t=$2; getline cmd; print t}' "$histfile" | \
        awk '{if(NR==1) {start=$1; prev=$1} else {if($1-prev>1800) {print prev, $1, $1-prev}; prev=$1}}' | \
        awk '{print "Session: ", strftime("%c", $1), "-", strftime("%c", $2), "Duration:", int(($2-$1)/60) " min"}'
    elif [[ "$histfmt" == bash-timestamped ]]; then
        awk '/^#/ {t=substr($0,2); getline cmd; print t}' "$histfile" | \
        awk '{if(NR==1) {start=$1; prev=$1} else {if($1-prev>1800) {print prev, $1, $1-prev}; prev=$1}}' | \
        awk '{print "Session: ", strftime("%c", $1), "-", strftime("%c", $2), "Duration:", int(($2-$1)/60) " min"}'
    else
        echo "Session stats require timestamped history."
    fi
}

# Command Length & Complexity: Show longest/shortest and most complex commands
historiX_command_length_complexity() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Longest Commands]"
    grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print length, $0}' | sort -nr | head -5
    echo
    echo "[Shortest Commands]"
    grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print length, $0}' | sort -n | head -5
    echo
    echo "[Most Complex Commands (by pipes/args)]"
    grep -v '^#' "$histfile" | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print gsub(/\|/,"|") + NF, $0}' | sort -nr | head -5
}

# Archive old history (move to archive file with timestamp)
historiX_archive_old_history() {
    local histfile archivefile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    archivefile="${histfile}.archive.$(date +%Y%m%d%H%M%S)"
    cp "$histfile" "$archivefile"
    echo > "$histfile"
    echo "History archived to $archivefile and current history cleared."
}

# Securely erase sensitive commands (by keyword)
historiX_secure_erase() {
    local histfile keyword tmpfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    read -p "Enter keyword to securely erase from history: " keyword
    tmpfile="${histfile}.tmp"
    grep -v "$keyword" "$histfile" > "$tmpfile"
    shred -u "$histfile"
    mv "$tmpfile" "$histfile"
    echo "All commands containing '$keyword' have been securely erased."
}

# Maintenance: Backup and restore history
historiX_backup_history() {
    local histfile backupfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    backupfile="${histfile}.backup.$(date +%Y%m%d%H%M%S)"
    cp "$histfile" "$backupfile"
    echo "Backup created: $backupfile"
}

historiX_restore_history() {
    local histfile backupfile
    histfile=$(historiX_detect_shell_and_history)
    read -p "Enter backup file to restore: " backupfile
    if [ ! -f "$backupfile" ]; then
        echo "Backup file not found."
        return 1
    fi
    cp "$backupfile" "$histfile"
    echo "History restored from $backupfile."
}

# Multi-user and multi-host support: Merge and analyze multiple history files
historiX_merge_histories() {
    local files merged_file
    read -p "Enter paths to history files (space-separated): " files
    merged_file="${HOME}/historiX_merged_history_$(date +%Y%m%d%H%M%S).txt"
    cat $files > "$merged_file"
    echo "Merged history saved to $merged_file"
}

historiX_compare_histories() {
    local file1 file2
    read -p "Enter first history file: " file1
    read -p "Enter second history file: " file2
    if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
        echo "Both files must exist."
        return 1
    fi
    echo "Commands unique to $file1:"
    grep -vxFf "$file2" "$file1"
    echo
    echo "Commands unique to $file2:"
    grep -vxFf "$file1" "$file2"
}

# Command tagging and annotation: Tag commands in history
historiX_tag_command() {
    local histfile tag pattern
    histfile=$(historiX_detect_shell_and_history)
    read -p "Enter pattern to tag: " pattern
    read -p "Enter tag: " tag
    awk -v pat="$pattern" -v tag="$tag" '{if($0~pat){print $0 " #tag:" tag} else {print $0}}' "$histfile" > "$histfile.tagged"
    mv "$histfile.tagged" "$histfile"
    echo "Commands matching '$pattern' tagged as '$tag'."
}

# Filter by tag
historiX_filter_by_tag() {
    local histfile tag
    histfile=$(historiX_detect_shell_and_history)
    read -p "Enter tag to filter: " tag
    grep "#tag:$tag" "$histfile"
}

# Notifications: Alert on dangerous commands
historiX_check_dangerous_commands() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Checking for dangerous commands...]"
    grep -E 'rm -rf /|:(){:|:&};:|dd if=|mkfs|:(){:|:&};:|wget http|curl http' "$histfile" && \
    echo "Warning: Dangerous command(s) found!" || echo "No dangerous commands detected."
}

# Suggest aliases for frequently used long commands
historiX_suggest_aliases() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [ -z "$histfile" ]; then
        echo "No history file found."
        return 1
    fi
    echo "[Alias Suggestions for Long Commands]"
    grep -v '^#' "$histfile" | awk 'length($0)>30' | sort | uniq -c | sort -rn | head -5 | awk '{print "alias cmd" NR "=\"" substr($0, index($0,$2)) "\""}'
}
