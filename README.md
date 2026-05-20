# dotfiles

MacOS configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
    aerospace/      # Aerospace window manager config
    ghostty/        # Ghostty terminal config
    nvim/           # Neovim configuration
    sketchybar/     # Sketchybar config
    themes/         # Shared theme system (Sketchybar + Ghostty)
```

## Prerequisites

### Core Tools
```bash
brew install stow
```

### Application Dependencies

**Aerospace:**
```bash
brew install nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install borders
```

**Sketchybar:**
```bash
brew install sketchybar
brew install --cask sf-symbols
brew tap FelixKratz/formulae
brew install sketchybar-app-font
brew install font-hack-nerd-font
```

**Neovim:**
```bash
brew install neovim
```

**Ghostty:**
```bash
brew install --cask ghostty
```

## Installation

From the dotfiles directory, stow individual packages:

```bash
cd ~/dotfiles
stow aerospace
stow ghostty
stow nvim
stow sketchybar
stow themes
```

Or stow all configs at once:

```bash
stow */
```

## Uninstall

```bash
stow -D aerospace ghostty nvim sketchybar themes
```

## Adding New Configs

1. Create a new directory: `mkdir -p dotfiles/package-name`
2. Mirror the home directory structure inside it
3. Copy your configs: `cp ~/.config/example dotfiles/package-name/.config/`
4. Stow it: `stow package-name`

## Theme System

> WARNING **Work in Progress**: The automatic theme switching system is still under development and currently very buggy. Manual theme switching is more reliable.

The theme system lives in the `themes/` package at `~/.config/themes/` and applies across multiple apps — currently Sketchybar and Ghostty.

**How it works:**

1. **`~/.config/themes/theme_config.sh`** - Configuration file where you set:
   - `DARK_THEME` - Theme to use in dark mode (default: `gruvbox`)
   - `LIGHT_THEME` - Theme to use in light mode (default: `gruvbox-light`)
   - `AUTO_SWITCH_ENABLED` - Enable/disable automatic switching (default: `false`)

2. **`~/.config/sketchybar/auto_theme.sh`** - Monitors system appearance and switches themes automatically

3. **`~/.config/sketchybar/colors.sh`** - Loads the current theme from `~/.config/themes/.theme`

4. **`~/.config/themes/themes/`** - Individual theme files defining color and app variables:
   - `GHOSTTY_THEME` - Ghostty theme name to apply
   - `BAR_COLOR` - Status bar background
   - `ITEM_BG_COLOR` - Item background
   - `ITEM_LABEL_COLOR` - Label text color
   - `ITEM_ICON_COLOR` - Icon color
   - `ITEM_BORDER_COLOR` - Border color
   - `WORKSPACE_*_BORDER` - Aerospace workspace border colors

**Available themes:** `gruvbox`, `gruvbox-light`, `bearded_dark`, `neon`, `sky`, `default`

**Switching themes manually:**

```bash
set_theme <theme_name>   # switch to a specific theme
set_theme auto           # re-enable automatic dark/light switching
```

The `set_theme` command (installed to `~/.local/bin/`) reloads Sketchybar and hot-reloads Ghostty without restarting it.

## Known Issues

- **Theme System**
  - Gruvbox-light theme is still a work in progress
  - Does not support updating borders color
  - Auto-switch is very buggy and unreliable

- **Music Player**
  - Uses the private `MediaRemote` framework via a Swift script — works system-wide but may break on macOS updates

- **Multi-monitor Setup**
  - Aerospace space highlights in Sketchybar are janky and need polish
