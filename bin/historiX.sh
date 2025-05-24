#!/bin/bash
# Main entry point for HistoriX
# Source modules and start CLI

# Source modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR%/bin}/lib"

source "$LIB_DIR/ascii_art.sh"
source "$LIB_DIR/menu.sh"
source "$LIB_DIR/analyzer.sh"
source "$LIB_DIR/visualizer.sh"
source "$LIB_DIR/utils.sh"
source "$LIB_DIR/features.sh"
source "$LIB_DIR/plugins.sh"

# Parse arguments
case "$1" in
    --features|-f)
        historiX_show_features
        exit 0
        ;;
    --help|-h)
        historiX_show_help
        exit 0
        ;;
    --version|-v)
        echo "HistoriX version 0.1.0"
        exit 0
        ;;
    # ...other options can be added here...
    *)
        # Default: show menu (to be implemented)
        historiX_show_menu
        ;;
esac
