#!/bin/bash
# Install the gfx1151 GPU-hang mitigation on this Flow Z13.
# Copies the script + systemd unit into place and enables the service.
# Idempotent: safe to re-run. Needs sudo (writes to /usr/local/bin + /etc).
#
#   ./install.sh
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> installing gpu-dpm-by-profile script + unit"
sudo install -m 0755 "$HERE/gpu-dpm-by-profile.sh"      /usr/local/bin/gpu-dpm-by-profile.sh
sudo install -m 0644 "$HERE/gpu-dpm-by-profile.service" /etc/systemd/system/gpu-dpm-by-profile.service

# Retire the old unconditional udev rule if a previous setup left it behind
# (it would force 'high' on every boot and fight the profile-driven service).
if [ -f /etc/udev/rules.d/30-amdgpu-dpm-high.rules ]; then
    echo "==> removing legacy unconditional udev rule"
    sudo rm -f /etc/udev/rules.d/30-amdgpu-dpm-high.rules
    sudo udevadm control --reload
fi

echo "==> enabling + starting service"
sudo systemctl daemon-reload
sudo systemctl enable --now gpu-dpm-by-profile.service

echo "==> done. current state:"
echo "    profile: $(busctl --system get-property net.hadess.PowerProfiles /net/hadess/PowerProfiles net.hadess.PowerProfiles ActiveProfile 2>/dev/null | tr -d 's \"')"
echo "    dpm:     $(cat /sys/class/drm/card*/device/power_dpm_force_performance_level 2>/dev/null | head -1)"
echo
echo "Flip GNOME's power profile to Performance -> GPU pins 'high' (no hangs)."
echo "Flip to Balanced/Power Saver       -> GPU scales 'auto' (saves battery)."
echo "Watch it react:  journalctl -t gpu-dpm-by-profile -f"
