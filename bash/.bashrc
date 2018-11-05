unamestr=`uname`


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


if [ -f ~/.linux_environment/bash/.bash_functions ]; then
    source ~/.linux_environment/bash/.bash_functions
else
    echo "~/.linux_environment/bash/.bash_functions not found."
fi


export CLICOLOR=1

if [[ "$unamestr" == 'Linux' ]]; then
    export JAVA_HOME=`java -XshowSettings:properties -version 2>&1    | sed '/^[[:space:]]*java\.home/!d;s/^[[:space:]]*java\.home[[:space:]]*=[[:space:]]*//'`
    export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

else
    export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
fi

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
if [ -f $HOME/.cargo/env ]; then
    . $HOME/.cargo/env
fi


export PATH=${PATH}:${JAVA_HOME}/bin

export TCELL_SRC_ROOT=~/dev/tcell
export TCELL_DEV_SERVER=minty.local

setpowerline

. /usr/local/etc/bash_completion.d/git-completion.bash

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
#export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTCONTROL=erasedups

alias tailtopic="docker exec  tcell_kafka_1 /opt/kafka_2.11-0.10.1.0/bin/kafka-console-consumer.sh --zookeeper zookeeper --from-beginning --topic"
alias lstopics="docker exec  tcell_kafka_1 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --zookeeper zookeeper --list"
alias dc="docker-compose"
alias ssh-xhyve="docker run --rm -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"
alias cdja="cd ${TCELL_SRC_ROOT}//agents/jvm/"
alias startportainer="docker run --name portainer --privileged -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash



# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi
