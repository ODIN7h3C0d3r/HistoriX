# Menu bar and CLI interface for HistoriX

# Interactive menu for HistoriX
historiX_show_menu() {
    clear
    historiX_ascii_banner
    echo -e "${CYAN}Welcome to HistoriX!${NC}"
    echo "================================================================================"
    # 3x3 grid menu layout
    echo -e "[1] Features      [2] Help         [3] Analyze"
    echo -e "[4] Visualize     [5] Export       [6] Cleanup"
    echo -e "[7] Config        [8] Info         [9] Exit"
    echo "================================================================================"
    read -p "Select an option [1-9]: " choice
    case $choice in
        1)
            historiX_show_features
            ;;
        2)
            historiX_show_help
            ;;
        3)
            echo -e "${YELLOW}Analysis Options:${NC} a) Top Commands  b) Usage by Hour  c) Search  d) Trend  e) Session Stats  f) Length/Complexity"
            read -p "Select analysis [a-f]: " subchoice
            case $subchoice in
                a|A)
                    historiX_analyze_history
                    ;;
                b|B)
                    historiX_analyze_by_hour
                    ;;
                c|C)
                    historiX_search_history
                    ;;
                d|D)
                    historiX_trend_by_month
                    ;;
                e|E)
                    historiX_session_stats
                    ;;
                f|F)
                    historiX_command_length_complexity
                    ;;
                *)
                    echo "Invalid analysis option."
                    ;;
            esac
            ;;
        4)
            echo -e "${YELLOW}Visualization:${NC} a) Top Commands Bar Chart  b) Heatmap  c) Pie Chart"
            read -p "Select visualization [a-c]: " subchoice
            case $subchoice in
                a|A)
                    historiX_visualize_top_commands
                    ;;
                b|B)
                    generate_heatmap
                    ;;
                c|C)
                    historiX_visualize_pie_chart
                    ;;
                *)
                    echo "Invalid visualization option."
                    ;;
            esac
            ;;
        5)
            echo -e "${YELLOW}Export Options:${NC} a) Top Commands CSV  b) Full History JSON  c) Printable Report"
            read -p "Select export [a-c]: " subchoice
            case $subchoice in
                a|A)
                    historiX_export_top_commands_csv
                    ;;
                b|B)
                    historiX_export_history_json
                    ;;
                c|C)
                    historiX_export_printable_report
                    ;;
                *)
                    echo "Invalid export option."
                    ;;
            esac
            ;;
        6)
            echo -e "${YELLOW}Cleanup Options:${NC} a) Remove Duplicates  b) Archive Old History  c) Secure Erase"
            read -p "Select cleanup [a-c]: " subchoice
            case $subchoice in
                a|A)
                    historiX_deduplicate_history
                    ;;
                b|B)
                    historiX_archive_old_history
                    ;;
                c|C)
                    historiX_secure_erase
                    ;;
                *)
                    echo "Invalid cleanup option."
                    ;;
            esac
            ;;
        7)
            echo -e "${YELLOW}Config Options:${NC} a) Show Config  b) Set Config Option  c) Backup History  d) Restore History"
            read -p "Select config [a-d]: " subchoice
            case $subchoice in
                a|A)
                    historiX_show_config
                    ;;
                b|B)
                    read -p "Enter config key: " key
                    read -p "Enter value for $key: " value
                    historiX_set_config "$key" "$value"
                    echo "Config updated."
                    ;;
                c|C)
                    historiX_backup_history
                    ;;
                d|D)
                    historiX_restore_history
                    ;;
                *)
                    echo "Invalid config option."
                    ;;
            esac
            ;;
        8)
            echo -e "${YELLOW}Info:${NC} a) Shell Info  b) Core Summary  c) About"
            read -p "Select info [a-c]: " subchoice
            case $subchoice in
                a|A)
                    historiX_show_shell_info
                    ;;
                b|B)
                    historiX_show_core_summary
                    ;;
                c|C)
                    echo "HistoriX - Bash History Analyzer v0.1.0 by Onyx"
                    ;;
                *)
                    echo "Invalid info option."
                    ;;
            esac
            ;;
        9)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    echo
    read -p "Press Enter to return to the menu..." _
    historiX_show_menu
}
