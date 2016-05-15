AC_POWER=$( pmset -g batt | egrep "AC Power" -o --colour=auto )

PERCENTAGE=$(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d ';')

if [ "$AC_POWER" == "AC Power" ]
then
  printf "#[fg=colour109]%s#[default]" "$PERCENTAGE"
else
  printf "#[fg=colour100]%s#[default]" "$PERCENTAGE"
fi
