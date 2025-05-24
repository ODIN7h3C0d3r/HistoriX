# Menu bar and CLI interface for HistoriX

# Interactive menu for HistoriX
historiX_show_menu() {
    clear
    historiX_ascii_banner
    echo "Welcome to HistoriX!"
    echo "====================="
    echo "1) Show Features"
    echo "2) Help"
    echo "3) Analyze History (coming soon)"
    echo "   a) Top Commands"
    echo "   b) Usage by Hour"
    echo "4) Visualize History (coming soon)"
    echo "   a) Top Commands Bar Chart"
    echo "5) Exit"
    echo "6) Show Shell Info"
    echo "7) Core Summary"
    echo "8) Show Config"
    echo "9) Set Config Option"
    echo
    read -p "Select an option [1-9]: " choice
    case $choice in
        1)
            historiX_show_features
            ;;
        2)
            historiX_show_help
            ;;
        3)
            echo "a) Top Commands"
            echo "b) Usage by Hour"
            read -p "Select analysis [a-b]: " subchoice
            case $subchoice in
                a|A)
                    historiX_analyze_history
                    ;;
                b|B)
                    historiX_analyze_by_hour
                    ;;
                *)
                    echo "Invalid analysis option."
                    ;;
            esac
            ;;
        4)
            echo "a) Top Commands Bar Chart"
            read -p "Select visualization [a]: " subchoice
            case $subchoice in
                a|A)
                    historiX_visualize_top_commands
                    ;;
                *)
                    echo "Invalid visualization option."
                    ;;
            esac
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        6)
            historiX_show_shell_info
            ;;
        7)
            historiX_show_core_summary
            ;;
        8)
            historiX_show_config
            ;;
        9)
            read -p "Enter config key: " key
            read -p "Enter value for $key: " value
            historiX_set_config "$key" "$value"
            echo "Config updated."
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    echo
    read -p "Press Enter to return to the menu..." _
    historiX_show_menu
}
