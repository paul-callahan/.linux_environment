# `.zshrc' is sourced in interactive shells. It should contain commands to set
# up aliases, functions, options, key bindings, etc.
echo -n ".zshrc:"

# moved here because macos messes with this in /etc/zshprofile with /usr/libexec/path_helper -s
# The lower-case version of PATH is an array parameter
# bound to the scalar upper-case parameter.
export PATH=${PATH}
path=('/usr/local/bin' $path)
path=('/usr/local/sbin' $path)
path=("${JAVA_HOME}/bin" $path)
path+=("${HOME}/.cargo/bin/cargo")
path=("${HOME}/.local/bin" $path)
path=('/opt/homebrew/bin' $path)
path=('/opt/homebrew/sbin' $path)
#export PATH=${JAVA_HOME}/bin:/usr/local/bin:/usr/local/sbin:${HOME}/.cargo/bin/cargo
export PATH
echo setting PATH to $PATH

echo 3setting PATH to $PATH

# don't load stuff like PL10k if in an ai agent
if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "cursor" ]]; then
  PROMPT='$ '
  return
fi

# windsurf
if [[ -n "${CODEIUM_EDITOR_APP_ROOT+1}" || -n "${VSCODE_INJECTION+1}" ]]; then
  PROMPT='$ '
  return
fi

# powerlevel10k
source /opt/homebrew/Cellar/powerlevel10k/1.20.0/share/powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.linux_environment/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# aliases
source $HOME/.linux_environment/bash/.bash_aliases

# functions
source $HOME/.linux_environment/bash/.bash_functions

#autocompletion see OS file below

# fuzzy finder
[[ ! -f "${ZDOTDIR}"/"${OS_ENV}"/.fzf.zsh ]] || source "${ZDOTDIR}"/"${OS_ENV}"/.fzf.zsh

# zsh autosuggestion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# OS-specific zshrc.
source "${ZDOTDIR}"/"${OS_ENV}"/"zshrc-${OS_ENV}.sh"

# To customize prompt, run `p10k configure` or edit ~/.linux_environment/zsh/.p10k.zsh.
[[ ! -f ~/.linux_environment/zsh/.p10k.zsh ]] || source ~/.linux_environment/zsh/.p10k.zsh

end_dot .zshrc