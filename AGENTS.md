# AGENTS.md

Personal Arch Linux + Hyprland dotfiles deployed with GNU Stow; layouts mirror
`$HOME` (e.g. `config/.config/foo` → `~/.config/foo`). Packages: `config`, `zsh`,
`.local`. Not an installer; full package list/keybinds in `README.md`.

## Stow model

- Editing a stowed file is immediately live (it's a symlink).
- After **adding** a file, restow: `stow -R config` (or `stow config zsh .local`).
- Session-critical files (zsh, Hyprland) need a logout/login or reload.

## No build/test/lint — validate with

```sh
luac -p config/.config/hypr/hyprland.lua config/.config/hypr/hyprland/*.lua
bash -n config/.config/hypr/scripts/*.sh
zsh -n config/.config/zsh/.zshrc config/.config/zsh/conf.d/*.zsh
hyprctl reload && hyprctl configerrors
```

## Hyprland config is Lua, not hyprlang

Compositor config is `config/.config/hypr/hyprland.lua` + `hyprland/*.lua`;
plain `.conf` syntax will not work. The `hl` global is provided by Hyprland
itself (0.55+, no plugin). Companion tools (`hypridle/hyprlock/hyprpaper/
hyprsunset/xdph`) stay plain `.conf`.

- Modules are required in a fixed order (`env, monitors, programs, autostart,
  appearance, input, keybinds, rules`); `programs` feeds `keybinds.setup()`.
- Runtime toggles use `hl.get_config("general.layout")` (default `scrolling`) /
  `hl.config({ ... })` in `keybinds.lua`. Hidden workspace is `special:hidden`.
- In `autostart.lua`, keep `uwsm finalize` first — the compositor unit waits on it.
- `scripts/*.sh` are POSIX `sh`.

## zsh

`zsh/.zshenv` bootstraps everything: sets `ZDOTDIR=~/.config/zsh`, XDG paths,
default apps, `PATH`. Put new shell config in `conf.d/` as a numbered fragment
(`00-prompt`, `10-history`, `50-fzf`, `55-atuin`...) sourced in lexical order — do
**not** edit `.zshrc`. Order matters: completion before plugins, atuin after fzf
(atuin owns Ctrl-R). `programs.lua` takes `TERMINAL`/`MENU`/`FILE_MANAGER` from
env; set them in `.zshenv`/`env.lua`, not the table.

## Conventions

- Lua files are tab-indented; shell and others space-indented. Match the file.
- Hybrid GPU: compositor on iGPU, `prime-run` for NVIDIA. `monitors.lua` targets
  `eDP-1` at scale `1.333333`.
- Everforest Dark Hard for terminal/TUI surfaces; GTK intentionally uses
  `enhanced-gruvbox` — do not "fix" it.