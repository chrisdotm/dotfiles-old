# History 
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
alias history='history -1000'
setopt hist_ignore_dups 
setopt append_history

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

# The prompt, looks like bash prompt 
export PS1='%n@%m:%~%# '

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
autoload -U compinit
compinit -u

# Alias ls to use colors if we have GNU ls 
# with a new enough version for color:
(ls --help 2>/dev/null |grep -- --color=) >/dev/null && \
        alias ls='ls -F --color=auto'

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=33:so=01;35:bd=33;01:cd=33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'

# Directory in the titlebar
chpwd() {
  [[ -t 1 ]] || return
    case $TERM in
      sun-cmd) print -Pn "\e]l%~\e\\"
        ;;
      *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
        ;;
    esac
}

# Call these so the terminal initiates with them
chpwd
