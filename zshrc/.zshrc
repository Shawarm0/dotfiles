# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
WPATH="/mnt/c/Users/ryand/OneDrive/Desktop/"

# --- WSL ---
# for moving from and to windows.
alias windows="cd $WPATH"
mvw() {
  mv "$1" $WPATH
}

# These are my aliases
alias zshconfig="nvim ~/.zshrc"
alias home="cd ~/"
alias nconfig="cd ~/.config/nvim && nvim init.lua"
alias python="python3"
alias reload="source ~/.zshrc"
alias myip='curl ipinfo.io/ip'

gitl() {
    if [ -d .git ]; then 
        git log --oneline --graph --decorate --all
    else 
        echo "Git repository not found."
    fi
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1" ;;
            *.tar.gz)    tar xvzf "$1" ;;
            *.tar.xz)    tar xvJf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.zip)       unzip "$1" ;;
            *.7z)        7z x "$1" ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}


mkcd() {
    mkdir -p "$1" && cd "$1"
}


search() {
  for term in "$@"; do 
    echo "\n\n\n\n"
    echo "Searching for: $term\n"
    grep -rnw '.' -e "$term"
  done
}




setcwd() {
  cwd=$(realpath --relative-to=$HOME "$PWD")
  echo "cwd set to: $cwd"
  echo "$cwd" > ~/.cwd  # Save the relative path to a file
}

cwd() {
  if [ ! -f ~/.cwd ]; then
    echo "No cwd set. Use 'setcwd' first."
    return 1
  fi
  cwd=$(cat ~/.cwd)
  cd "$HOME/$cwd" || { echo "Failed to change directory"; return 1; }
}



venv() {
  local env_name=${1:-.venv}
  python3 -m venv $env_name
  source $env_name/bin/activate
}

deps() {
  if [ -f requirements.txt ]; then
    echo "📦 Installing dependencies from requirements.txt...\n"
    pip install -r requirements.txt
    echo "\n\e[32mDependencies have been sucessfully installed!! \e[0m"
  else
    echo "\e[31mrequirements.txt not found. Creating one for you!\e[0m"
    touch requirements.txt
    echo "\e[33mPlease add your dependencies to the requirements.txt file.\e[0m"

      if [ -d .git ]; then
    echo -n "\n\n\e[36mThis is a Git repository. Do you want to add and commit requirements.txt? (y/n): \e[0m"
    read choice
    case "$choice" in
      y|Y )
        git add requirements.txt
        git commit -m "Added requirements.txt"
        echo "\n\e[32mrequirements.txt has been committed.\e[0m"
        ;;
      n|N )
        echo "\e[33mSkipping Git add and commit."
        ;;
      * )
        echo "\e[31mInvalid input. \e[33mSkipping Git add and commit."
        ;;
    esac
  fi



  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
