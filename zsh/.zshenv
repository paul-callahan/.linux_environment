# `.zshenv' is sourced on all invocations of the shell, unless the -f option
# is set. It should contain commands to set the command search path, plus
# other important environment variables. `.zshenv' should not contain
# commands that produce output or assume the shell is attached to a tty.
# note: any echo output here breaks scp/rsync.

export ZDOTDIR=${HOME}/.linux_environment/zsh

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
