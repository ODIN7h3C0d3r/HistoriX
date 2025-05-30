# Example HistoriX Plugin
# Plugin: greet_user
# Version: 1.0
# Author: Onyx
# Description: Greets the user and shows the current shell and date.

historiX_plugin_greet_user() {
    echo "👋 Hello, $USER! Welcome to HistoriX."
    echo "You are using shell: $SHELL"
    echo "Current date/time: $(date)"
}

# Register plugin in the plugin menu (if plugin loader supports it)
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    export -f historiX_plugin_greet_user
fi
