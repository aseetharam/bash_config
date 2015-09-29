# /etc/skel/.bashrc
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
 fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_paths ]; then
    . ~/.bash_paths
fi

if [ -f ~/.bash_libs ]; then
    . ~/.bash_libs
fi

if [ -f ~/.bash_ssh ]; then
    . ~/.bash_ssh
fi


PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;31m\]`git branch 2>/dev/null | grep ^* | tr -d \*` \[\033[01;34m\]\$\[\033[00m\] '


export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
export HISTCONTROL=ignoredups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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

