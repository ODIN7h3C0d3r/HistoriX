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

# Validate configuration values and warn about invalid settings
historiX_validate_config() {
    local valid=1
    # Validate theme
    case "$theme" in
        default|dark|light|solarized) : ;;
        *) echo "Warning: Invalid theme '$theme' in config."; valid=0 ;;
    esac
    # Validate dangerous_alerts
    case "$dangerous_alerts" in
        yes|no) : ;;
        *) echo "Warning: Invalid dangerous_alerts value '$dangerous_alerts'."; valid=0 ;;
    esac
    # Validate plugins_enabled
    case "$plugins_enabled" in
        yes|no) : ;;
        *) echo "Warning: Invalid plugins_enabled value '$plugins_enabled'."; valid=0 ;;
    esac
    # Validate default_report_format
    case "$default_report_format" in
        markdown|html|csv|json) : ;;
        *) echo "Warning: Invalid default_report_format '$default_report_format'."; valid=0 ;;
    esac
    # Validate audit_log
    case "$audit_log" in
        yes|no) : ;;
        *) echo "Warning: Invalid audit_log value '$audit_log'."; valid=0 ;;
    esac
    return $valid
}

# Logging and error reporting utility
historiX_log() {
    local msg level
    msg="$1"
    level="${2:-INFO}"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $msg" >> "${LIB_DIR%/lib}/data/historiX.log"
}

# Theming support: set color scheme from config
historiX_apply_theme() {
    local theme=${THEME:-default}
    if [ "$DISABLE_COLOR" = "yes" ]; then
        export CYAN=''; export YELLOW=''; export RED=''; export NC=''
        return
    fi
    case "$theme" in
        dark)
            export CYAN='\033[1;36m'
            export YELLOW='\033[1;33m'
            export RED='\033[1;31m'
            export NC='\033[0m'
            ;;
        light)
            export CYAN='\033[1;34m'
            export YELLOW='\033[1;35m'
            export RED='\033[1;31m'
            export NC='\033[0m'
            ;;
        *)
            export CYAN='\033[1;36m'
            export YELLOW='\033[1;33m'
            export RED='\033[1;31m'
            export NC='\033[0m'
            ;;
    esac
}

# Example usage in analyzer (add to critical actions):
# historiX_log "Archived history to $archivefile" "INFO"
# historiX_log "Failed to find history file" "ERROR"
