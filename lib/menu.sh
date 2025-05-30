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
            # Show features list
            historiX_show_features
            ;;
        2)
            # Show help menu
            historiX_show_help
            ;;
        3)
            # Analysis submenu with input validation and 'q' shortcut
            echo -e "${YELLOW}Analysis:${NC}"
            echo -e "  a) Top Commands      b) Usage by Hour      c) Search"
            echo -e "  d) Trend by Month    e) Session Stats      f) Length/Complexity"
            echo -e "  g) Tag Command       h) Filter by Tag      i) Timeline"
            echo -e "  j) Replay Session    k) Predict Next"
            while true; do
                read -p "Select analysis [a-k, q to quit]: " subchoice
                case $subchoice in
                    a|A) historiX_analyze_history ;; # Top commands
                    b|B) historiX_analyze_by_hour ;; # Usage by hour
                    c|C) historiX_search_history ;; # Regex/keyword search
                    d|D) historiX_trend_by_month ;; # Trend by month
                    e|E) historiX_session_stats ;; # Session stats
                    f|F) historiX_command_length_complexity ;; # Command complexity
                    g|G) historiX_tag_command ;; # Tag command
                    h|H) historiX_filter_by_tag ;; # Filter by tag
                    i|I) historiX_timeline_drilldown ;; # Timeline drilldown
                    j|J) historiX_replay_session ;; # Session replay
                    k|K) historiX_predict_next_command ;; # ML prediction
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid analysis option. Type a-k or q to quit." ;;
                esac
            done
            ;;
        4)
            # Visualization submenu with input validation and 'q' shortcut
            echo -e "${YELLOW}Visualization:${NC}"
            echo -e "  a) Top Commands Bar Chart   b) Heatmap   c) Pie Chart"
            while true; do
                read -p "Select visualization [a-c, q to quit]: " subchoice
                case $subchoice in
                    a|A) historiX_visualize_top_commands ;; # ASCII bar chart
                    b|B) generate_heatmap ;; # Heatmap
                    c|C) historiX_visualize_pie_chart ;; # Pie chart
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid visualization option. Type a-c or q to quit." ;;
                esac
            done
            ;;
        5)
            # Export submenu with input validation and 'q' shortcut
            echo -e "${YELLOW}Export:${NC}"
            echo -e "  a) Top Commands CSV   b) Full History JSON   c) Printable Report"
            echo -e "  d) Google Sheets CSV  e) HTML Report"
            while true; do
                read -p "Select export [a-e, q to quit]: " subchoice
                case $subchoice in
                    a|A) historiX_export_top_commands_csv ;;
                    b|B) historiX_export_history_json ;;
                    c|C) historiX_export_printable_report ;;
                    d|D) historiX_export_google_sheets ;;
                    e|E) historiX_generate_html_report ;;
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid export option. Type a-e or q to quit." ;;
                esac
            done
            ;;
        6)
            # Cleanup submenu with input validation and 'q' shortcut
            echo -e "${YELLOW}Cleanup:${NC}"
            echo -e "  a) Remove Duplicates   b) Archive Old History   c) Secure Erase"
            while true; do
                read -p "Select cleanup [a-c, q to quit]: " subchoice
                case $subchoice in
                    a|A) historiX_deduplicate_history ;;
                    b|B) historiX_archive_old_history ;;
                    c|C) historiX_secure_erase ;;
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid cleanup option. Type a-c or q to quit." ;;
                esac
            done
            ;;
        7)
            # Config submenu with reload option and input validation
            echo -e "${YELLOW}Config:${NC}"
            echo -e "  a) Show Config   b) Set Config Option   c) Backup History   d) Restore History   e) Reload Config"
            while true; do
                read -p "Select config [a-e, q to quit]: " subchoice
                case $subchoice in
                    a|A) historiX_show_config ;;
                    b|B) read -p "Enter config key: " key; read -p "Enter value for $key: " value; historiX_set_config "$key" "$value"; echo "Config updated." ;;
                    c|C) historiX_backup_history ;;
                    d|D) historiX_restore_history ;;
                    e|E) historiX_load_config; echo "Config reloaded." ;;
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid config option. Type a-e or q to quit." ;;
                esac
            done
            ;;
        8)
            # Info submenu with input validation and 'q' shortcut
            echo -e "${YELLOW}Info:${NC}"
            echo -e "  a) Shell Info   b) Core Summary   c) About   d) List Plugins"
            echo -e "  e) Merge Histories   f) Compare Histories   g) Check Dangerous Cmds   h) Suggest Aliases"
            while true; do
                read -p "Select info [a-h, q to quit]: " subchoice
                case $subchoice in
                    a|A) historiX_show_shell_info ;;
                    b|B) historiX_show_core_summary ;;
                    c|C) echo "HistoriX - Bash History Analyzer v0.1.0 by Onyx" ;;
                    d|D) historiX_list_plugins ;;
                    e|E) historiX_merge_histories ;;
                    f|F) historiX_compare_histories ;;
                    g|G) historiX_check_dangerous_commands ;;
                    h|H) historiX_suggest_aliases ;;
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid info option. Type a-h or q to quit." ;;
                esac
            done
            ;;
        9)
            # Advanced Features submenu with input validation and 'q' shortcut
            echo -e "${YELLOW}Advanced Features:${NC}"
            echo -e "  a) Real-Time Monitoring   b) Security & Privacy   c) Custom Reports"
            echo -e "  d) Workflow Automation    e) Enhanced Plugins     f) Visual Enhancements"
            echo -e "  g) Shell Integration      h) CLI Animations       i) Back"
            while true; do
                read -p "Select advanced [a-i, q to quit]: " subchoice
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
                        break
                        ;;
                    q|Q|exit|EXIT) break ;;
                    *) echo "Invalid advanced option. Type a-i or q to quit." ;;
                esac
            done
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
    while true; do
        read -p "Select security option [a-d, q to quit]: " subchoice
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
            d|D|q|Q|exit|EXIT)
                break
                ;;
            *) echo "Invalid security option. Type a-d or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to Security menu..." _
    historiX_security_menu
}

