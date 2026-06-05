# Dotfiles

Personal Arch Linux dotfiles for a Hyprland desktop. The setup is built around
GNU Stow, a Lua-based Hyprland config, Everforest Dark Hard colors, compact
Waybar modules, zsh, kitty, Neovim, and terminal-first utilities.

This repository is meant to be a clean base for my own machines. It is not a
one-shot installer, but it should be enough to recreate the desktop once the
packages are installed.

![Desktop Screenshot](screenshots/Screenshot-Desktop.png)

## Highlights

- Hyprland configuration is split into Lua modules under
  `config/.config/hypr/hyprland/`.
- Default layout is `scrolling`, with a keybind to toggle between `scrolling`
  and `dwindle`.
- Waybar is compact, 28px tall, and uses a drawer for tray-style controls.
- Wallpaper selection is handled from `imv`; pressing `w` copies the selected
  image into XDG state and applies it with Hyprpaper.
- Screen sharing uses `hyprland-preview-share-picker` through
  `xdg-desktop-portal-hyprland`.
- zsh uses XDG paths, Starship, zoxide, fzf, and modern CLI replacements.
- Fontconfig prefers SF Pro for sans text, Berkeley/JetBrains Mono for mono,
  and Noto/Symbols/Emoji fallbacks.
- Runtime state, caches, history, and selected wallpapers are kept outside the
  repository.

## Repository Layout

```text
.
├── config/
│   ├── .config/
│   │   ├── hypr/                         # Hyprland, Hypridle, Hyprlock, scripts
│   │   ├── hyprland-preview-share-picker/ # Screen-share picker config
│   │   ├── waybar/                       # Bar config and CSS
│   │   ├── kitty/                        # Terminal config
│   │   ├── fuzzel/                       # Launcher config
│   │   ├── mako/                         # Notifications
│   │   ├── wlogout/                      # Power menu
│   │   ├── zsh/                          # zsh config loaded from ZDOTDIR
│   │   ├── starship/                     # Prompt config
│   │   ├── nvim/                         # Neovim config
│   │   ├── yazi/                         # Terminal file manager
│   │   ├── fontconfig/                   # Font aliases and rendering
│   │   ├── environment.d/                # User environment snippets
│   │   ├── calcurse/                     # Calendar and todo config
│   │   ├── sc-im/                        # Spreadsheet config
│   │   ├── zathura/                      # PDF reader config
│   │   └── mimeapps.list                 # Default application associations
│   └── .stow-local-ignore
├── zsh/
│   └── .zshenv                           # Sets ZDOTDIR and XDG paths
├── .local/
│   └── share/applications/sc-im.desktop  # Desktop entry for CSV files
├── screenshots/
└── README.md
```

## Stow Setup

Clone the repository:

