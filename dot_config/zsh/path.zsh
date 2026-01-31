# PATH settings
typeset -U path  # Remove duplicates

#--------------------------------------------------------------#
##        ローカル設定 (gitignore対象)                        ##
#--------------------------------------------------------------#
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local.zsh" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local.zsh"

#--------------------------------------------------------------#
##        PATH                                                ##
#--------------------------------------------------------------#
path=(
  $HOME/.cargo/bin           # rust
  /opt/homebrew/bin          # homebrew
  $HOME/go/bin               # Go
  $HOME/Library/pnpm         # pnpm
  $HOME/.local/bin           # local bin
  $HOME/dotfiles/bin         # dotfiles bin
  "$HOME/Library/Application Support/Coursier/bin"  # Coursier
  $HOME/.fzf/bin             # fzf
  $HOME/.bun/bin             # bun
  /opt/homebrew/opt/openjdk/bin  # openjdk
  $path
)

export PATH

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
