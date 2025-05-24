# ASCII art and banners for HistoriX

# ASCII art banner for HistoriX
historiX_ascii_banner() {
    # Color codes
    RED='\033[1;31m'
    YELLOW='\033[1;33m'
    CYAN='\033[1;36m'
    NC='\033[0m' # No Color
    VERSION="v0.1.0"
    echo -e "${RED}"
    cat << 'EOF'

██╗  ██╗██╗███████╗████████╗ ██████╗ ██████╗ ██╗██╗  ██╗
██║  ██║██║██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██║╚██╗██╔╝
███████║██║███████╗   ██║   ██║   ██║██████╔╝██║ ╚███╔╝ 
██╔══██║██║╚════██║   ██║   ██║   ██║██╔══██╗██║ ██╔██╗ 
██║  ██║██║███████║   ██║   ╚██████╔╝██║  ██║██║██╔╝ ██╗
╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝
EOF
    echo -e "${CYAN}                HistoriX - Bash History Analyzer${NC}"
    echo -e "${YELLOW}                        ${VERSION}${NC}\n"
}

# Help menu for HistoriX
historiX_show_help() {
    historiX_ascii_banner
    cat << EOF
Usage: historiX.sh [OPTION]

Options:
  -h, --help        Show this help menu
  -f, --features    Show the features list
  -v, --version     Show version information

Description:
  HistoriX is a modular Bash script to analyze and visualize shell history across Linux, Unix, macOS, NSD, and Android (Termux).
  Use the interactive menu for more options and analysis tools.

Examples:
  ./historiX.sh --features
  ./historiX.sh --help

EOF
}
