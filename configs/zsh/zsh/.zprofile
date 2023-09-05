#.zprofile

# paths
export PATH="$HOME/.local/bin:$PATH"
if [ -d "$HOME/.local/lib" ]; then
  export PATH=$HOME/.local/lib:$PATH
fi
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export GPG_TTY="${TTY:-$(tty)}"

#go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# shell
export SHELL=/usr/bin/zsh
export XTERM_SHELL=/usr/bin/zsh

# language
export LC_MESSAGES=en_US.UTF-8
export LANGUAGE=en_US
export LANG=en_US.UTF-8

# editor x terminal
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-kitty # xterm-256color
export SUDO_PROMPT="Password  :"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_VIDEOS_DIR="$HOME/videos"

# tesseract
export TESSDATA_PREFIX="$HOME/.config/tesseract/tessdata/"

## Comment this to use normal manpager
export MANPAGER='nvim +Man! +"set nocul" +"set noshowcmd" +"set noruler" +"set noshowmode" +"set laststatus=0" +"set showtabline=0" +"set nonumber"'

if [ $(echo $MANPAGER | awk '{print $1}') = nvim ]; then
  export LESS="--RAW-CONTROL-CHARS"
  export MANPAGER="less -s -M +Gg"

  export LESS_TERMCAP_mb=$'\e[1;32m'
  export LESS_TERMCAP_md=$'\e[1;32m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[01;33m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[1;4;31m'
fi

export LS_COLORS="di=0;36"

# node version manager - nvm
export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# fzf and fd
export FZF_DEFAULT_OPTS=" -1 -i 
--prompt '⯈ ' 
--marker=+ 
--cycle
--keep-right  
--reverse 
--height=100%
--info='inline'
--bind 'btab:toggle-up,tab:toggle-down'
--bind 'ctrl-a:select-all'
--bind='?:toggle-preview'
--bind='ctrl-u:preview-page-up'
--bind='ctrl-d:preview-page-down'
--preview-window 'right:60%:wrap'
"
export FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules --exclude .npm"
export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS || git ls-files --cached --others --exclude-standard"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS "
export FZF_CTRL_T_OPTS="--ansi  --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' "
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
export FZF_COMPLETION_OPTS="-x"

# utils
export KEYTIMEOUT=1
export PROMPT_EOL_MARK=''
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # make prompt faster
export DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster

# hyprland
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
