# CLI animations for HistoriX

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%$temp}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

progress_bar() {
    local duration=$1
    local i=0
    local bar=""
    while [ $i -le $duration ]; do
        bar+="#"
        printf "\r[%s] %d%%" "$bar" $((i*100/duration))
        sleep 1
        i=$((i+1))
    done
    echo
}
