AC_POWER=$( pmset -g batt | egrep "AC Power" -o --colour=auto )

PERCENTAGE=$(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d ';')

if [ "$AC_POWER" == "AC Power" ]
then
  printf "\e[92m%s" "$PERCENTAGE"
else
  printf "\e[31m%s" "$PERCENTAGE"
fi
