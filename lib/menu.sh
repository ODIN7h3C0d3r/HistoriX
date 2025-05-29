# Menu bar and CLI interface for HistoriX

# Interactive menu for HistoriX
historiX_show_menu() {
    clear
    historiX_ascii_banner
    historiX_apply_theme
    echo -e "${CYAN}Welcome to HistoriX!${NC}"
    echo "================================================================================"
    echo -e "${YELLOW}Main Menu:${NC}"
    echo -e "[1] Features      [2] Help         [3] Analyze"
    echo -e "[4] Visualize     [5] Export       [6] Cleanup"
    echo -e "[7] Config        [8] Info         [9] Advanced"
    echo "================================================================================"
    echo -e "${CYAN}Tip:${NC} Use numbers to select a category, then follow prompts for sub-options."
    read -p "Select an option [1-9]: " choice
    case $choice in
        1)
            historiX_show_features
            ;;
        2)
            historiX_show_help
            ;;
        3)
            echo -e "${YELLOW}Analysis:${NC}"
            echo -e "  a) Top Commands      b) Usage by Hour      c) Search"
            echo -e "  d) Trend by Month    e) Session Stats      f) Length/Complexity"
            echo -e "  g) Tag Command       h) Filter by Tag      i) Timeline"
            echo -e "  j) Replay Session    k) Predict Next"
            read -p "Select analysis [a-k]: " subchoice
            case $subchoice in
                a|A) historiX_analyze_history ;;
                b|B) historiX_analyze_by_hour ;;
                c|C) historiX_search_history ;;
                d|D) historiX_trend_by_month ;;
                e|E) historiX_session_stats ;;
                f|F) historiX_command_length_complexity ;;
                g|G) historiX_tag_command ;;
                h|H) historiX_filter_by_tag ;;
                i|I) historiX_timeline_drilldown ;;
                j|J) historiX_replay_session ;;
                k|K) historiX_predict_next_command ;;
                *) echo "Invalid analysis option." ;;
            esac
            ;;
        4)
            echo -e "${YELLOW}Visualization:${NC}"
            echo -e "  a) Top Commands Bar Chart   b) Heatmap   c) Pie Chart"
            read -p "Select visualization [a-c]: " subchoice
            case $subchoice in
                a|A) historiX_visualize_top_commands ;;
                b|B) generate_heatmap ;;
                c|C) historiX_visualize_pie_chart ;;
                *) echo "Invalid visualization option." ;;
            esac
            ;;
        5)
            echo -e "${YELLOW}Export:${NC}"
            echo -e "  a) Top Commands CSV   b) Full History JSON   c) Printable Report"
            echo -e "  d) Google Sheets CSV  e) HTML Report"
            read -p "Select export [a-e]: " subchoice
            case $subchoice in
                a|A) historiX_export_top_commands_csv ;;
                b|B) historiX_export_history_json ;;
                c|C) historiX_export_printable_report ;;
                d|D) historiX_export_google_sheets ;;
                e|E) historiX_generate_html_report ;;
                *) echo "Invalid export option." ;;
            esac
            ;;
        6)
            echo -e "${YELLOW}Cleanup:${NC}"
            echo -e "  a) Remove Duplicates   b) Archive Old History   c) Secure Erase"
            read -p "Select cleanup [a-c]: " subchoice
            case $subchoice in
                a|A) historiX_deduplicate_history ;;
                b|B) historiX_archive_old_history ;;
                c|C) historiX_secure_erase ;;
                *) echo "Invalid cleanup option." ;;
            esac
            ;;
        7)
            echo -e "${YELLOW}Config:${NC}"
            echo -e "  a) Show Config   b) Set Config Option   c) Backup History   d) Restore History"
            read -p "Select config [a-d]: " subchoice
            case $subchoice in
                a|A) historiX_show_config ;;
                b|B) read -p "Enter config key: " key; read -p "Enter value for $key: " value; historiX_set_config "$key" "$value"; echo "Config updated." ;;
                c|C) historiX_backup_history ;;
                d|D) historiX_restore_history ;;
                *) echo "Invalid config option." ;;
            esac
            ;;
        8)
            echo -e "${YELLOW}Info:${NC}"
            echo -e "  a) Shell Info   b) Core Summary   c) About   d) List Plugins"
            echo -e "  e) Merge Histories   f) Compare Histories   g) Check Dangerous Cmds   h) Suggest Aliases"
            read -p "Select info [a-h]: " subchoice
            case $subchoice in
                a|A) historiX_show_shell_info ;;
                b|B) historiX_show_core_summary ;;
                c|C) echo "HistoriX - Bash History Analyzer v0.1.0 by Onyx" ;;
                d|D) historiX_list_plugins ;;
                e|E) historiX_merge_histories ;;
                f|F) historiX_compare_histories ;;
                g|G) historiX_check_dangerous_commands ;;
                h|H) historiX_suggest_aliases ;;
                *) echo "Invalid info option." ;;
            esac
            ;;
        9)
            echo -e "${YELLOW}Advanced Features:${NC}"
            echo -e "  a) Real-Time Monitoring   b) Security & Privacy   c) Custom Reports"
            echo -e "  d) Workflow Automation    e) Enhanced Plugins     f) Visual Enhancements"
            echo -e "  g) Shell Integration      h) CLI Animations       i) Back"
            read -p "Select advanced [a-i]: " subchoice
            case $subchoice in
                a|A)
                    historiX_source_advanced_module monitor
                    # Show spinner while monitoring starts
                    historiX_source_advanced_module cli_animations
                    (historiX_monitor_realtime &)
                    spinner $!
                    ;;
                b|B)
                    historiX_source_advanced_module security
                    historiX_security_menu  # You may want to implement a menu for security actions
                    ;;
                c|C)
                    historiX_source_advanced_module report
                    historiX_report_menu  # You may want to implement a menu for report actions
                    ;;
                d|D)
                    historiX_source_advanced_module workflow
                    historiX_workflow_menu  # You may want to implement a menu for workflow actions
                    ;;
                e|E)
                    historiX_source_advanced_module plugins
                    historiX_plugin_manager  # You may want to implement a plugin manager menu
                    ;;
                f|F)
                    historiX_source_advanced_module visuals
                    historiX_visuals_menu  # You may want to implement a menu for visual enhancements
                    ;;
                g|G)
                    historiX_source_advanced_module shell_integration
                    historiX_shell_integration_menu  # You may want to implement a menu for shell integration
                    ;;
                h|H)
                    historiX_source_advanced_module cli_animations
                    historiX_cli_animations_demo  # Demo for CLI animations
                    ;;
                i|I)
                    historiX_show_menu
                    ;;
                *) echo "Invalid advanced option." ;;
            esac
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    echo
    read -p "Press Enter to return to the menu..." _
    historiX_show_menu
}

