if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias la='ls -A'
alias lsd='ls -d */'
alias lsda='ls -Ad */ .*/'
alias ll='ls -l'
alias lla='ls -lhA'
alias llh='ls -lAhSr'
alias ltr='ls -Atr'
alias lltr='ls -Alhtr'
alias ltr1='ls -Atr1'
alias l='ls -C'

alias j='jobs'

alias pullm='git pull origin master'
alias pull="git branch | \grep '*' | sed 's/* //' | xargs git pull origin"
alias push="git branch | \grep '*' | sed 's/* //' | xargs git push origin"

alias grep='grep --color=auto'
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

alias tml='tmux ls'
alias tmls='tmux ls'
alias tma='tmux -2 attach-session -d -t'
alias tmn='tmux -2 new-session -s'

alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'

alias ff='find . -iname'

alias pyhttp='python -m SimpleHTTPServer'

alias resource='source ~/.bashrc'

alias mkcd='_(){ mkdir $1; cd $1; }; _'

alias hgrep='cat ~/.bash_history | grep'

alias colors='for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done'

alias which='command -v'

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

alias ec2killall='for i in $( ec2din | grep running | cut -f2 ) ; do ec2kill $i & done'
alias ec2hosts='ec2din | grep running | cut -f4'
