# Shortcuts

# colorize ls
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases
alias lk='ls -alFhv --group-directories-first'
alias ll='ls -lFhv --group-directories-first'
alias lt='ls -trlFh'

# hot git cmds
alias gs='git status'
alias gg='git log'
alias gd='git diff'

# other aliases
alias vim='nvim'
alias m="eval \"\$(history | tac | sed 's/^[0-9 ]*//' | fzf)\""
alias py-venv='. ~/py-venv/bin/activate'  # global py-venv for scripts