# Report menu for HistoriX advanced features
historiX_report_menu() {
    echo -e "${YELLOW}Custom Reports:${NC}"
    echo -e "  a) Generate Markdown Report   b) Schedule Report   c) Back"
    while true; do
        read -p "Select report option [a-c, q to quit]: " subchoice
        case $subchoice in
            a|A)
                generate_custom_report
                ;;
            b|B)
                read -p "Enter cron interval (e.g., '0 8 * * *'): " interval
                schedule_report "$interval"
                ;;
            c|C|q|Q|exit|EXIT)
                break
                ;;
            *) echo "Invalid report option. Type a-c or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to Report menu..." _
    historiX_report_menu
}

# Workflow menu for HistoriX advanced features
historiX_workflow_menu() {
    echo -e "${YELLOW}Workflow Automation:${NC}"
    echo -e "  a) Detect Workflows   b) Export Workflow Script   c) Back"
    while true; do
        read -p "Select workflow option [a-c, q to quit]: " subchoice
        case $subchoice in
            a|A)
                historiX_detect_workflows
                ;;
            b|B)
                historiX_export_workflow_script
                ;;
            c|C|q|Q|exit|EXIT)
                break
                ;;
            *) echo "Invalid workflow option. Type a-c or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to Workflow menu..." _
    historiX_workflow_menu
}

# Visuals menu for HistoriX advanced features
historiX_visuals_menu() {
    echo -e "${YELLOW}Visual Enhancements:${NC}"
    echo -e "  a) Generate SVG Chart   b) Back"
    while true; do
        read -p "Select visuals option [a-b, q to quit]: " subchoice
        case $subchoice in
            a|A)
                historiX_generate_svg_chart
                ;;
            b|B|q|Q|exit|EXIT)
                break
                ;;
            *) echo "Invalid visuals option. Type a-b or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to Visuals menu..." _
    historiX_visuals_menu
}

# Shell integration menu for HistoriX advanced features
historiX_shell_integration_menu() {
    echo -e "${YELLOW}Shell Integration:${NC}"
    echo -e "  a) Show Prompt Widget   b) Show Completions Stub   c) Back"
    while true; do
        read -p "Select shell integration option [a-c, q to quit]: " subchoice
        case $subchoice in
            a|A)
                historiX_prompt_widget
                ;;
            b|B)
                historiX_completion
                ;;
            c|C|q|Q|exit|EXIT)
                break
                ;;
            *) echo "Invalid shell integration option. Type a-c or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to Shell Integration menu..." _
    historiX_shell_integration_menu
}

# CLI animations demo for HistoriX advanced features
historiX_cli_animations_demo() {
    echo -e "${YELLOW}CLI Animations Demo:${NC}"
    echo "  a) Spinner   b) Progress Bar   c) Back"
    while true; do
        read -p "Select animation [a-c, q to quit]: " subchoice
        case $subchoice in
            a|A)
                (sleep 3 &)
                spinner $!
                ;;
            b|B)
                progress_bar 10
                ;;
            c|C|q|Q|exit|EXIT)
                break
                ;;
            *) echo "Invalid animation option. Type a-c or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to CLI Animations demo..." _
    historiX_cli_animations_demo
}

# Plugin manager menu for HistoriX advanced features
historiX_plugin_manager() {
    echo -e "${YELLOW}Plugin Manager:${NC}"
    echo -e "  a) List Plugins   b) Load Plugins   c) Run Plugin by Name   d) Back"
    while true; do
        read -p "Select plugin option [a-d, q to quit]: " subchoice
        case $subchoice in
            a|A)
                # List available plugins (by file)
                historiX_list_plugins
                ;;
            b|B)
                # Load plugins (sources all plugin scripts)
                historiX_load_plugins
                echo "Plugins loaded."
                ;;
            c|C)
                # Run a plugin by function name (must be loaded)
                read -p "Enter plugin function name (e.g., historiX_plugin_greet_user): " plugin_func
                if type "$plugin_func" &>/dev/null; then
                    "$plugin_func"
                else
                    echo "Plugin function '$plugin_func' not found. Please load plugins first or check the name."
                fi
                ;;
            d|D|q|Q|exit|EXIT)
                # Return to previous menu
                break
                ;;
            *) echo "Invalid plugin option. Type a-d or q to quit." ;;
        esac
    done
    echo
    read -p "Press Enter to return to Plugin Manager..." _
    historiX_plugin_manager
}