```sh
git clone https://github.com/sanjeebSubedi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Install Stow:

```sh
sudo pacman -S stow
```

Link the dotfiles:

```sh
stow config zsh .local
```

This creates links such as:

- `config/.config/hypr` -> `~/.config/hypr`
- `config/.config/waybar` -> `~/.config/waybar`
- `zsh/.zshenv` -> `~/.zshenv`
- `.local/share/applications/sc-im.desktop` -> `~/.local/share/applications/sc-im.desktop`

Set zsh as the login shell:

```sh
chsh -s "$(command -v zsh)"
```

Log out and back in after changing the shell or restowing session-critical
files.

## Packages

Package names can differ slightly between the Arch repos and AUR. This list is
the practical dependency map for the configs in this repo.

Core desktop:

```sh
hyprland xdg-desktop-portal-hyprland hyprpaper hyprlock hypridle hyprsunset
hyprpolkitagent waybar mako fuzzel wlogout kitty
```

Hyprland utilities:

```sh
grim slurp swappy wf-recorder wl-clipboard cliphist hyprpicker libnotify
brightnessctl playerctl power-profiles-daemon
hyprland-preview-share-picker
```

Network, audio, Bluetooth:

```sh
networkmanager impala
pipewire wireplumber wiremix
bluez bluez-utils bluetui
```

Shell and CLI tools:

```sh
zsh starship zoxide fzf fd ripgrep eza bat delta
zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
```

Applications:

```sh
neovim yazi thunar imv mpv zathura sc-im calcurse google-chrome
mpd
```

Fonts and appearance:

```sh
inter-font noto-fonts noto-fonts-cjk noto-fonts-emoji
ttf-jetbrains-mono-nerd ttf-berkeley-mono-nerd nerd-fonts-symbols
papirus-icon-theme bibata-cursor-theme
```

Optional or machine-specific:

```sh
nvidia nvidia-utils nvidia-prime
```

The Hyprland environment keeps the compositor on the integrated GPU. Use
`prime-run` for applications that should use the NVIDIA GPU.

## Post-Install Notes

Enable services that are not started automatically by the dotfiles:

```sh
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
systemctl --user enable --now mpd.socket
```

Refresh fontconfig after installing fonts:

```sh
fc-cache -f
```

The monitor config currently targets the laptop panel as `eDP-1` with scale
`1.333333`, and uses scale `1` for other outputs.

## Hyprland

Entry point:

```text
config/.config/hypr/hyprland.lua
```

The entrypoint loads these modules:

- `env.lua` - session variables, cursor, Qt and Electron Wayland settings
- `monitors.lua` - laptop panel and fallback monitor rules
- `programs.lua` - terminal, browser, launcher, file manager defaults
- `autostart.lua` - Waybar, Hyprpaper, Mako, Hypridle, Hyprsunset, clipboard watchers
- `appearance.lua` - gaps, borders, animations, layout settings
- `input.lua` - keyboard, touchpad, and gestures
- `keybinds.lua` - keyboard and mouse bindings
- `rules.lua` - floating popups and window/layer rules

The default layout is `scrolling`. `SUPER + L` toggles between `scrolling` and
`dwindle`; `SUPER + G` toggles the configured gaps.

The hidden workspace is `special:hidden`. `SUPER + H` shows or hides it.
`SUPER + SHIFT + H` moves the active window there without leaving the current
workspace behind. Switching to workspaces `1` through `10` closes
`special:hidden` first.

## Keybinds

| Binding | Action |
| --- | --- |
| `SUPER` | Open/close Fuzzel |
| `SUPER + Return` | Open Kitty |
| `SUPER + W` | Open Chrome |
| `SUPER + E` | Open Yazi in Kitty |
| `SUPER + R` | Open Thunar |
| `SUPER + Q` | Close focused window |
| `SUPER + F` | Toggle floating |
| `SUPER + P` | Toggle pseudo tiling |
| `SUPER + J` | Toggle Dwindle split |
| `SUPER + L` | Toggle `scrolling`/`dwindle` layout |
| `SUPER + G` | Toggle gaps |
| `SUPER + M` | Fullscreen focused window |
| `SUPER + H` | Toggle hidden workspace |
| `SUPER + Shift + H` | Move focused window to hidden workspace |
| `SUPER + 1-0` | Switch workspace 1-10 |
| `SUPER + Shift + 1-0` | Move focused window to workspace 1-10 |
| `SUPER + Arrow` | Move focus |
| `SUPER + Shift + Arrow` | Move focused window |
| `SUPER + V` | Clipboard history |
| `SUPER + S` | Region screenshot to clipboard |
| `SUPER + Shift + S` | Region screenshot through Swappy |
| `SUPER + Print` | Full screenshot to `~/Pictures/Screenshots` |
| `SUPER + Shift + R` | Toggle screen recording |
| `SUPER + Alt + R` | Toggle region recording |
| `SUPER + Ctrl + R` | Toggle region recording with audio |
| `SUPER + Shift + C` | Pick color with Hyprpicker |
| `SUPER + Backspace` | Open Wlogout |
| `SUPER + Left Mouse` | Drag window |
| `SUPER + Right Mouse` | Resize window |

Hardware media, volume, microphone, and brightness keys are also configured.

## Waybar

Waybar is configured in:

```text
config/.config/waybar/config.jsonc
config/.config/waybar/style.css
```

The bar is 28px tall. Left modules show Arch and workspaces, the center clock
opens Calcurse, and right modules include a controls drawer plus status icons.

Click targets:

- Clock: open `calcurse` in a floating Kitty window
- Volume: open `wiremix`
- Network: open `impala`
- Bluetooth: open `bluetui`
- Battery: open a power profile menu
- Power icon: open `wlogout`

The controls drawer contains the system tray, inactive Bluetooth/idle-inhibitor
states, and the brightness indicator. Connected Bluetooth and activated idle
inhibitor states are shown outside the drawer.

## Wallpaper

Hyprpaper starts with:

```text
~/.local/state/hypr/wallpaper.jpg
```

That file is runtime state, not repository content. In `imv`, press `w` to run:

```text
~/.config/hypr/scripts/set-wallpaper.sh
```

The script copies or converts the selected image into
`~/.local/state/hypr/wallpaper.jpg`, records the source metadata in
`~/.local/state/hypr/wallpaper-source`, applies the wallpaper through Hyprpaper,
and avoids repeated work when the selected image has not changed.

## Screen Sharing

`config/.config/hypr/xdph.conf` configures
`xdg-desktop-portal-hyprland` to use:

```text
hyprland-preview-share-picker
```

The picker config lives at:

```text
config/.config/hyprland-preview-share-picker/config.yaml
```

## Runtime State

These are intentionally outside Git:

- `~/.local/state/hypr/wallpaper.jpg`
- `~/.local/state/hypr/wallpaper-source`
- `~/.config/zsh/.zsh_history`
- caches under `~/.cache`
- downloaded assets or temporary reference configs

## Validation

Useful checks after editing:

```sh
luac -p config/.config/hypr/hyprland.lua config/.config/hypr/hyprland/*.lua
bash -n config/.config/hypr/scripts/*.sh
zsh -n config/.config/zsh/.zshrc config/.config/zsh/conf.d/*.zsh
xmllint --noout config/.config/fontconfig/fonts.conf
git diff --check
```

Reload Hyprland and check config errors:

```sh
hyprctl reload
hyprctl configerrors
```
