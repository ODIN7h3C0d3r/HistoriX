# Shell integration for HistoriX
# Show most used command in prompt, completions, etc.

historiX_prompt_widget() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    local topcmd
    topcmd=$(grep -v '^#' "$histfile" | awk '{print $1}' | sort | uniq -c | sort -rn | head -1 | awk '{print $2}')
    echo "[HistoriX] Most used: $topcmd"
}

# Example: Add to .zshrc or .bashrc
# PROMPT='$(historiX_prompt_widget) %~ %# '

# Shell completions (stub)
historiX_completion() {
    echo "# TODO: Implement shell completions for HistoriX commands."
}
