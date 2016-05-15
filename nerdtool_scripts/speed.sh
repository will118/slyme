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
  printf "#[fg=colour243]%7s %7s#[default]" "$DOWN_SPEED/s" "$UP_SPEED/s"
else
  printf "#[fg=colour249]%7s %7s#[default]" "$DOWN_SPEED/s" "$UP_SPEED/s"
fi

