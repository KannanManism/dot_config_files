# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

#Wifi Status
network_connect=$(nmcli -p | grep connected | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

# Get the Linux version but remove the "-1-ARCH" part
linux_version=$(uname -r | cut -d '-' -f1)

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# "upower --enumerate | grep 'BAT'" gets the battery name (e.g.,
# "/org/freedesktop/UPower/devices/battery_BAT0") from all power devices.
# "upower --show-info" prints battery information from which we get
# the state (such as "charging" or "fully-charged") and the battery's
# charge percentage. With awk, we cut away the column containing
# identifiers. i3 and sway convert the newline between battery state and
# the charge percentage automatically to a space, producing a result like
# "charging 59%" or "fully-charged 100%"
battery_info=$(upower --show-info $(upower --enumerate |\
grep 'BAT') |\
egrep "state|percentage" |\
awk '{print $2}')

# "amixer -M" gets the mapped volume for evaluating the percentage which
# is more natural to the human ear according to "man amixer".
# Column number 4 contains the current volume percentage in brackets, e.g.,
# "[36%]". Column number 6 is "[off]" or "[on]" depending on whether sound
# is muted or not.
# "tr -d []" removes brackets around the volume.
# Adapted from https://bbs.archlinux.org/viewtopic.php?id=89648
audio_volume=$(amixer -M get Master |\
awk '/Mono.+/ {print $6=="[off]" ?\
$4" 🔇": \
$4" 🔉"}' |\
tr -d [])



# Additional emojis and characters for the status bar:
# Electricity: ⚡ ↯ ⭍ 🔌
# Audio: 🔈 🔊 🎧 🎶 🎵 🎤
# Separators: \| ❘ ❙ ❚
# Misc: 🐧 💎 💻 💡 ⭐ 📁 ↑ ↓ ✉ ✅ ❎

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
echo $audio_volume $network_connect ⚡ $uptime_formatted ↑ $linux_version 🐧 $battery_info 🔋 💡 $date_formatted
