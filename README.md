# Dotfiles

[![Test Ubuntu](https://github.com/Ran350/chezmoi-dotfies/actions/workflows/test-ubuntu.yml/badge.svg)](https://github.com/Ran350/chezmoi-dotfies/actions/workflows/test-ubuntu.yml)
[![Test macOS](https://github.com/Ran350/chezmoi-dotfies/actions/workflows/test-macos.yml/badge.svg)](https://github.com/Ran350/chezmoi-dotfies/actions/workflows/test-macos.yml)

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

## 📚 Documentation

- [gitconfig テンプレートについて](docs/gitconfig-template.md) - `.gitconfig` のテンプレート機能の説明

## 🖥️ Local Configuration

For machine-specific settings, create `~/.config/zsh/local.zsh`:

```bash
cp ~/.config/zsh/local.zsh.example ~/.config/zsh/local.zsh
```

This file is gitignored and can contain:

- Proxy settings
- Machine-specific aliases
- Work-related configurations
