#!/usr/bin/env bash
# Tie amdgpu GPU DPM level to the active power profile.
#
#   performance  -> high   (pins GPU clocks; stops the gfx1151 MES ring-timeout
#                           hang by eliminating clock/power-state transitions)
#   anything else-> auto   (normal dynamic scaling; saves battery, accepts the
#                           occasional hang)
#
# Driven by the ActiveProfile property of power-profiles-daemon / tuned-ppd over
# the system bus, so flipping the GNOME power toggle also flips the GPU pin.
# See README.md in this folder for the full story.
set -u

DBUS_DEST="net.hadess.PowerProfiles"
DBUS_PATH="/net/hadess/PowerProfiles"

get_profile() {
    busctl --system get-property "$DBUS_DEST" "$DBUS_PATH" "$DBUS_DEST" ActiveProfile 2>/dev/null \
        | awk '{gsub(/"/,"",$2); print $2}'
}

apply() {
    local profile="$1" level
    case "$profile" in
        performance) level=high ;;
        *)           level=auto ;;
    esac
    for f in /sys/class/drm/card*/device/power_dpm_force_performance_level; do
        [ -w "$f" ] && echo "$level" > "$f"
    done
    logger -t gpu-dpm-by-profile "profile=${profile:-unknown} -> dpm=$level"
}

# Apply current state immediately on startup.
apply "$(get_profile)"

# React to every profile change.
gdbus monitor --system --dest "$DBUS_DEST" --object-path "$DBUS_PATH" 2>/dev/null \
    | while read -r line; do
        case "$line" in
            *ActiveProfile*) apply "$(get_profile)" ;;
        esac
    done
