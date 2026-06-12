# External tools initialization

#--------------------------------------------------------------#
##        Homebrew (macOS)                                    ##
#--------------------------------------------------------------#
if [[ "$OSTYPE" == darwin* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#--------------------------------------------------------------#
##        bun                                                 ##
#--------------------------------------------------------------#
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

#--------------------------------------------------------------#
##        mise (runtime version manager)                      ##
#--------------------------------------------------------------#
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

#--------------------------------------------------------------#
##        zellij (terminal multiplexer)                       ##
#--------------------------------------------------------------#
# https://zellij.dev/documentation/integration.html
# 既存セッションがあれば自動アタッチ、無ければ新規作成し、
# zellij を抜けるとシェルも終了する。
# - 既に zellij 内 ($ZELLIJ) なら入れ子を防ぐためスキップ
# - VS Code 等のエディタ内蔵ターミナルでは自動起動しない
if command -v zellij &>/dev/null && [[ -z "$ZELLIJ" && "$TERM_PROGRAM" != "vscode" ]]; then
    export ZELLIJ_AUTO_ATTACH=true
    export ZELLIJ_AUTO_EXIT=true
    eval "$(zellij setup --generate-auto-start zsh)"
fi