# Example: Use spinner for long-running or live features
historiX_monitor_realtime() {
    historiX_source_advanced_module cli_animations
    historiX_spinner_start "Monitoring shell history in real time..."
    # Call the actual monitoring logic (assume function exists in monitor.sh)
    _historiX_monitor_realtime_core
    historiX_spinner_stop
}

# Demo for CLI animations
historiX_cli_animations_demo() {
    historiX_spinner_start "Demo: Working..."
    sleep 2
    historiX_spinner_stop
    historiX_progress_bar 100 100 "Demo Complete!"
}

# Security menu for HistoriX advanced features
historiX_security_menu() {
    echo -e "${YELLOW}Security & Privacy:${NC}"
    echo -e "  a) Redact Sensitive Data   b) Encrypted Backup   c) View Audit Log   d) Back"
    read -p "Select security option [a-d]: " subchoice
    case $subchoice in
        a|A)
            read -p "Input file: " infile; read -p "Output file: " outfile
            historiX_redact_sensitive "$infile" "$outfile"
            echo "Sensitive data redacted."
            ;;
        b|B)
            historiX_encrypted_backup
            ;;
        c|C)
            cat "${LIB_DIR%/lib}/data/audit.log"
            ;;
        d|D)
            return
            ;;
        *) echo "Invalid security option." ;;
    esac
    echo
    read -p "Press Enter to return to Security menu..." _
    historiX_security_menu
}

