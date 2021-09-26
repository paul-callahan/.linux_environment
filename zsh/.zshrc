# `.zshrc' is sourced in interactive shells. It should contain commands to set
# up aliases, functions, options, key bindings, etc.
echo -n ".zshrc:"

# OS-specifc zshrc
echo " sourcing " "${ZDOTDIR}"/"${OS_ENV}"/"zshrc-${OS_ENV}.sh"
source "${ZDOTDIR}"/"${OS_ENV}"/"zshrc-${OS_ENV}.sh"

# powerlevel10k
source /usr/local/powerlevel10k/powerlevel10k.zsh-theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.linux_environment/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history
export HISTSIZE=9000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt histignorealldups

# aliases
source $HOME/.linux_environment/bash/.bash_aliases
# functions
source $HOME/.linux_environment/bash/.bash_functions
#autocompletion see OS file
# autoload -U +X compinit && compinit


# To customize prompt, run `p10k configure` or edit ~/.linux_environment/zsh/.p10k.zsh.
[[ ! -f ~/.linux_environment/zsh/.p10k.zsh ]] || source ~/.linux_environment/zsh/.p10k.zsh
