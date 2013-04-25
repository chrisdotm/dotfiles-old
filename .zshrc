bindkey -e
# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
BATCH=0
if touch ~/.noworky 2> /dev/null; then
alias history='history -1000'
alias rdesktop="rdesktop -g1675x1020"
alias geeknote="python /media/16gigger/geeknote/geeknote.py"
alias tmux="tmux -2"
setopt hist_ignore_dups
setopt append_history
fi

# No terminal beep
setopt no_beep

setopt autocd
# Set the editor to vim
export EDITOR="vim"

# Keybindings
# Let ^W delete to slashes - zsh-users list, 4 Nov 2005
backward-delete-to-slash () {
    local WORDCHARS=${WORDCHARS//\//}
    zle .backward-delete-word
}
zle -N backward-delete-to-slash

bindkey "^W" backward-delete-to-slash
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '\C-u' backward-kill-line
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# The prompt, looks like bash prompt
export PS1='%F{blue}[bg:%(1j.%j.)]%F{grey} %n@%m:%~%(?,%F{green} [:%)],%F{yellow} [%? %F{red}:(])%f%# '


# Completion
zmodload zsh/complist
zstyle ':completion:*:default' menu select
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _complete _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' substitute 0
if touch ~/.noworky 2> /dev/null; then
    autoload -U compinit
    compinit -D
fi

# Alias ls to use colors if we have GNU ls
# with a new enough version for color:
(ls --help 2>/dev/null |grep -- --color=) >/dev/null && \
        alias ls='ls -F --color=auto'
(uname -a | grep -i freebsd) >/dev/null && \
    alias ls='ls -G'

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=33:so=01;35:bd=33;01:cd=33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'



export HADOOP=/usr/lib/hadoop
export HADOOP_HOME=/usr/lib/hadoop
export HADOOP_STREAMING_JAR=$HADOOP_HOME/contrib/streaming/hadoop-streaming-0.20.2-cdh3u2.jar
export PATH=~/bin:/usr/lib/hadoop/bin:$PATH:~/svnworkspace/hive/tools:~/bin/vim-bundle

alias hcat='hadoop fs -cat'
alias hdf='hadoop dfsadmin -report'
alias hls='hadoop fs -ls'
alias hmd='hadoop fs -mkdir'
alias hmv='hadoop fs -mv'
alias hrmr='hadoop fs -rmr'
alias hput='hadoop fs -put'
alias hget='hadoop fs -get'
alias hgetmerge='hadoop fs -getmerge'

alias sup='svn update'
alias sst='svn st'
alias pt='sudo puppet agent -t'
alias ptt='sudo puppet agent -t --noop'
alias psp='ps aux | grep puppet'
alias rp='sudo /usr/local/etc/rc.d/puppet restart'
alias nc='nagios -v /usr/local/etc/nagios/nagios.cfg'
alias nr='/usr/local/etc/rc.d/nagios reload'
alias tial='tail'
alias mkdoc='pushd ~/checkouts/puppet/dev/ && rm -r ./doc || true &&  puppet doc --mode rdoc --manifestdir ~/checkouts/puppet/dev/manifests --modulepath ~/checkouts/puppet/dev/modules:~/checkouts/puppet/dev/services && sudo rsync -avz --delete ./doc/ /usr/local/www/doc/ && popd'
function findhost {
	find . -name "*$1*"
}
bindkey '^Xr' history-incremental-pattern-search-backward
bindkey '^Xs' history-incremental-pattern-search-forward

bindkey "A" up-line-or-history
bindkey "B" down-line-or-history

fpath=(~/bin/zsh $fpath)

#GANKED FROM https://github.com/spazm/config/blob/master/zshrc
xterm_title()
{
    builtin print -n -P -- "\e]0;$@\a"
}
screen_title()
{
    builtin print -n -P -- "\ek$@\e\\"
    xterm_title "$@"
}

case $TERM in
    screen|screen-w|screen-256color|screen-256color-bce)
        alias titlecmd="screen_title"
    ;;
    xterm|xterm-256color)
        alias titlecmd="xterm_title"
    ;;
    *)
        alias titlecmd=":"
    ;;
esac

ssh() {
    titlecmd "$1";
    command ssh $*;
    titlecmd "$HOSTNAME";
}
 fliptable() {
    echo "（╯°□°）╯︵ ┻━┻"
}

moveasp() {
	mv "$1/asp" "$1/asp_preslush_orig" &&  mv "$1/asp_slush_checkout" "$1/asp"
}
moveresources() {
	mv "$1/resources" "$1/resources_preslush_orig" &&  mv "$1/resources_slush_checkout" "$1/resources"
}

moveemailtemplates() {
	mv "$1/email-templates" "$1/email-templates_preslush_orig" && mv "$1/email-template_trunk_checkout" "$1/email-templates"
}

madatadam() {
    cowsay "Stop being a jerk Adam Landry"
}

difftrunkbranch() {
    branch="x$1"
    if [[ "$branch" == "x" ]]; then
        return 2
    fi
    pushd
    cd /media/16gigger/diffs/Branch_Diffs/
    /usr/bin/svn diff https://svn.csnzoo.com/svn/puppet/trunk https://svn.csnzoo.com/svn/puppet/branches/$1 > trunk_$1-`/bin/date +%Y%m%d`.diff
    popd
}
prettydiffs() {
    pushd
    cd /media/16gigger/diffs/Branch_Diffs/
    f="x$1"
    /bin/echo "cd /media/16gigger/diffs/Branch_Diffs/"
    if [[ "$f" == "x" ]]; then
        /usr/bin/find -name "trunk_*.diff" | while read file; do /bin/echo "cat $file | diff2html.py > $file.html"; done
    else
        /usr/bin/find -name "trunk_$1*.diff" | while read file; do /bin/cat $file | diff2html.py > $file.html; done
    fi
    popd
}