# Report menu for HistoriX advanced features
historiX_report_menu() {
    echo -e "${YELLOW}Custom Reports:${NC}"
    echo -e "  a) Generate Markdown Report   b) Schedule Report   c) Back"
    read -p "Select report option [a-c]: " subchoice
    case $subchoice in
        a|A)
            generate_custom_report
            ;;
        b|B)
            read -p "Enter cron interval (e.g., '0 8 * * *'): " interval
            schedule_report "$interval"
            ;;
        c|C)
            return
            ;;
        *) echo "Invalid report option." ;;
    esac
    echo
    read -p "Press Enter to return to Report menu..." _
    historiX_report_menu
}

# Workflow menu for HistoriX advanced features
historiX_workflow_menu() {
    echo -e "${YELLOW}Workflow Automation:${NC}"
    echo -e "  a) Detect Workflows   b) Export Workflow Script   c) Back"
    read -p "Select workflow option [a-c]: " subchoice
    case $subchoice in
        a|A)
            historiX_detect_workflows
            ;;
        b|B)
            historiX_export_workflow_script
            ;;
        c|C)
            return
            ;;
        *) echo "Invalid workflow option." ;;
    esac
    echo
    read -p "Press Enter to return to Workflow menu..." _
    historiX_workflow_menu
}

# Visuals menu for HistoriX advanced features
historiX_visuals_menu() {
    echo -e "${YELLOW}Visual Enhancements:${NC}"
    echo -e "  a) Generate SVG Chart   b) Back"
    read -p "Select visuals option [a-b]: " subchoice
    case $subchoice in
        a|A)
            historiX_generate_svg_chart
            ;;
        b|B)
            return
            ;;
        *) echo "Invalid visuals option." ;;
    esac
    echo
    read -p "Press Enter to return to Visuals menu..." _
    historiX_visuals_menu
}

# Shell integration menu for HistoriX advanced features
historiX_shell_integration_menu() {
    echo -e "${YELLOW}Shell Integration:${NC}"
    echo -e "  a) Show Prompt Widget   b) Show Completions Stub   c) Back"
    read -p "Select shell integration option [a-c]: " subchoice
    case $subchoice in
        a|A)
            historiX_prompt_widget
            ;;
        b|B)
            historiX_completion
            ;;
        c|C)
            return
            ;;
        *) echo "Invalid shell integration option." ;;
    esac
    echo
    read -p "Press Enter to return to Shell Integration menu..." _
    historiX_shell_integration_menu
}

# CLI animations demo for HistoriX advanced features
historiX_cli_animations_demo() {
    echo -e "${YELLOW}CLI Animations Demo:${NC}"
    echo "  a) Spinner   b) Progress Bar   c) Back"
    read -p "Select animation [a-c]: " subchoice
    case $subchoice in
        a|A)
            (sleep 3 &)
            spinner $!
            ;;
        b|B)
            progress_bar 10
            ;;
        c|C)
            return
            ;;
        *) echo "Invalid animation option." ;;
    esac
    echo
    read -p "Press Enter to return to CLI Animations demo..." _
    historiX_cli_animations_demo
}

# Plugin manager menu for HistoriX advanced features
historiX_plugin_manager() {
    echo -e "${YELLOW}Plugin Manager:${NC}"
    echo -e "  a) List Plugins   b) Load Plugins   c) Back"
    read -p "Select plugin option [a-c]: " subchoice
    case $subchoice in
        a|A)
            historiX_list_plugins
            ;;
        b|B)
            historiX_load_plugins
            echo "Plugins loaded."
            ;;
        c|C)
            return
            ;;
        *) echo "Invalid plugin option." ;;
    esac
    echo
    read -p "Press Enter to return to Plugin Manager..." _
    historiX_plugin_manager
}
