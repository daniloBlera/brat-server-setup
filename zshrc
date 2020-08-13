#
# ~/.zshrc
#
zstyle ':completion:*' menu select
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
bindkey -e

PROMPT='[%n@%m %1~]%# '

# Utility functions used to handle incompatibilities between shells (bash, zsh and fish)
set_env() {
	export $1=$2
}

source_if_exists() {
	[ -f "$1" ] && source "$1"
}

# If the directory exists and is not included in PATH, return TRUE
not_in_path() {
	[[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && return 0 || return 1
}

prepend_to_path() {
	not_in_path "$1" && export PATH="$1:$PATH"
}

append_to_path() {
	not_in_path "$1" && export PATH="$PATH:$1"
}

# Enable file managers cd on quit
source_if_exists "$HOME/.config/nnn/misc/quitcd.sh"
source_if_exists "$HOME/.config/lf/lfcd.sh"

# Enabling fuzzyfind
source_if_exists "$HOME/.fzf.zsh"

# Configuring path, environment variables and aliases
source_if_exists "$HOME/.config/shells/environment"
source_if_exists "$HOME/.config/shells/zsh_aliases"
source_if_exists "$HOME/.config/shells/aliases"
source_if_exists "$HOME/.config/shells/zsh_keybindings"

# Extra stuff
stty -ixon
