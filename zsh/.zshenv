# `.zshenv' is sourced on all invocations of the shell, unless the -f option
# is set. It should contain commands to set the command search path, plus
# other important environment variables. `.zshenv' should not contain
# commands that produce output or assume the shell is attached to a tty.

echo -n ".zshenv: "
export ZDOTDIR=${HOME}/.linux_environment/zsh

source() {
    if (( ${+source_called} )); then
        echo -n ", ${1}"
    else
        source_called='true'
        echo -n "  ${1}"
    fi
    builtin source $1
}

end_dot() {
    if (( ${+source_called} )); then
        echo
    fi
    echo "--end $1"
    unset source_called
}

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    export OS_ENV=linux
else
    export OS_ENV=macos
fi

source "${ZDOTDIR}"/"${OS_ENV}"/"zshenv-${OS_ENV}.sh"


export HOMEBREW_NO_AUTO_UPDATE=1
export NVM_DIR="$HOME/.nvm"


# The lower-case version of PATH is an array parameter
# bound to the scalar upper-case parameter.
export PATH=/bin:/usr/bin
path=('/usr/local/bin' $path)
path=('/usr/local/sbin' $path)
path=("${JAVA_HOME}/bin" $path)
path+=("${HOME}/.cargo/bin/cargo")
#export PATH=${JAVA_HOME}/bin:/usr/local/bin:/usr/local/sbin:${HOME}/.cargo/bin/cargo
export PATH

end_dot .zshenv
