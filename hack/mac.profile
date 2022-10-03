# GPG
export GPG_TTY=$TTY

### GO stuff
### NB: not really necessary with go modules
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export GO111MODULE="on"

#### Android Stuff 
# export FLUTTERPATH=$HOME/flutter/bin
# export PATH=$PATH:$FLUTTERPATH
# /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
export JAVA_HOME=/usr/local/opt/openjdk@11

# PATH STUFF
export PATH="$PATH:/usr/local/opt/ruby/bin:/usr/local/opt/ncurses/bin"
export ANDROID_HOME=$HOME/Library/Developer/Xamarin/android-sdk-macosx
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/29.0.3:$PATH

# FLAGS
# export LDFLAGS="-L/usr/local/opt/ncurses/lib"
# export CPPFLAGS="-I/usr/local/opt/ncurses/include"

# export LDFLAGS="-L/usr/local/opt/ruby/lib"
# export CPPFLAGS="-I/usr/local/opt/ruby/include"


### ZSH stuff
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="bira"
# # Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time oh-my-zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### EDITOR STUFF ### 
export EDITOR=/usr/local/bin/code

### NEEDLESS ######
export NPM_TOKEN=replace_me
export CI_JOB_TOKEN=greplace_me
export GITLAB_API_TOKEN=replace_me
export GITLAB_REPO=replace_me
export GH_PAT=replace_me

# MAVEN Gitlab
export MAVEN_REPO_URL="https://gitlab.com/api/v4/projects/22027394/packages/maven"
export MAVEN_TOKEN_TYPE="Private-Token"
export MAVEN_TOKEN_VALUE=$GITLAB_API_TOKEN

# complete -C /terraform/vault vault
export GITLAB_RUNNER_TOKEN=GR1348941vxFZy9JtfKuF76Cxc9sL

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Podman DOCKER_HOST
export DOCKER_HOST='unix://$HOME/.local/share/containers/podman/machine/podman-machine-default/podman.sock'

# Aliases
# alias aws="docker run --rm -it --env-file ~/git/iag/group-idam/local.env -e AWS_PAGER="" -v ~/.aws:/root/.aws -v ~/.kube:/root/.kube -v $(pwd):/data amazon/aws-cli"
alias aws-cli="docker run --rm -it --entrypoint /usr/bin/env --env-file ~/git/iag/group-idam/local.env -v ~/.aws:/root/.aws -v ~/.kube:/root/.kube -v $(pwd):/data amazon/aws-cli -- sh"
# alias terraform="docker run --rm -v $PWD:/out -v ~/.aws:/root/.aws hashicorp/terraform:1.0.9"
alias terraform-cli="docker run -it --rm --entrypoint /usr/bin/env -v $PWD:/out -v ~/.aws:/root/.aws hashicorp/terraform:1.2.9 -- sh"
alias terraform12-cli="docker run -it --rm --entrypoint /usr/bin/env -v $(pwd):/out -v ~/.aws:/root/.aws hashicorp/terraform:0.12.28 -- sh"
alias k="kubectl"
alias docker="podman"
alias akamai="docker run -it -v $HOME/.edgerc:/root/.edgerc:ro akamai/shell"
alias ccdns="sudo dscacheutil -flushcache &&  sudo killall -HUP mDNSResponder"
### TF aliases

# K8s aliases
alias k1="kubectl"
alias k1d="kubectl describe"

### misc
alias reload="exec zsh -l"
alias web2ldap="docker run -d -p 1760:1760 dnitsch/web2ldap:latest"
# alias web2ldap="/opt/web2ldap/bin/web2ldap 127.0.0.1 1760"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# RUN THIS on STARTUP
# artii "$(whoami)" | lolcat && fortune | cowsay -f vader | lolcat
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
