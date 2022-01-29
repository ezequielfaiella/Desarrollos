#!/bin/bash

# CURRENT_PROFILE=$(pacmd list-cards | grep "active profile" | cut -d ' ' -f 3-)

# if [ "$CURRENT_PROFILE" = "<output:hdmi-stereo>" ]; then
#         pacmd set-card-profile 0 "output:analog-stereo+input:analog-stereo"
# else 
#         pacmd set-card-profile 0 "output:hdmi-stereo"
# fi


# set -euo pipefail # strict mode

# activeProfile() { pacmd list-cards | grep "active profile" | cut -d " " -f 3-; }
# CURRENT_PROFILE="$(eval activeProfile)"

# # If it doesn't work run  pacmd list-cards  and try the other outputs from profile section
# ANALOG_PROFILE="output:analog-stereo+input:analog-stereo"
# HDMI_PROFILE="output:hdmi-stereo-extra1+input:analog-stereo"

# if [ "$CURRENT_PROFILE" = "<output:hdmi-stereo-extra1+input:analog-stereo>" ] ; then
#   pacmd set-card-profile 0 "$ANALOG_PROFILE"
# else
#     pacmd set-card-profile 0 "$HDMI_PROFILE"
# fi

# activeProfile


set -xeuo pipefail # strict mode

notify() {
	notify-send --hint=int:transient:1 -t $NOTIFICATION_DURATION_MS "SONIDO" "$1"
}

activeProfile() { pactl list sinks | grep "Puerto Activo" | cut -d " " -f 3-; }
CURRENT_PROFILE="$(eval activeProfile)"

# If it doesn't work run  pacmd list-cards  and try the other outputs from profile section
ANALOG_PROFILE="analog-output-headphones"
HDMI_PROFILE="analog-output-lineout"
NOTIFICATION_DURATION_MS=5

if [ "$CURRENT_PROFILE" = "analog-output-lineout" ] ; then
  pactl set-sink-port 0 "$ANALOG_PROFILE"
  notify "Salida de Audio por PARLANTES"
else
    pactl set-sink-port 0 "$HDMI_PROFILE"
    notify "Salida de Audio por AURICULARES"
fi

activeProfile