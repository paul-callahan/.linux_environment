# `.zshenv' is sourced on all invocations of the shell, unless the -f option
# is set. It should contain commands to set the command search path, plus
# other important environment variables. `.zshenv' should not contain
# commands that produce output or assume the shell is attached to a tty.

echo -n ".zshenv: "
export ZDOTDIR=${HOME}/.linux_environment/zsh

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    export OS_ENV=linux
else
    export OS_ENV=macos
fi

echo " sourcing " "${ZDOTDIR}"/"${OS_ENV}"/"zshenv-${OS_ENV}.sh"
source "${ZDOTDIR}"/"${OS_ENV}"/"zshenv-${OS_ENV}.sh"


export HOMEBREW_NO_AUTO_UPDATE=1
export PATH=${JAVA_HOME}/bin:/usr/local/bin:/usr/local/sbin:${HOME}/.cargo/bin/cargo
