# zinit と zsh プラグインの設定

#--------------------------------------------------------------#
##        zinit                                               ##
#--------------------------------------------------------------#
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

#--------------------------------------------------------------#
##        Powerlevel10k                                       ##
#--------------------------------------------------------------#
zinit ice depth=1
zinit light romkatv/powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#--------------------------------------------------------------#
##        Plugins                                             ##
#--------------------------------------------------------------#
# シンタックスハイライト（zeno.zsh との相性が良い）
zinit light zdharma-continuum/fast-syntax-highlighting

# 補完強化
zinit light zsh-users/zsh-completions

# zeno.zsh (fuzzy completion with fzf + abbrev snippets)
zinit ice lucid depth"1" blockf
zinit light yuki-yano/zeno.zsh

#--------------------------------------------------------------#
##        zeno.zsh keybindings                                ##
#--------------------------------------------------------------#
# 設定ファイルの場所を明示（これがないと動かない場合あり）
export ZENO_HOME=~/.config/zeno

if [[ -n $ZENO_LOADED ]]; then
  # 推奨キーバインド
  bindkey ' '  zeno-auto-snippet              # スペースで略語展開
  bindkey '^m' zeno-auto-snippet-and-accept-line  # Enterで展開して実行
  bindkey '^i' zeno-completion                # Tab で fzf 補完
  bindkey '^x^p' zeno-insert-snippet          # Ctrl-x Ctrl-p でスニペット挿入

  # zeno を発動させないキーバインド
  bindkey '^x ' zeno-insert-space             # Ctrl-x Space でスペース挿入
  bindkey '^x^m' accept-line                  # Ctrl-x Ctrl-m で展開せずに実行

  # 便利機能
  bindkey '^r' zeno-history-selection         # Ctrl-r で履歴検索
  bindkey '^x^f' zeno-ghq-cd                  # Ctrl-x Ctrl-f で ghq リポジトリ移動
fi

#--------------------------------------------------------------#
##        edit-command-line (コマンドラインをエディタで編集)  ##
#--------------------------------------------------------------#
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

#--------------------------------------------------------------#
##        mise run 補完 (Ctrl-x m)                            ##
#--------------------------------------------------------------#
function mise_tasks() {
  BUFFER="mise run "
  zle end-of-line
  zle zeno-completion
  if [[ "$BUFFER" != "mise run " ]]; then
    zle accept-line
  fi
}
zle -N mise_tasks
bindkey "^Xm" mise_tasks

#--------------------------------------------------------------#
##        npm/pnpm/bun run 補完 (Ctrl-x n)                    ##
#--------------------------------------------------------------#
function fzf_npm_scripts() {
  if ! type jq > /dev/null; then
    echo 'jq command is required'
    zle send-break
    return 1
  fi
  local prefix="npm"
  local git_root=$(git rev-parse --show-superproject-working-tree --show-toplevel 2>/dev/null | head -1)
  if [[ -f pnpm-lock.yaml || ( -n "$git_root" && -f "$git_root/pnpm-lock.yaml" ) ]]; then
    prefix="pnpm"
  elif [[ -f bun.lock || ( -n "$git_root" && -f "$git_root/bun.lock" ) ]]; then
    prefix="bun"
  fi
  BUFFER="$prefix run "
  zle end-of-line
  zle zeno-completion
  if [[ "$BUFFER" != "$prefix run " ]]; then
    zle accept-line
  fi
}
zle -N fzf_npm_scripts
bindkey "^Xn" fzf_npm_scripts
