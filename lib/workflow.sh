# Workflow and automation for HistoriX

# Detect common command sequences (workflows)
historiX_detect_workflows() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    echo "[Workflows: Most common command sequences]"
    grep -v '^#' "$histfile" | awk 'NR>1{print prev, $1} {prev=$1}' | sort | uniq -c | sort -rn | head -10
}

# Export workflow as shell script
historiX_export_workflow_script() {
    local histfile outfile
    histfile=$(historiX_detect_shell_and_history)
    outfile="${HOME}/historiX_workflow_$(date +%Y%m%d%H%M%S).sh"
    grep -v '^#' "$histfile" | awk '{print $0}' | head -20 > "$outfile"
    chmod +x "$outfile"
    echo "Workflow script exported to $outfile"
}
