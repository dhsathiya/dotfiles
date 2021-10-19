# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="/home/devarshi/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/home/devarshi/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="gnzh"
ZSH_THEME="super-minimal"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# No duplicates in zsh history
HISTSIZE=10000000
SAVEHIST=10000000

setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

#setopt BANG_HIST                 # Treat the '!' character specially during expansion.
#setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
#setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
#setopt SHARE_HISTORY             # Share history between all sessions.
#setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
#setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
#setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
#setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
#setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
#setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
#setopt HIST_BEEP                 # Beep when accessing nonexistent history.



# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
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
#DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Language Paths 
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

[[ -f ~/.kubectl_aliases ]] && source ~/.kubectl_aliases

function get_namespace_from_repo() {
    [[ -z "$1" ]] && STRING="$GITHUB_REPOSITORY" || STRING="$1"
    strip_rtcamp_prefix=${STRING##*rtCamp/}
    strip_rtcamp_prefix=${strip_rtcamp_prefix##*rtcamp/}
    replace_slash_with_hyphen=${strip_rtcamp_prefix//\//\-}
    replace_dot_with_hyphen=${replace_slash_with_hyphen//./-}
    lower_case=$(echo "$replace_dot_with_hyphen" | tr '[:upper:]' '[:lower:]')
    strip_numbers_at_end=$(echo "$lower_case" | sed -e 's/\([0-9]\)*$//g')
    strip_hyphen_at_end=$(echo "$strip_numbers_at_end" | sed -e 's/\(-\)*$//g')
    echo "$strip_hyphen_at_end"
}

function get_pod_name() {
    NAMESPACE=$(get_namespace_from_repo)
    export DEPLOYMENT_NAME="$NAMESPACE-$DEFAULT_DEV_BRANCH"
    echo $(kubectl get pod -l app="$DEPLOYMENT_NAME" -o jsonpath="{.items[0].metadata.name}")
}

alias lssh="bash /home/devarshi/bin/lssh.sh"
alias tmuxdev="bash /home/devarshi/bin/tmuxdev.sh"
alias tmuxvpn="bash /home/devarshi/bin/tmuxvpn.sh"
alias curlx="curl -IL"
#alias pswd="</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c 15; echo ''"
alias hosts="sudo vim /etc/hosts"
alias resolv="sudo vim /etc/resolv.conf"
alias emcc="/root/WebAssembly/emsdk/upstream/emscripten/emcc"
alias notes="cd /media/devarshi/HDD/Workspace/dhsathiya/Notes"
alias ipi='f() { curl ipinfo.io/$1 };f'
alias umc="sudo vim /etc/umacro/umacro_conf.yml"
alias um="sudo umacro"
alias workspace="cd /media/devarshi/HDD/Workspace"
alias storm="/home/devarshi/Downloads/PhpStorm-211.7442.50/bin/phpstorm.sh"
alias p="python3"
alias rs="rsync -avzhP"
function mcam() {
    /home/devarshi/Downloads/droidcam/droidcam-cli -v 192.168.0.$1 4747
}

function cert() {
    curl --insecure -v https://$1 2>&1 | awk 'BEGIN { cert=0 } /^\* Server certificate:/ { cert=1 } /^\*/ { if (cert) print }'
}
#google-chrome https://github.com
function pswd() {
    #echo $@
    #</dev/urandom tr -dc '12345!@$%^&*qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c$@; echo ''
    #</dev/urandom tr -dc 'a-zA-Z0-9' | head -c$@; echo ''
    </dev/urandom tr -dc "[:graph:]" | head -c$@; echo ''
}

function pswds() {
    </dev/urandom tr -dc 'a-zA-Z0-9' | head -c$@; echo ''
}

function vmac() {
    case "$1" in 

    ls)
        ssh li5 "ls ~/vmac/"
        ;;
    up)
        ssh li5 "cd ~/vmac/$2 && vagrant up"
        ;;
    halt)
        ssh li5 "cd ~/vmac/$2 && vagrant halt"
        ;;
    status)
        ssh li5 "vagrant global-status | awk '!NF{exit}1'"
        ;;
    create)
        ssh li5 "mkdir ~/vmac/$2 && cd ~/vmac/$2 && wget https://raw.githubusercontent.com/dhsathiya/dotfiles/master/Vagrant/Vagrantfile"
        ;;
    ip)
        #ssh li5 "cd ~/vmac && grep -irn 'private_network'"
        #ssh li5 "cd ~/vmac && for vmac in $(ls); do echo -en $vmac; grep -I --color 'private_network' ./$vmac/Vagrantfile ; done"
        ssh li5 'cd ~/vmac; for vmac in $(ls); do echo -en $vmac; grep -I --color "private_network" ./$vmac/Vagrantfile; done' | awk '{print $1 "," $5}' | sed "s/\"//g" | column -t -s, 
        ;;
    ipsort)
        ssh li5 'cd ~/vmac; for vmac in $(ls); do echo -en $vmac; grep -I --color "private_network" ./$vmac/Vagrantfile; done' | awk '{print $1 "," $5}' | sed "s/\"//g" | column -t -s, | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n 
        ;;
    ipgen)
        bash /home/devarshi/bin/vmsshconfiggen.sh
    main-up)
        #wakeonlan -i 192.168.0.123 ac:12:wd:0b:sf:fd
        wakeonlan  ac:12:wd:0b:sf:fd
        ;;
    main-ssh)
        ssh li5
        ;;
    main-down)
        ssh li5 "shutdown -h now"
        ;;
    *)
        echo "Help"
        echo "ls"
        echo "up"
        echo "halt"
        echo "status"
        echo "create"
        echo "main-up"
        echo "main-ssh"
        echo "main-down"
        ;;
    esac
}

# Terminal Title
DISABLE_UNTRACKED_FILES_DIRTY="true"
#function nt() {
#    echo -n -e "\033]0;$@\007"
#}

#function ee() {
#    if [[ "$1" == "cd" ]]; then
#      case $2 in
#          app)
#              cd /opt/easyengine/sites/$2/app
#          ;;
#          logs)
#              cd /opt/easyengine/sites/$2/logs
#          ;;
#          config)
#              cd /opt/easyengine/sites/$2/config
#          ;;
#          *)
#              echo "Error: No such path"
#          ;;
#      esac
#    else
#      command sudo /mnt/sdb1/easyengine/easyengine/bin/ee "$@"
#    fi
#}

#fpath=(/media/devarshi/HDD/Workspace/dhsathiya/Notes/rtcamp/autocomplete $fpath)
#fpath=(/tmp $fpath)
#autoload -Uz compinit
#compinit
#compinit -d ~/.zcompdump_custom
#autoload bashcompinit
#bashcompinit


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/tmp/google-cloud-sdk/completion.zsh.inc'; fi
