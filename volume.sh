VOLUME_OUTPUT=$(osascript -e 'set settings to get volume settings
"" & output volume of settings & " " & output muted of settings')
VOLUME_DATA=($VOLUME_OUTPUT)

VOLUME_LEVEL=${VOLUME_DATA[0]}

if [ ${VOLUME_DATA[1]} == "false" ]
then
  printf "\e[94m%s%%" "$VOLUME_LEVEL"
else
  printf "\e[90m%s%%" "$VOLUME_LEVEL"
fi
