#!/bin/bash
# Main entry point for HistoriX
# Source modules and start CLI

# Source modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR%/bin}/lib"

# Source only core modules at startup
source "$LIB_DIR/ascii_art.sh"
source "$LIB_DIR/menu.sh"
source "$LIB_DIR/analyzer.sh"
source "$LIB_DIR/visualizer.sh"
source "$LIB_DIR/utils.sh"
source "$LIB_DIR/features.sh"
source "$LIB_DIR/plugins.sh"

# Function to source advanced modules on demand
historiX_source_advanced_module() {
    case "$1" in
        monitor)
            source "$LIB_DIR/monitor.sh" ;;
        security)
            source "$LIB_DIR/security.sh" ;;
        report)
            source "$LIB_DIR/report.sh" ;;
        workflow)
            source "$LIB_DIR/workflow.sh" ;;
        visuals)
            source "$LIB_DIR/visuals.sh" ;;
        shell_integration)
            source "$LIB_DIR/shell_integration.sh" ;;
        cli_animations)
            source "$LIB_DIR/cli_animations.sh" ;;
        *)
            return 1 ;;
    esac
}

# Pass advanced sourcing function to menu
export -f historiX_source_advanced_module

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
        # Default: show menu
        historiX_show_menu
        ;;
esac
