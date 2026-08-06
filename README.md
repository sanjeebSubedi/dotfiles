# Dotfiles

Personal Arch Linux + Hyprland dotfiles, deployed with GNU Stow. Lua-based
Hyprland config, Everforest Dark Hard theme, Waybar, zsh, kitty, Neovim. A clean
base for my own machines — not a one-shot installer.

![Desktop Screenshot](screenshots/Screenshot-Desktop.png)

## Install

```sh
git clone https://github.com/sanjeebSubedi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sudo pacman -S stow
stow config zsh .local          # symlink into $HOME
chsh -s "$(command -v zsh)"     # set login shell
```

Log out and back in afterward. `config/.config/foo` becomes `~/.config/foo`;
re-run `stow -R config` after adding new files. Architecture details live in
`CLAUDE.md`.

## Packages

```sh
# Core desktop
hyprland xdg-desktop-portal-hyprland hyprpaper hyprlock hypridle hyprsunset \
hyprpolkitagent waybar mako fuzzel wlogout kitty uwsm

# Hyprland utilities
grim slurp swappy wf-recorder wl-clipboard cliphist hyprpicker libnotify \
brightnessctl playerctl power-profiles-daemon hyprland-preview-share-picker

# Network, audio, Bluetooth
networkmanager impala pipewire wireplumber wiremix bluez bluez-utils bluetui

# Shell and CLI
zsh starship zoxide fzf fd ripgrep eza bat delta atuin \
zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search

# Applications
neovim yazi thunar imv mpv zathura sc-im calcurse google-chrome mpd rmpc

# Fonts and appearance
inter-font noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono-nerd \
ttf-berkeley-mono-nerd nerd-fonts-symbols papirus-icon-theme \
bibata-cursor-theme qt6ct kvantum
```

Notes:
- `zsh-fzf-tab` (AUR) is picked up automatically when present.
- Geist (`otf-geist-font`, AUR) and Berkeley Mono (commercial, hand-patched) are
  not in the official repos.
- Hybrid GPU: the compositor stays on the iGPU; use `prime-run` for NVIDIA
  offload (`nvidia nvidia-utils nvidia-prime`).

## Post-install

```sh
sudo systemctl enable --now NetworkManager bluetooth
systemctl --user enable --now mpd.socket battery-notify.timer
atuin import zsh    # one-time history import
fc-cache -f         # after installing fonts
```

Monitor config targets the laptop panel as `eDP-1` at scale `1.333333`.

## Keybinds

| Binding | Action |
| --- | --- |
| `SUPER` | Fuzzel launcher |
| `SUPER + Return` | Kitty |
| `SUPER + W` / `E` / `R` | Chrome / Yazi / Thunar |
| `SUPER + ,` | rmpc music player (mpd) |
| `SUPER + Q` | Close window |
| `SUPER + F` / `P` | Toggle floating / pseudo-tiling |
| `SUPER + L` | Toggle `scrolling`/`dwindle` layout |
| `SUPER + G` | Toggle gaps |
| `SUPER + M` | Fullscreen |
| `SUPER + H` / `Shift + H` | Toggle hidden workspace / move window there |
| `SUPER + 1-0` | Switch workspace (`Shift` moves window) |
| `SUPER + Arrow` | Move focus (`Shift` moves window) |
| `SUPER + V` | Clipboard history |
| `SUPER + S` / `Shift + S` | Region screenshot to clipboard / Swappy |
| `SUPER + Print` | Full screenshot to `~/Pictures/Screenshots` |
| `SUPER + Shift + R` | Toggle screen recording |
| `SUPER + Alt + R` / `Ctrl + R` | Region recording / with audio |
| `SUPER + Shift + C` | Color picker |
| `SUPER + Backspace` | Wlogout |
| `SUPER + Left/Right Mouse` | Drag / resize window |

Media, volume, mic, and brightness hardware keys are configured too.

## Validation

```sh
luac -p config/.config/hypr/hyprland.lua config/.config/hypr/hyprland/*.lua
bash -n config/.config/hypr/scripts/*.sh
zsh -n config/.config/zsh/.zshrc config/.config/zsh/conf.d/*.zsh
hyprctl reload && hyprctl configerrors
```
