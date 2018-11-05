setpowerline() {
    local pl_base=$(pip3 show powerline-status | grep Location | awk '{print $2}')
    . ${pl_base}/powerline/bindings/bash/powerline.sh
    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
}

cpath() {
    greadlink -nf $1 | tee >(pbcopy)
    echo
}

nukenoneimages() {
    docker rmi -f $(docker images | grep -v codekitchen/dinghy-http-proxy | grep '<none>' | awk '{print $3}' | grep -v CONTAINER)
}

nukevolumes() {
    docker volume rm $(docker volume ls -q)
}

nukeallimagesexceptdinghy() {
    docker rmi $(docker images | grep -v codekitchen/dinghy-http-proxy | awk '{print $3}' | grep -v IMAGE)
}

nukeallcontainers() {
    docker rm $1 $(docker ps -a | grep -v codekitchen/dinghy-http-proxy | awk '{print $1}' | grep -v CONTAINER)
}

setdinghy() {
    export DOCKER_HOST=tcp://192.168.74.100:2376
    export DOCKER_CERT_PATH=/Users/paul/.docker/machine/machines/dinghy
    export DOCKER_TLS_VERIFY=1
    export DOCKER_MACHINE_NAME=dinghy
}

export CLICOLOR=1

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
