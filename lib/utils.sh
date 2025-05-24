# Utility/helper functions for HistoriX

# Core features for HistoriX
# This module provides functions for cross-platform support, shell detection, and history file location

# Detect the user's shell and history file
historiX_detect_shell_and_history() {
    # Default to zsh, then bash, then fish
    if [ -n "$HISTFILE" ] && [ -f "$HISTFILE" ]; then
        echo "$HISTFILE"
    elif [ -f "$HOME/.zsh_history" ]; then
        echo "$HOME/.zsh_history"
    elif [ -f "$HOME/.bash_history" ]; then
        echo "$HOME/.bash_history"
    elif [ -f "$HOME/.history" ]; then
        echo "$HOME/.history"
    elif [ -f "$HOME/.local/share/fish/fish_history" ]; then
        echo "$HOME/.local/share/fish/fish_history"
    else
        echo ""  # Not found
    fi
}

# Utility: Get shell type (bash, zsh, fish, etc.)
historiX_get_shell_type() {
    # Try to detect the current shell
    if [ -n "$ZSH_VERSION" ]; then
        echo "zsh"
    elif [ -n "$BASH_VERSION" ]; then
        echo "bash"
    elif [ -n "$FISH_VERSION" ]; then
        echo "fish"
    else
        # Fallback: parse from SHELL env
        basename "$SHELL"
    fi
}

# Utility: Get history file format (plain, timestamped, fish, etc.)
historiX_get_history_format() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    if [[ "$histfile" == *zsh_history ]]; then
        if grep -q '^:' "$histfile"; then
            echo "zsh-timestamped"
        else
            echo "zsh-plain"
        fi
    elif [[ "$histfile" == *bash_history ]]; then
        if grep -q '^#' "$histfile"; then
            echo "bash-timestamped"
        else
            echo "bash-plain"
        fi
    elif [[ "$histfile" == *fish_history ]]; then
        echo "fish"
    else
        echo "unknown"
    fi
}

# Print detected shell and history file
historiX_show_shell_info() {
    local histfile
    histfile=$(historiX_detect_shell_and_history)
    echo "Detected shell: $SHELL"
    if [ -n "$histfile" ]; then
        echo "History file: $histfile"
    else
        echo "Could not detect a supported shell history file."
    fi
}

# Utility: Print summary of shell, history file, and format
historiX_show_core_summary() {
    local shell histfile format
    shell=$(historiX_get_shell_type)
    histfile=$(historiX_detect_shell_and_history)
    format=$(historiX_get_history_format)
    echo "Shell type:   $shell"
    echo "History file: $histfile"
    echo "Format:       $format"
}

# Load configuration from data/historix.conf
historiX_load_config() {
    local config_file="${LIB_DIR%/lib}/data/historix.conf"
    if [ -f "$config_file" ]; then
        # shellcheck disable=SC1090
        source "$config_file"
    fi
}

# Save a user preference to config file
historiX_set_config() {
    local key="$1"
    local value="$2"
    local config_file="${LIB_DIR%/lib}/data/historix.conf"
    if grep -q "^$key=" "$config_file" 2>/dev/null; then
        sed -i "s|^$key=.*|$key=$value|" "$config_file"
    else
        echo "$key=$value" >> "$config_file"
    fi
}

# Show current config
historiX_show_config() {
    local config_file="${LIB_DIR%/lib}/data/historix.conf"
    if [ -f "$config_file" ]; then
        echo "Current HistoriX configuration:"
        cat "$config_file" | grep -v '^#' | grep -v '^$'
    else
        echo "No configuration file found."
    fi
}
