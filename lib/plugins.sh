# Plugin loader for HistoriX
# Loads and runs plugins from the plugins/ directory
#
# Plugin API:
#   - Place plugins in plugins/ directory, each as a .sh file.
#   - Each plugin should define at least one function with the prefix historiX_plugin_*
#   - Plugins can declare metadata at the top as comments:
#       # Plugin: Name
#       # Version: 1.0
#       # Author: YourName
#       # Description: ...
#   - Plugin functions are sourced into the main shell for API access.
#   - Use 'export -f' in plugin scripts for function registration if needed.
#   - Use historiX_list_plugin_functions to list all loaded plugin functions.
#   - Use historiX_run_plugin <function_name> to run a plugin by function name.

# Load all plugins (source in main shell for API access)
historiX_load_plugins() {
    local plugin_dir="${LIB_DIR%/lib}/plugins"
    if [ -d "$plugin_dir" ]; then
        for plugin in "$plugin_dir"/*.sh; do
            [ -e "$plugin" ] || continue
            # Source plugin in main shell (functions become available)
            source "$plugin"
            # Optionally, print plugin metadata
            if grep -q '^# Plugin:' "$plugin"; then
                local name version author desc
                name=$(grep '^# Plugin:' "$plugin" | head -1 | cut -d: -f2- | xargs)
                version=$(grep '^# Version:' "$plugin" | head -1 | cut -d: -f2- | xargs)
                author=$(grep '^# Author:' "$plugin" | head -1 | cut -d: -f2- | xargs)
                desc=$(grep '^# Description:' "$plugin" | head -1 | cut -d: -f2- | xargs)
                echo "[PLUGIN] $name v$version by $author - $desc"
            fi
        done
    fi
}

# List available plugins by file name
historiX_list_plugins() {
    local plugin_dir="${LIB_DIR%/lib}/plugins"
    if [ -d "$plugin_dir" ]; then
        echo "Available plugins:"
        for plugin in "$plugin_dir"/*.sh; do
            [ -e "$plugin" ] || continue
            echo "  - $(basename "$plugin")"
        done
    else
        echo "No plugins directory found."
    fi
}

# List all loaded plugin functions (must use historiX_plugin_ prefix)
historiX_list_plugin_functions() {
    declare -F | awk '{print $3}' | grep '^historiX_plugin_'
}

# Call a plugin by function name (must be loaded)
historiX_run_plugin() {
    local func="$1"
    if type "$func" &>/dev/null; then
        "$func"
    else
        echo "Plugin function '$func' not found."
    fi
}
