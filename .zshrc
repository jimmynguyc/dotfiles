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
plugins=(colored-man-pages colorize pip python brew osx zsh-syntax-highlighting)

# User configuration

export PATH="/Users/jimmy/.cargo/bin:/Users/jimmy/.rbenv/shims:/Users/jimmy/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/openssl/bin"

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

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
eval "$(pyenv init -)"

# pipenv
eval "$(pipenv --completion)"

# composer
export PATH="$HOME/.composer/vendor/bin:$PATH"

# yarn global
export PATH="$(yarn global bin):$PATH"

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
alias v='vim'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias getreleases="git br --all | grep -E 'origin\/r[0-9]+'"
alias t='tmux'
alias tns='tmux new-session -t'
alias foreman.start.procfile.dev="be foreman start -f Procfile.dev"
alias kali="docker run -t -i kalilinux/kali-linux-docker /bin/bash"
alias s='spotify'
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
alias sshamaterasu="ssh dev@amaterasu -p22000 -i ~/.ssh/id_rsa_mv"
alias cleardnscache="sudo killall -HUP mDNSResponder && echo macOS DNS Cache Reset"
alias pryme="bundle exec pry -r ./config/environment"
alias clearswp="rm -fvr ~/.local/share/nvim/swap/"

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

# Avvo
cloneavvo() {
	git clone git@github.com:avvo/$1.git
}



# SSH Agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa_mv
ssh-add ~/.ssh/id_rsa_personal

# node
export PATH="/usr/local/opt/node@6/bin:$PATH"
export PATH="/usr/local/opt/node@4/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH="$HOME/Projects/go"


# gem install mysql2 ssl issue fix
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# fix shotgun error (https://github.com/rtomayko/shotgun/issues/69)
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# zsh options
unsetopt AUTO_CD

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
export GPG_TTY=$(tty)


# OnDir
cd()
{
	builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

pushd()
{
	builtin pushd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

popd()
{
	builtin popd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

# Run ondir on login
eval "`ondir /`"



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jimmy/Projects/google-cloud-sdk-208.0.2-darwin-x86_64/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/jimmy/Projects/google-cloud-sdk-208.0.2-darwin-x86_64/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jimmy/Projects/google-cloud-sdk-208.0.2-darwin-x86_64/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/jimmy/Projects/google-cloud-sdk-208.0.2-darwin-x86_64/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/jimmy/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/jimmy/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/jimmy/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/jimmy/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# Kitty
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac


# Avvo k8s helper
for f in ~/Projects/avvo/k8s-helpers/*.sh; do source $f; done

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
