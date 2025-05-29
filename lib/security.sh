# Security and privacy for HistoriX

# Redact sensitive data (passwords, tokens) before export
historiX_redact_sensitive() {
    local infile outfile
    infile="$1"
    outfile="$2"
    sed -E 's/(password|token|secret|key|passwd)=\S+/\1=REDACTED/Ig' "$infile" > "$outfile"
}

# Encrypted backup using gpg
historiX_encrypted_backup() {
    local histfile encfile
    histfile=$(historiX_detect_shell_and_history)
    encfile="${histfile}.gpg.$(date +%Y%m%d%H%M%S)"
    if command -v gpg >/dev/null 2>&1; then
        gpg -c -o "$encfile" "$histfile"
        echo "Encrypted backup created: $encfile"
    else
        echo "gpg not found. Cannot create encrypted backup."
    fi
}

# Audit log
historiX_audit_log() {
    local action msg
    action="$1"
    msg="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$action] $msg" >> "${LIB_DIR%/lib}/data/audit.log"
}
