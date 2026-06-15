#!/bin/bash
# Remove the gfx1151 GPU-hang mitigation. Returns the GPU to dynamic scaling.
# Idempotent: safe to re-run.
#
#   ./uninstall.sh
set -euo pipefail

echo "==> disabling + stopping service"
sudo systemctl disable --now gpu-dpm-by-profile.service 2>/dev/null || true

echo "==> removing files"
sudo rm -f /usr/local/bin/gpu-dpm-by-profile.sh
sudo rm -f /etc/systemd/system/gpu-dpm-by-profile.service
sudo systemctl daemon-reload

echo "==> restoring GPU to dynamic scaling (auto)"
for f in /sys/class/drm/card*/device/power_dpm_force_performance_level; do
    [ -w "$f" ] && echo auto | sudo tee "$f" >/dev/null
done

echo "==> done. GPU DPM is back to 'auto' (hangs may return on light desktop load)."
