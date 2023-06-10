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
#     if (( ${+source_called} )); then
#         echo
#     fi
#     echo "--end $1"
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
export PYENV_ROOT="$HOME/.pyenv"
export LDFLAGS=-L/opt/homebrew/opt/openssl/lib

# The lower-case version of PATH is an array parameter
# bound to the scalar upper-case parameter.
export PATH=/bin:/usr/bin
path=('/opt/homebrew/opt/mysql@5.7/bin' $path)
path=('/usr/local/bin' $path)
path=('/usr/local/sbin' $path)
path=("${JAVA_HOME}/bin" $path)
path+=("${HOME}/.cargo/bin/cargo")
path=('/opt/homebrew/bin' $path)
path=('/opt/homebrew/sbin' $path)
#export PATH=${JAVA_HOME}/bin:/usr/local/bin:/usr/local/sbin:${HOME}/.cargo/bin/cargo
export PATH

##### DIVVY #####
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export DIVVY_DEV=/Users/pcallahan/code/divvy/divvy-dev
# Allow legacy credential logins
export DIVVY_AWS_LTC=1

# Enable all license features
export DIVVY_BYPASS_LICENSE_CHECKS=1

# Skip scheduler checks when running without the Makefile
export DIVVY_SKIP_SCHEDULER_CHECK=1

# Include license in EDH resources
export DIVVY_EDH_INCLUDE_LICENSE_FP=1

# Track high memory allocations
export DIVVY_MEMORY_LOGGER_THRESHOLD_MB=100

# Automatically run migrations whenever any divvy process starts
# DO NOT USE IN PRODUCTION #
export DIVVY_MIGRATE_DB=1

# ENG-15208 AWS Confused Deputy
# For development purposes only, use this to globally override the external_id
# used in all AssumeRole requests. This will bypass both legacy and
# Organization.aws_default_external_id values.
export DIVVY_AWS_DEFAULT_EXTERNAL_ID_OVERRIDE=dev2020

end_dot .zshenv
