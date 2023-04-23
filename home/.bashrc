eval "$(zoxide init bash)"
alias zd="find / -type d 2>/dev/null | fzf"
alias zf="find / -type f 2>/dev/null | fzf"

PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]@\h:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]: \[$(tput sgr0)\]"
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
export LESS='-R --use-color -Dd+r$Du+b'
alias ls='ls --color=auto'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
alias code='codium'
