umask 002

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(parse_git_branch)$ "

export HISTIGNORE="&:ls:[bf]g:exit"
export HISTFILESIZE=10000
export HISTCONTROL=erasedups
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export DJANGO_SOCKET=/var/run/hatchery/$USER
alias runserver="./manage.py runfcgi socket=$DJANGO_SOCKET umask=0002 method=prefork daemonize=false"
