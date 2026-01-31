# Dotfiles

My dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## 🚀 Installation

### Quick Install

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/ran350/chezmoi-dotfiles.git
```

## 🛠️ Usage

```bash
# Edit dotfiles
chezmoi edit <file>

# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Update from remote
chezmoi update

# Add a new file
chezmoi add ~/.config/some/file
```

## 🖥️ Local Configuration

For machine-specific settings, create `~/.config/zsh/local.zsh`:

```bash
cp ~/.config/zsh/local.zsh.example ~/.config/zsh/local.zsh
```

This file is gitignored and can contain:

- Proxy settings
- Machine-specific aliases
- Work-related configurations
