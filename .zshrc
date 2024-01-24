# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH=/Users/jimmy/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dst"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colored-man-pages colorize rails ruby brew macos zsh-syntax-highlighting zsh-peco-history git zsh-z)

# User configuration

export PATH="/Users/jimmy/.cargo/bin:/Users/jimmy/.pyenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/opt/homebrew/opt/openssl@1.1/bin:/opt/homebrew/opt/openssl@3/bin:/sbin:/usr/local/opt/openssl/bin"

# Postgres
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Initialize Homebrew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# heroku
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

	autoload -Uz compinit
	compinit
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='nvim'
export GIT_EDITOR='nvim'

# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

# pyenv
eval "$(pyenv init -)"

# pipenv
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

# composer
export PATH="$HOME/.composer/vendor/bin:$PATH"

# yarn global
#export PATH="$(yarn global bin):$PATH"

# Aliases
alias rs='rails s'
alias be='bundle exec'
alias bers='bundle exec rails s'
alias rc='rails c'
alias berc='bundle exec rails c'
alias pg='ps aux | grep'
alias sites='cd ~/Projects'
alias mysql.start='mysql.server start'
alias mysql.stop='mysql.server stop'
alias mysql.console='mysql -uroot'
alias mongodb.start='mongod --config /usr/local/etc/mongod.conf'
alias postgresql.start='postgres -D /usr/local/var/postgres'
alias redis.start='redis-server /usr/local/etc/redis.conf'
alias annotate.models='bundle exec annotate --exclude tests,fixtures,factories,serializers,specs,controllers,helpers,scaffolds'
alias vg='vagrant'
alias fixenter='stty sane'
alias ejectcd='drutil eject external'
alias v='nvim'
alias vim='nvim'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias getreleases="git br --all | grep -E 'origin\/r[0-9]+'"
alias t='tmux'
alias tns='tmux new-session -t'
alias kali="docker run -t -i kalilinux/kali /bin/bash"
alias kalimsf="docker run -t -i kalilinux/msf /bin/bash"
alias p='pomo'
alias tailf='tail -f'
alias c='code'
alias gourceit="rm -f gource_captions.txt gource_hashes.txt && git log --pretty='%at|%h > %s' | sort -n > gource_captions.txt && git log --pretty='%at|%H' > gource_hashes.txt && gource --load-config ~/.gource/gource.conf --caption-file gource_captions.txt"
alias kubegetcreds='f() { export KUBE_NAMESPACE=essayjack-$1; gcloud container clusters get-credentials essayjack-$1-cluster };f'
alias kubegetpods='kubectl get pods --all-namespaces'
alias kubesshpod='f() {
	pod=$1
	shift
	name=$1
	shift
	kubectl exec -it $pod -c $name --namespace=$KUBE_NAMESPACE -- $@
};f'
alias cleardnscache="sudo killall -HUP mDNSResponder && echo macOS DNS Cache Reset"
alias pryme="bundle exec pry -r ./config/environment"
alias clearswp="rm -fvr ~/.local/state/nvim/swap/"

# Glacier commands
alias gl-describe-sg-vault="aws glacier describe-vault --account-id - --vault-name Backups --profile glacier-sg"
alias gl-retrieve-inventory-sg-vault="aws glacier initiate-job --account-id - --vault-name Backups --profile glacier-sg --job-parameters '{\"Type\": \"inventory-retrieval\"}'"
gl-describe-job-sg-vault() {
	aws glacier describe-job --account-id - --vault-name Backups --profile glacier-sg --job-id="$1" $2
}
gl-get-job-output-sg-vault() {
	aws glacier get-job-output --account-id - --vault-name Backups --profile glacier-sg --job-id="$1" $2
}
gl-retrieve-archive-sg-vault() {
	aws glacier initiate-job --account-id - --vault-name Backups --profile glacier-sg --job-parameters '{"Type": "archive-retrieval", "ArchiveId": "$1"}'
}
gl-upload-sg-vault(){
	aws glacier upload-archive --account-id - --profile glacier-sg --vault-name Backups --archive-description "$1" --body $2
}
gl-cmd-sg-vault(){
	COMMAND=$1
	shift
	aws glacier $COMMAND --account-id - --profile glacier-sg --vault-name Backups $*
}

