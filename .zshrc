# Path to your oh-my-zsh installation. Obviously point it wherever you put it.
export ZSH="/Users/jeremy.freeman/.oh-my-zsh"

# Bullet train from the wiki guide. https://github.com/caiogondim/bullet-train.zsh
ZSH_THEME="bullet-train"

# Comment the following line to disable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="yyyy-mm-dd"

# https://github.com/zsh-users/zsh-completions
plugins=(
  brew
  docker
  encode64
  git
  helm
  history
  jsontools
  kops
  kubectl
  last-working-dir
  python
  ruby
  sudo
  terraform
  terragrunt
  vault
  zsh-completions
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# For autocomplete. Required for zsh-completions plugin above.
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Load Vault autocompletions.
complete -o nospace -C /usr/local/bin/vault vault

# This is an example of a theme exposed config.
BULLETTRAIN_PROMPT_CHAR="😬"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_CONTEXT_HOSTNAME=parsable.com
BULLETTRAIN_DIR_BG=magenta
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_AWS_BG=green
BULLETTRAIN_AWS_FG=black
BULLETTRAIN_KCTX_BG=cyan
BULLETTRAIN_KCTX_FG=black
BULLETTRAIN_KCTX_KUBECTL=true
BULLETTRAIN_KCTX_NAMESPACE=true
BULLETTRAIN_KCTX_PREFIX="📦"
BULLETTRAIN_EXEC_TIME_ELAPSED=5
BULLETTRAIN_TIME_12HR=true
BULLETTRAIN_PROMPT_ORDER=(
  time
  context
  git
  dir
  aws
  custom
  kctx
  status
  cmd_exec_time
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
# SECTION FOR PATH CHANGES:

# Add Python stuff to path.
export PATH=$PATH:$HOME/Library/Python/3.7/bin
export PATH="/usr/local/opt/helm@2/bin:$PATH"
export PATH=$PATH:/Users/jeremy.freeman/Library/Python/2.7/bin
export PATH=$PATH:/usr/local/homebrew/bin
export PATH=$PATH:/Users/jeremy.freeman/git/devops/scripts
export PATH=$PATH:/Users/jeremy.freeman/git/devops/tfstate_migrate
export PATH=$PATH:/Users/jeremy.freeman/bin
export PATH=$PATH:/Users/jeremy.freeman/go/bin
export PATH=/usr/local/homebrew/Cellar/tfenv/2.0.0/bin:$PATH
export PATH=/usr/local/homebrew/Cellar/openjdk/18.0.2.1/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export SHOW_AWS_PROMPT=false

# See hidden files in Finder.
defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app

# Escapes square brackets automatically.
alias rake='noglob rake'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Export git home
export GIT_HOME=$HOME/git

# Command line prefs
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias gs='git status'                       # Override ghostscript
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias salt-ssh-cd="cd $GIT_HOME/salt-formulas/_ssh_master_dev"
alias sed=gsed

alias kubectx='add-zsh-hook precmd set-kubeconfig && kubectx'
alias gl_check='gitleaks --path=$PWD -v -c ~/config.toml --additional-config=./.gitleaks.toml --threads=4 --no-git --leaks-exit-code=0'
eval "$(direnv hook zsh)"
function set-kubeconfig {
  # Sets the KUBECONFIG environment variable to a dynamic concatentation of everything
  # under ~/.kube/configs/*
  # Does NOT overwrite KUBECONFIG if the KUBECONFIG_MANUAL env var is set

  if [ -d ~/.kube/configs ]; then
    if [ -z "$KUBECONFIG_MANUAL" ]; then
      export KUBECONFIG=~/.kube/config$(find ~/.kube/configs -type f 2>/dev/null | xargs -I % echo -n ":%")
    fi
  fi
}

# Enable AWS autocomplete
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

compdef sshs='ssh'
