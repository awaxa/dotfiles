case $(uname -s) in
        Linux)
                # ls color
                alias ls='ls --color=auto'
        ;;
        Darwin)
                # ls color
                alias ls='ls -G'
        ;;
esac

alias ll='ls -l'
alias l='ls -C'
alias ..='cd ..'
alias mkcd='_(){ mkdir $1; cd $1; }; _'

alias grep='grep --color=auto'
alias hgrep='<~/.bash_history grep'

alias j='jobs'

alias pull="git branch | \grep '*' | sed 's/* //' | xargs git pull origin"
alias push="git branch | \grep '*' | sed 's/* //' | xargs git push origin"

alias v='vagrant'

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
