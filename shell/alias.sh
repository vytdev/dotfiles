# Shortcuts

# colourise ls
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='ls -l | grep "^d"'
alias lt='ls -tFlhr'
alias lg='ls -AFlhv --group-directories-first'
alias lh='ls -Flhv --group-directories-first'

# common git cmds
alias gs='git status'
alias gg='git log'
alias gd='git diff'

# other aliases
alias hist='history | less'
alias code='nvim'
alias m="eval \"\$(history | tac | sed 's/^[0-9 ]*//' | fzf)\""
alias py-venv='. ~/py-venv/bin/activate'

# yt-dlp aliases
alias ytdl="yt-dlp -x --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"
alias ytvd="yt-dlp -f 'bv*+ba/best' --merge-output-format mp4 -o '%(title)s.%(ext)s'"
alias ytav="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[abr>=160]' -o '%(title)s.%(ext)s'"

# fused mkdir + cd
mkcd() { mkdir -p "$1"; cd "$1"; }
