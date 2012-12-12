if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls --color=always'
alias dir='dir --color=always'
alias vdir='vdir --color=always'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias j='jobs'

alias pullm='git pull origin master'
alias pull="git branch | \grep '*' | sed 's/* //' | xargs git pull origin"
alias push="git branch | \grep '*' | sed 's/* //' | xargs git push origin"

alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias grep_red='GREP_COLOR="1;31" \grep --color=always --line-buffered'
alias grep_yellow='GREP_COLOR="1;33" \grep --color=always --line-buffered'
alias grep_green='GREP_COLOR="1;32" \grep --color=always --line-buffered'
alias grep_blue='GREP_COLOR="1;34" \grep --color=always --line-buffered'
alias grep_purple='GREP_COLOR="1;35" \grep --color=always --line-buffered'
alias grep_teal='GREP_COLOR="1;36" \grep --color=always --line-buffered'

alias rgrep='grep -rns --color=auto'

alias rand='apg -a 0 -n 1 -m 16 -x 20 -M SNCL'
alias randns='apg -a 0 -n 1 -m 16 -x 20 -M NCL'

