# `.zshenv' is sourced on all invocations of the shell, unless the -f option
# is set. It should contain commands to set the command search path, plus
# other important environment variables. `.zshenv' should not contain
# commands that produce output or assume the shell is attached to a tty.

# note:  echo output causes scp/rsync to fail
#echo -n ".zshenv: "
export ZDOTDIR=${HOME}/.linux_environment/zsh

source() {
    if (( ${+source_called} )); then
#         echo -n ", ${1}"
    else
        source_called='true'
#         echo -n "  ${1}"
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

###############################
## Env variables here
###############################

export HOMEBREW_NO_AUTO_UPDATE=1

export PYENV_ROOT="$HOME/.pyenv"
# export LDFLAGS=-L/opt/homebrew/opt/openssl/lib


# history
export HISTSIZE=9000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt histignorealldups


# Node Version Manager
export NVM_DIR="$HOME/.nvm"
# zsh -x $NVM_DIR/nvm.sh
[[ ! -f "$NVM_DIR/nvm.sh" ]] || time source "$NVM_DIR/nvm.sh"
[[ ! -f "$NVM_DIR/bash_completion" ]] || time source "$NVM_DIR/bash_completion"

echo 2setting PATH to $PATH


end_dot .zshenv
