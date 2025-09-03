HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# bindkey -v
zstyle :compinstall filename '/home/devuser/.zshrc'

autoload -Uz compinit
compinit

# Sets up some autocompletion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Because we are based
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias gobench='find $(git rev-parse --show-toplevel) -name "*.go" | entr go test -bench=. -run=^$ -benchmem . -cp'
alias gotest='find $(git rev-parse --show-toplevel) -name "*.go" | entr go test -v .'   
# Load starship
eval "$(starship init zsh)"
# Prompt Engineering Starship
PROMPT_NEEDS_NEWLINE=false

precmd() {
  if [[ "$PROMPT_NEEDS_NEWLINE" == true ]]; then
    echo
  fi
  PROMPT_NEEDS_NEWLINE=true
}

clear() {
  PROMPT_NEEDS_NEWLINE=false
  command clear
}
eval "$(zoxide init zsh)"
source <(fzf --zsh)

aql() {
    docker run --rm --network verstappen_default aerospike/aerospike-tools aql --host aerospike-1 -o json -c "$*"
}
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm, without auto-using the default version

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
