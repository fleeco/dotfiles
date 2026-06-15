#!/bin/bash
# Bend GNOME into tiling-WM-style keybinds without leaving the Fedora default DE.
# Idempotent: safe to re-run. Applies to the current user's dconf.
#
#   SUPER + 1..9          -> switch to workspace N
#   SHIFT + SUPER + 1..9  -> move focused window to workspace N
#   SUPER + Q             -> new terminal (kitty)
#   SUPER + C             -> close focused window
#
# Run with:  ./gnome-keybinds.sh
set -euo pipefail

TERMINAL="kitty"

echo "==> Fixed, numbered workspaces (1-9) instead of dynamic"
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 9

# NOTE: leaving org.gnome.mutter workspaces-only-on-primary at its default ('true')
# on purpose. That keeps the NON-primary monitor static across workspace switches,
# which is where a persistent Slack window lives. Set the large monitor as primary
# in Settings -> Displays so the laptop stays put.

echo "==> Freeing Super+number (default = launch pinned dash app N)"
for i in $(seq 1 9); do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

echo "==> Super+number = switch workspace, Shift+Super+number = move window"
for i in $(seq 1 9); do
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Shift><Super>$i']"
done

echo "==> Super+C = close window"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>c']"

echo "==> Super+Q = new terminal ($TERMINAL)"
KEYPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KEYPATH']"
SCHEMA="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYPATH"
gsettings set "$SCHEMA" name 'Terminal'
gsettings set "$SCHEMA" command "$TERMINAL"
gsettings set "$SCHEMA" binding '<Super>q'

echo "==> Forge auto-tiling extension"
# Install once with:  sudo dnf install gnome-shell-extension-forge
# A freshly-installed extension needs a logout/login before GNOME registers it
# (Wayland can't restart the shell in place).
if gnome-extensions list 2>/dev/null | grep -q '^forge@jmmaranan.com$'; then
  # GNOME's safety service can flip this kill switch on after a shell hiccup,
  # which silently disables ALL extensions. Make sure it's off.
  gsettings set org.gnome.shell disable-user-extensions false
  gnome-extensions enable forge@jmmaranan.com
  # Launch a NEW window when activating an app, instead of switching to the
  # existing one (so the same app can live on multiple workspaces). Ships with
  # GNOME (gnome-shell-extension-common), just disabled by default.
  gnome-extensions enable launch-new-instance@gnome-shell-extensions.gcampax.github.com 2>/dev/null || true
  # Forge binds Super+C to 'toggle float', which collides with our close-window
  # bind. Move Forge's float toggle to Super+F so Super+C stays "close".
  gsettings set org.gnome.shell.extensions.forge.keybindings window-toggle-float "['<Super>f']"
  echo "    Forge enabled (float-toggle moved to Super+F to free Super+C)."
else
  echo "    Forge not registered yet -> log out/in, then re-run this script."
fi

echo "==> Done. Keybinds are live immediately, no logout needed."
