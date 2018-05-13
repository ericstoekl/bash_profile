# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
alias c='clear'
alias le='xset led'
le
#redshift &

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
PS1='\w \$ '
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# BASH

alias luu='ls -al /dev/disk/by-uuid/'
function resetwifi_func () {
    sudo modprobe -r 8188eu
    sudo insmod ~/rtl8188eu/8188eu.ko
}
alias resetwifi='resetwifi_func'
alias lddg='links duckduckgo.com'
alias fb='./build.sh; mv ./faas-cli ~/github/go/bin/faas-cli'
alias mvf='mv faas-cli ~/github/go/bin/faas-cli'
alias fbt='go test $(go list ./... | grep -v /vendor/ | grep -v /template/) -cover'
alias fzff='find * -type f | fzf'
alias fzfo='vim `fzff`'
alias fn='find . -name '
alias vb='vim ~/.bashrc'
alias sp='source ~/.bashrc'
alias xargz="tr '\n' '\0' | xargs -0 -n1"
alias l='ls -la'
function grepfunc () {
    grep -rIin "$1" *
}
alias gp='grepfunc'

function grepfunc_extra () {
    grep -rIin "$1" * "$@"
}
alias gpe='grepfunc_extra'

function grepfuncsensitive () {
    grep -rIn "$1" * "$@"
}
alias gpi='grepfuncsensitive'

function grepreplace () {
    grep -rl $1 * | xargs sed -i "s/$1/$2/g"
}
alias gr='grepreplace'

function specificline () {
    sed "$1q;d"
}
alias sl='specificline'

function awk_columnnum () {
    awk "{print \$$1}"
}
alias an='awk_columnnum'

function slan_func () {
    sl $1 | an $2
}
alias slan='slan_func'

alias sb='od -c -b'

alias curlp='curl --data-binary @-'

alias vimt='vim -u ~/.vimrc.go'
export VISUAL=vim
export EDITOR="$VISUAL"

alias naut='nautilus `pwd`'

#GPG
alias gpgl='gpg --list-secret-keys --keyid-format LONG'
alias gpgla='gpg2 --list-keys --keyid-format LONG'

# DOCKER

alias dswi='docker swarm init --advertise-addr 10.0.0.122 --listen-addr 0.0.0.0'

function docker_stk_dep () {
    docker stack deploy -c $1 $2
}
alias dstkd='docker_stk_dep'
alias dstk='docker stack ps'
alias dstkrm='docker stack rm func'

function docker_attach() {
    docker exec -i -t $1 /bin/$2
}
alias da='docker_attach'
alias dsl='docker service logs'
alias ds='docker service ls'
alias dcl='docker container ls'
alias drms='docker service rm `docker service ls -q`'
alias di='docker images'

alias de='env|grep DOCKER'

function docker_set_env() {
    eval "$(docker-machine env $1)"
}
alias dse='docker_set_env'

function docker_unset_env() {
    unset DOCKER_TLS_VERIFY
    unset DOCKER_CERT_PATH
    unset DOCKER_MACHINE_NAME
    unset DOCKER_HOST
}
alias due='docker_unset_env'

alias dclean='docker rm $(docker ps -q -f status=exited)'

# GIT

export GIT_EDITOR='vim'

function git_clone() {
    git clone https://github.com/$1
}
alias gcc='git_clone'
alias gbl='git branch -l'
alias gcnb='git checkout -b'
alias gs='git status'
alias gsh='git show'
alias gl='git log'

function git_log_deleted () {
    git log --all --full-history -- $1
}
alias gld='git_log_deleted'

alias gd='git diff'
alias gc='git checkout'
alias ga='git add'
alias gpu='git pull'
alias gpum='git pull upstream master'
function git_remote_add_upstream () {
    git remote add upstream https://github.com/$1.git
}
alias grau='git_remote_add_upstream'
alias gcl='git clean -i'
alias gcld='git clean -d -f'
alias glf='git diff-tree --no-commit-id --name-status -r'
function git_create_repo () {
    curl -u 'ericstoekl' https://api.github.com/user/repos -d "{\"name\":\"$1\"}"
    git remote add origin git@github.com:ericstoekl/$1.git
    git push origin master
}
alias gcr='git_create_repo'
alias gcbn='git rev-parse --abbrev-ref HEAD'
alias gpo='git push --set-upstream origin `gcbn`'
alias gcm='git commit'

function git_clonetofork () {
    git remote rename origin upstream
    git remote add origin https://github.com/ericstoekl/$1
}
alias gclf='git_clonetofork'

alias gdc='git log --left-right --graph --cherry-pick --oneline origin/`gcbn`...origin/master'

# GO

alias gcd='cd /home/s/github/go/src/github.com'

export GOPATH=$HOME/github/go
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
export PATH="$PATH:/home/s/istio-0.5.0/bin"

# FAAS

alias faas='/usr/local/bin/faas-cli'
alias fcb='faas-cli build -f'
alias fcd='faas-cli deploy -f'
alias fc='faas-cli'
alias fcsa='docker ps -q | xargs docker stop '
alias fcs='docker ps -a --filter network=func_functions -q | xargs docker stop '
alias fcrm='docker ps -a --filter network=func_functions -q | xargs docker rm -f'
alias fcrma='docker ps -q | xargs docker rm -f'
alias fclrm='fc list | an 1 | xargs faas-cli remove'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


#STARTUP

#Request spot fleet:
function awsspot_func () {
    spotFleet=`aws ec2 request-spot-fleet --spot-fleet-request-config file://$1 | jq '.SpotFleetRequestId' | sed -e 's/^"//' -e 's/"$//'`
    sleep 20
    instanceIds=`aws ec2 describe-spot-fleet-instances --spot-fleet-request-id $spotFleet | jq '.ActiveInstances[0].InstanceId' | sed -e 's/^"//' -e 's/"$//'`
    aws ec2 describe-instances --instance-ids $instanceIds | jq '.[][0].Instances[0].PublicIpAddress'
}
alias awsspot='awsspot_func'

# KUBERNETES
alias kc='kubectl'
alias kgp='kc get pods'
alias kdp='kc describe pod'
alias kga='kubectl get all'
alias kgas='kga -n kube-system'
alias kgs='kc get svc'
alias kd='kubectl describe'
alias kgn='kubectl get ns'
alias kl='kubectl logs'

# OTHER

function redshiftkill () {
    pid=`ps aux | pgrep redshift`
    kill $pid
}
alias rsk='redshiftkill'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/s/.sdkman"
[[ -s "/home/s/.sdkman/bin/sdkman-init.sh" ]] && source "/home/s/.sdkman/bin/sdkman-init.sh"

function killvbox () {
    vboxmanage startvm $1 --type emergencystop
}
alias kvb='killvbox'
