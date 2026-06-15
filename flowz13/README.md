# Flow Z13 (fedoraflow) — machine-specific fixes

ASUS ROG Flow Z13 **GZ302EA** · AMD Ryzen AI MAX+ 395 "Strix Halo" · Radeon 8060S
iGPU (**gfx1151** / GC 11.5.1, PCI `1002:1586`) · Fedora.

This folder holds fixes that are specific to *this* hardware and don't belong in the
stow-managed home dotfiles (they're root-owned system files). Run `./install.sh`.

---

## GPU hang mitigation (`gpu-dpm-by-profile`)

### The problem
Intermittent GPU hang, a few times a day, since day one (also shows up on Windows as a
TDR). Signature in `dmesg`:

```
amdgpu …: ring gfx_0.0.0 timeout, signaled seq=N emitted seq=N+2
amdgpu …: MES failed to respond to msg=RESET
amdgpu …: reset via MES failed and try pipe reset -110
[drm:gfx_v11_0_hw_fini] *ERROR* failed to halt cp gfx
amdgpu …: MODE2 reset
amdgpu …: [drm] device wedged, but recovered through reset
```

It self-recovers (a sub-second screen flicker) thanks to `gpu_recovery`, so it's
**annoying, not dangerous** — no crash, no data loss.

### Root cause
An **open AMD firmware defect**: the MES scheduler microcode deadlocks. It is
fleet-wide on gfx1151 (RMA replacements recur). The real fix is upstream and not
shipping yet — see "Upstream fix to watch" below.

### The key insight (why this fix works)
The hang is triggered by **GPU power-state *transitions***, not by load or heat:

- Every time the GPU ramps clocks up/down or enters/exits a low-power state
  (gfxoff), the SMU and MES firmware do a handshake. That handshake is where the
  deadlock happens. Each transition is a dice-roll.
- **Heaviest load is the *safest*.** Gaming (Fortnite etc.) *never* hangs, because the
  GPU is pinned busy at top clocks the whole time — zero transitions.
- **Light bursty desktop load is the *dangerous* pattern** — terminal, browser,
  compositor ramp the GPU up for a few ms then drop it to idle, hundreds of times a
  minute. You hang on `kitty` / `firefox` / `gnome-shell`, never on a game.

Three independent lines of evidence all point at transitions: the dose-response
(`balanced` worst → `performance` → `high` none), the app-agnostic triggers
(firefox + kitty + gnome-shell all named in dmesg), and the never-hangs-while-gaming
observation.

### The fix
Pin the GPU DPM level to `high` (fixed top clocks, no dynamic scaling), which makes
the idle desktop sit in the same flat, transition-free state as a game:

```
echo high > /sys/class/drm/card*/device/power_dpm_force_performance_level
```

**Cost:** ~30 W constant draw even at idle (vs ~3–8 W scaling), ~60 °C, more fan/heat.
Free on AC, brutal on battery. So instead of pinning it unconditionally, this service
**ties the pin to the power profile**:

| Power profile | GPU DPM | When |
|---------------|---------|------|
| **performance** | `high` | sitting down for real work (usually on AC) |
| balanced / power-saver | `auto` | mobile / battery — accept the occasional flicker |

So **GNOME's power-profile toggle is also the GPU-hang toggle.** No terminal needed.

### How it works
`power-profiles-daemon` / `tuned-ppd` broadcasts a `PropertiesChanged` signal on the
**system D-Bus** whenever `ActiveProfile` changes (that's how GNOME's toggle keeps its
highlight in sync). The service just **eavesdrops on that broadcast** with
`gdbus monitor` and writes `high`/`auto` to the GPU sysfs knob in response. Event-driven,
no polling. See `gpu-dpm-by-profile.sh` — it's ~25 lines.

### Files
- `gpu-dpm-by-profile.sh`      → `/usr/local/bin/`
- `gpu-dpm-by-profile.service` → `/etc/systemd/system/` (enabled, `WantedBy=multi-user`)

### Install / uninstall
```bash
./install.sh        # copy files, enable + start service
./uninstall.sh      # remove, return GPU to 'auto'
```

### Verify / debug
```bash
# current profile + GPU level
busctl --system get-property net.hadess.PowerProfiles /net/hadess/PowerProfiles \
    net.hadess.PowerProfiles ActiveProfile
cat /sys/class/drm/card*/device/power_dpm_force_performance_level

# watch the service react as you flip profiles
journalctl -t gpu-dpm-by-profile -f

# tail the raw D-Bus signal it hooks
gdbus monitor --system --dest net.hadess.PowerProfiles

# count hangs this boot, with the app that triggered each
sudo dmesg | grep -E 'Process .* thread .*:cs0'
```

### Notes for a fresh install
- Power profiles here come from **tuned** via `tuned-ppd`, **not** `power-profiles-daemon`
  (which isn't installed). `powerprofilesctl` isn't installed either — use `busctl` or
  `tuned-adm`. The D-Bus name `net.hadess.PowerProfiles` is still registered (by tuned-ppd),
  so the service works unchanged.
- Needs `gdbus` (glib2) and `busctl` (systemd) — both present on a stock Fedora install.

### Dead ends — already tried, do NOT re-chase
RMA (fleet-wide, recurs) · BIOS update (.311 newest, no GPU fix) · linux-firmware update
(already past the bad MES blob) · `amdgpu.gfxoff=0` (not a param here) ·
`amdgpu.cwsr_enable=0` (compute only) · UMA/VRAM carveout A/B (same crash) ·
**`amdgpu.mcbp=0` — made it WORSE** (suspected of escalating a recoverable hang into a
hard reboot; reverted). Keep the machine on **stock kernel params** (no amdgpu options);
this service is the only intervention.

### Upstream fix to watch
amd-gfx "[PATCH 00/42] Enable pipe reset for compute" (Alex Deucher, 2026-05-22) makes
the surgical pipe reset work instead of full MODE2 — but needs a new MES firmware blob
not yet in linux-firmware. Once a kernel 7.1+ **and** the new MES blob ship, retest
whether the hang is gone and this mitigation can be retired.
Ref: https://community.frame.work/t/strix-halo-gfx1151-gfx-ring-timeout-under-mundane-gl-load/82310

---

## Unrelated: external LaCie SSD boot-time write errors (FYI, not fixed here)
A one-time burst of `BLK_STS_INVAL` write errors on the external **LaCie Rugged PRO5**
(Thunderbolt, `nvme1`, NTFS "Shared" partition) at ~22 s into one boot. SMART is clean
(`media_errors=0`) — it was a Thunderbolt NVMe-bridge command rejection, not failing
media. `smartctl` can't read the LaCie through the TB bridge; use `sudo nvme smart-log
/dev/nvme1`. No action taken; recorded so it isn't mistaken for a real disk failure later.
