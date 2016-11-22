AC_POWER=$( pmset -g batt | egrep "AC Power" -o --colour=auto )

PERCENTAGE=$(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d ';')

if [ "$AC_POWER" == "AC Power" ]
then
  BATTERY_PART=$(printf "#[fg=colour109]%s#[default]" "$PERCENTAGE")
else
  BATTERY_PART=$(printf "#[fg=colour100]%s#[default]" "$PERCENTAGE")
fi

CPU_PART=$(ps -A -o %cpu | awk '{s+=$1} END {printf("#[fg=colour105]%.1f#[default]",s/4);}')

THE_TIME=$(date +"%H:%M")
TIME_PART=$(printf "#[fgcolour=111]%s" "$THE_TIME")

SPEED_PART=$(/usr/local/bin/mjolnir -c 'netspeeds()')

VOLUME_PART=$(/usr/local/bin/mjolnir -c 'speakerstate()')

printf "%s   %s   %s   %s   %s" "$SPEED_PART" "$VOLUME_PART" "$CPU_PART" "$BATTERY_PART" "$TIME_PART"