alias gl-describe-us-vault="aws glacier describe-vault --account-id - --vault-name my_backup --profile glacier-us"
alias gl-retrieve-inventory-us-vault="aws glacier initiate-job --account-id - --vault-name my_backup --profile glacier-us --job-parameters '{\"Type\": \"inventory-retrieval\"}'"
gl-describe-job-sg-vault() {
	aws glacier describe-job --account-id - --vault-name my_backup --profile glacier-us --job-id="$1" $2
}
gl-get-job-output-us-vault() {
	aws glacier get-job-output --account-id - --vault-name my_backup --profile glacier-us --job-id="$1" $2
}
gl-retrieve-archive-us-vault() {
	aws glacier initiate-job --account-id - --vault-name my_backup --profile glacier-us --job-parameters '{"Type": "archive-retrieval", "ArchiveId": "$1"}'
}
gl-upload-us-vault(){
	aws glacier upload-archive --account-id - --profile glacier-us --vault-name my_backup --archive-description "$1" --body $2
}

# k8s
alias kgp="kubectl get pod"
alias kgd="kubectl get deployment"
alias kcd="kubectl create deployment"
alias kgrs="kubectl get replicaset"
alias kds="kubectl describe"
alias kaf="kubectl apply -f"
alias kai="cat <<EOF | kubectl apply -f -"

# Ruby Webrick
alias webrick="ruby -run -ehttpd"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zsh options
unsetopt AUTO_CD

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
export GPG_TTY=$(tty)


# Kitty
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
alias icat="kitty +kitten icat"
alias dif="kitty +kitten diff"
alias bcast="kitty +kitten broadcast"
#alias s="alias s=kitty +kitten ssh"
alias cb="kitty +kitten clipboard"


case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac


# Force xterm-color on various stuffs
alias ssh='TERM=xterm-color ssh'
alias vagrant='TERM=xterm-color vagrant'

# Fortune + cowsay
#fortune | cowsay

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# ansible
export ANSIBLE_NOCOWS=1

# exa
alias ls="exa"
alias lst="exa --tree --level"

# Unicode for less
export LESSCHARSET=utf-8
alias less="less -r"

# Workarounds
alias fixnode17ssl="export NODE_OPTIONS=--openssl-legacy-provider"  # node17 issue with ssl https://medium.com/the-node-js-collection/node-js-17-is-here-8dba1e14e382
alias fixarm64docker="export DOCKER_DEFAULT_PLATFORM=linux/amd64"
fixarm64docker

# Viaeurope Heroku
alias viaprod="env HEROKU_APP=viaeurope-production"
alias viastag="env HEROKU_APP=viaeurope-staging"
alias viasand="env HEROKU_APP=viaeurope-sandbox"
alias viaprodc="viaprod heroku run RAILS_LOG_LEVEL=debug bin/rails console"
alias viastagc="viastag heroku run RAILS_LOG_LEVEL=debug bin/rails console"
alias viasandc="viasand heroku run RAILS_LOG_LEVEL=debug bin/rails console"
alias viaprodpsql="psql -h ec2-54-220-131-73.eu-west-1.compute.amazonaws.com -Ujimmy d2tbkkj2ess321"

# NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Powerlevel10k Prompt
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Folder md5sum
md5sumf() {
  find $1 -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# xelatex
export PATH="/usr/local/texlive/2021basic/bin/universal-darwin/:$PATH"

# kali docker
alias kali="docker run -it mykali/with-metapackage"

curltime() {
  curl -w @- -o /dev/null -s "$@" <<'EOF'
      time_namelookup:  %{time_namelookup}s\n
         time_connect:  %{time_connect}s\n
      time_appconnect:  %{time_appconnect}s\n
     time_pretransfer:  %{time_pretransfer}s\n
        time_redirect:  %{time_redirect}s\n
   time_starttransfer:  %{time_starttransfer}s\n
                      -----------\n
           time_total:  %{time_total}s\n
EOF
}

# rubocop
export XDG_CONFIG_HOME="$HOME/.config"

# ViaEurope
export VIA_USER="jimmy@viaeurope.com"

# ruby-pg segfault workaround
# https://github.com/ged/ruby-pg/issues/311#issuecomment-561927000
export PGGSSENCMODE="disable"

# Fix GPG signing issue
export GPG_TTY=$TTY

