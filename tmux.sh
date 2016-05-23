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

# coreutils aren't part of default PATH.
NUMFORMAT=/usr/local/opt/coreutils/libexec/gnubin/numfmt

# get start data
ORIGINAL=$(netstat -b -I en0 | sed -n '2,2p' | column -t)
SPLITPARTS=($ORIGINAL)
ORIG_DOWN=${SPLITPARTS[6]}
ORIG_UP=${SPLITPARTS[9]}

# wait a bit
sleep 2

# get current data
UPDATED=$(netstat -b -I en0 | sed -n '2,2p' | column -t)
SPLITPARTS=($UPDATED)
UPDATED_DOWN=${SPLITPARTS[6]}
UPDATED_UP=${SPLITPARTS[9]}

# diff data
DOWN_DIFF=$((($UPDATED_DOWN - $ORIG_DOWN) / 2))
UP_DIFF=$((($UPDATED_UP - $ORIG_UP) / 2))

HUMANIZED_RESULT=0
function humanize() {
  if [ $1 == 0 ]
  then
    HUMANIZED_RESULT="0.0KB"
  elif [ $1 -lt 1000 ]
  then
    BYTES_AS_KB=$(echo "$1/1000" | bc -l)
    HUMANIZED_RESULT=$(printf "%.1fKB" $BYTES_AS_KB)
  else
    HUMANIZED_RESULT=$($NUMFORMAT --to=si --suffix=B --round=towards-zero $1)
  fi
}

# format diff speeds
humanize $DOWN_DIFF
DOWN_SPEED=$HUMANIZED_RESULT
humanize $UP_DIFF
UP_SPEED=$HUMANIZED_RESULT

STATE=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ state/ {print $0}')

# print result
if [[ $STATE == *"init"* ]]
then
  SPEED_PART=$(printf "#[fg=colour243]%7s %7s#[default]" "$DOWN_SPEED/s" "$UP_SPEED/s")
else
  SPEED_PART=$(printf "#[fg=colour249]%7s %7s#[default]" "$DOWN_SPEED/s" "$UP_SPEED/s")
fi

VOLUME_PART=$(/usr/local/bin/mjolnir -c 'speakerstate()')

printf "%s   %s   %s   %s   %s" "$SPEED_PART" "$VOLUME_PART" "$CPU_PART" "$BATTERY_PART" "$TIME_PART"
