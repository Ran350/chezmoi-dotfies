# Aliases

#--------------------------------------------------------------#
##        ファイル操作                                        ##
#--------------------------------------------------------------#
alias l='lsd'
alias ls='lsd'
alias la='lsd -a'
alias ll='lsd -l'
alias lla='lsd -la'
alias l1='lsd -1'
alias sl='ls'
alias cat='bat --paging=never'
alias cp='cp -i'
alias mv='mv -i'
alias dc='cd'
alias c='clear'
alias mkdir='mkdir -p'
alias :q='exit'
alias sudo='sudo '

if type trash-put &>/dev/null; then
    alias rm=trash-put
fi

#--------------------------------------------------------------#
##        開発ツール                                          ##
#--------------------------------------------------------------#
alias v='code'
alias mr='mise run '
alias tmux="zellij "

#--------------------------------------------------------------#
##        ディレクトリ移動                                    ##
#--------------------------------------------------------------#
alias cdd='cd ~/develop'

#--------------------------------------------------------------#
##        クリップボード (Linux)                              ##
#--------------------------------------------------------------#
if which xsel >/dev/null 2>&1; then
    alias pbcopy='xsel --input --clipboard'
fi
