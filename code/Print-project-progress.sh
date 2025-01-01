days_until_deadline() {
    local today=$(date +%s)
    local start=$(date -d "2023-10-26" +%s)
    local defense=$(date -d "2024-01-31" +%s)
    local total_days=$(( ($defense - $start) / (24*3600) ))
    local days_left=$(( ($defense - $today) / (24*3600) ))
    local days_completed=$(( $total_days - $days_left ))
    local percent_completed=$(( $days_completed * 100 / $total_days ))
    echo "Progress: $percent_completed% ($days_completed/$total_days)" # Add more if needed
}
# Print Progress. Example Output: username@hostname ~ $ Progress: X% (Y/Z) $
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$\[\033[00m\] \$(days_until_deadline) \$"