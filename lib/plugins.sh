# Plugin loader for HistoriX
# Loads and runs plugins from the plugins/ directory

historiX_load_plugins() {
    local plugin_dir="${LIB_DIR%/lib}/plugins"
    if [ -d "$plugin_dir" ]; then
        for plugin in "$plugin_dir"/*.sh; do
            [ -e "$plugin" ] || continue
            source "$plugin"
        done
    fi
}

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
