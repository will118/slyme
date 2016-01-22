SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

hash_index() {
    case $1 in
        'wifi_is_cool_v2.0') return 0;;
        'wifi_is_cool') return 0;;
        'HB Wifi') return 0;;
        'papers-net') return 1;;
        "Will's iPhone") return 2;;
        *)   return 255;;
    esac
}

hash_vals=("home"
           "work"
           "phone");

hash_index $SSID
HASH_INDEX=$?

if [ $HASH_INDEX == 255 ]
then
  #echo "$(echo $SSID | cut -c 1-5)…"
  echo "other"
else
  echo ${hash_vals[$HASH_INDEX]}
fi
