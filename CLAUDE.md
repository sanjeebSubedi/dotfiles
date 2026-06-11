# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal Arch Linux + Hyprland dotfiles, deployed with GNU Stow. There is no build,
test, or lint step — changes are validated by symlinking them into place and
reloading the relevant program. The repo is a clean base for the author's own
machines, not a one-shot installer.

## Deploying changes (Stow)

Files live under stow *packages* whose internal layout mirrors `$HOME`. The three
packages are `config`, `zsh`, and `.local`.

```sh
stow config zsh .local      # create/refresh symlinks into $HOME
stow -R config              # restow a single package after adding/removing files
stow -D config              # remove a package's symlinks
```

Key consequence: a file is only "live" once stowed. `config/.config/foo` becomes
`~/.config/foo`. After editing a stowed file the change is already live (it's a
symlink); after *adding a new file* you must restow so the new symlink is created.
Session-critical files (zsh, Hyprland session) need a logout/login or a reload.

`config/.stow-local-ignore` and `.gitignore` keep runtime state out of the repo
(notably `.config/zsh/.zsh_history`, `assets`, `.agents/`, `.codex/`).

## Hyprland config architecture

The Hyprland config is **Lua**, not the legacy `hyprland.conf`. Since Hyprland
0.55 (May 2026) Lua is the official config language: if `hyprland.lua` exists it is
loaded instead of `hyprland.conf`, and the global `hl` API (`hl.env`, `hl.bind`,
`hl.config`, `hl.get_config`, `hl.dsp.*`, `hl.exec`) is provided by Hyprland
itself — no plugin required. hyprlang is deprecated (still supported for ~1–2
releases) and gets no new features. Editing these files with plain `.conf` syntax
will not work.

- Entry point: `config/.config/hypr/hyprland.lua`. It resolves its own directory,
  prepends it to `package.path`, clears `package.loaded` for each module (so
  reloads re-run cleanly), then `require`s the modules in a fixed order.
- Modules live in `config/.config/hypr/hyprland/`: `env`, `monitors`, `programs`,
  `autostart`, `appearance`, `input`, `keybinds`, `rules`. Load order matters —
  `programs` returns a table that is passed into `keybinds.setup(programs)`, and
  `autostart` exposes `.setup()`.
- Runtime state queried/mutated at runtime uses `hl.get_config("general.layout")`
  and `hl.config({ general = { ... } })` — e.g. the layout and gaps toggles in
  `keybinds.lua`.
- Default layout is `scrolling` (toggle to `dwindle` with `SUPER+L`). Hidden
  workspace is `special:hidden`.
- The companion `hypr*` tools still use hyprlang, so their configs stay plain
  `.conf`: `hypridle.conf`, `hyprlock.conf`, `hyprpaper.conf`, `hyprsunset.conf`,
  `xdph.conf`. Only the compositor config (`hyprland.lua` + `hyprland/`) is Lua.
- Helper scripts in `config/.config/hypr/scripts/` are POSIX `sh` and are invoked
  from keybinds/autostart (wallpaper, screen record, power profile, brightness,
  workspace/window helpers).

## zsh config architecture

- `zsh/.zshenv` (stowed to `~/.zshenv`) is the bootstrap: it sets `ZDOTDIR` to
  `~/.config/zsh` and defines XDG paths, default apps, and `PATH`. Everything else
  is XDG-relative because of this.
- `config/.config/zsh/.zshrc` sources, in lexical order, every
  `conf.d/*.zsh` fragment. Add new shell config as a numbered fragment
  (`00-prompt`, `10-history`, `20-options`, `25-completion`, `30-plugins`,
  `40-aliases`, `50-fzf`, `55-atuin`) rather than editing `.zshrc`. Order
  matters: completion before plugins, atuin after fzf so atuin owns Ctrl-R.
- `config/.config/zsh/.zprofile` starts the session on tty1: a uwsm-managed
  Hyprland (`uwsm start`) when uwsm is installed, plain `start-hyprland`
  otherwise. Under uwsm, `autostart.lua` must keep the `uwsm finalize`
  command first — the compositor unit waits on it.

## Conventions

- Lua files are tab-indented; shell fragments and most other configs are
  space-indented. Match the file you are editing.
- The desktop targets a hybrid GPU laptop: Hyprland runs on the integrated GPU and
  `prime-run` is used for NVIDIA offload. Monitor rules in `monitors.lua` assume
  the laptop panel is `eDP-1` at scale `1.333333`.
- Theme is Everforest Dark Hard for terminal/TUI/bar surfaces (Waybar, kitty, nvim,
  fuzzel, mako, hyprlock, starship, yazi). GTK apps intentionally use a custom
  `enhanced-gruvbox` theme instead — do not "fix" it to Everforest. Keep color
  changes consistent with the palette of the surface being edited.

See `README.md` for the full keybind table, package list, and post-install service
setup.
