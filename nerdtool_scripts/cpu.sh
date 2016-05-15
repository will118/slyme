ps -A -o %cpu | awk '{s+=$1} END {printf("#[fg=colour105]%.1f#[default]",s/4);}'
