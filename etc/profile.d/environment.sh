umask 002

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(parse_git_branch)$ "

export HISTIGNORE="&:ls:[bf]g:exit"
export HISTFILESIZE=10000
export HISTCONTROL=erasedups
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export PORT=`grep $USER /etc/profile.d/ports | awk '{print $2}'`
export NGINX_PORT=`grep $USER /etc/profile.d/nginx_ports | awk '{print $2}'`
alias runserver="bash -c \"cd ~$USER/project; ./manage.py runfcgi method=threaded daemonize=false host=localhost port=$PORT\""

echo "********************************************************"
echo "* Hatchery Server: http://dev.hatcherydevshop.com/$USER/"
echo "********************************************************"
