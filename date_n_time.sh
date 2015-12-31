DATE_PART=$(date +"%d %b")
TIME_PART=$(date +"%H:%M")

printf "\e[94m%s \e[90m| \e[96m%s" "$DATE_PART" "$TIME_PART"
