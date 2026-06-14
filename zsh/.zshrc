HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# bindkey -v
zstyle :compinstall filename '/home/devuser/.zshrc'

autoload -Uz compinit
compinit

# Activate mise early so its shims (starship, zoxide, go, node...) are on PATH
# before anything below tries to init them. mise reads .nvmrc/.node-version/
# .tool-versions/mise.toml and switches on chpwd natively (replaces old nvm block).
eval "$(mise activate zsh)"

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
# (Node/Go/etc. version management handled by `mise activate` near the top.)
