# Visual enhancements for HistoriX
# Generate SVG/PNG charts using gnuplot (if available)

historiX_generate_svg_chart() {
    local histfile outfile
    histfile=$(historiX_detect_shell_and_history)
    outfile="${HOME}/historiX_chart_$(date +%Y%m%d%H%M%S).svg"
    if command -v gnuplot >/dev/null 2>&1; then
        grep -v '^#' "$histfile" | awk '{print $1}' | sort | uniq -c | sort -rn | head -10 > /tmp/historiX_chart.dat
        echo "set terminal svg; set output '$outfile'; set style data histogram; set style fill solid; plot '/tmp/historiX_chart.dat' using 1:xtic(2) title 'Top Commands'" | gnuplot
        echo "SVG chart generated at $outfile"
    else
        echo "gnuplot not found. Cannot generate SVG chart."
    fi
}
