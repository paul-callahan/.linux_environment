check_installed() {
    if [[ ! -f "$1" ]]; then
        brew install "$2"
    fi
}

check_installed /usr/local/opt/bash-completion/etc/bash_completion bash-completion
. /usr/local/opt/bash-completion/etc/bash_completion

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
