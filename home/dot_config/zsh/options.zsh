# zsh options

#--------------------------------------------------------------#
##        補完設定                                            ##
#--------------------------------------------------------------#
autoload -U compinit && compinit -u
autoload -Uz colors && colors && zstyle ':completion:*' list-colors "${LSCOLORS}"

#--------------------------------------------------------------#
##        setopt                                              ##
#--------------------------------------------------------------#
setopt EXTENDED_GLOB

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word

# 補完リストの表示間隔を狭くする
setopt list_packed

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# cdなしでディレクトリを移動
setopt auto_cd

# cd - でTabで、cdでディレクトリの移動履歴表示
setopt auto_pushd

# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 高機能なワイルドカード展開を使用する
setopt extended_glob
