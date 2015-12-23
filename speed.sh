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

# format diff speeds
DOWN_SPEED=$($NUMFORMAT --to=si --suffix=B --round=towards-zero $DOWN_DIFF)
UP_SPEED=$($NUMFORMAT --to=si --suffix=B --round=towards-zero $UP_DIFF)

# TODO: if bytes then force it to be KB, e.g. 0.x/s

# print result
printf "up/down \e[32m%-5s %-5s" "$DOWN_SPEED/s" "$UP_SPEED/s"
