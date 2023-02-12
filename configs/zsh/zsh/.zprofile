# .zprofile

# paths
export PATH="$HOME/.local/bin:$PATH"
if [ -d "$HOME/.local/lib" ]; then
  export PATH=$HOME/.local/lib:$PATH
fi

# shell
export SHELL=/usr/bin/zsh
export XTERM_SHELL=/usr/bin/zsh

# language
export LC_MESSAGES=en_US.UTF-8
export LANGUAGE=en_US
export LANG=en_US.UTF-8

# editor x terminal
export EDITOR=nvim
export TERM=xterm-256color

# tesseract
export TESSDATA_PREFIX="$HOME/.config/tesseract/tessdata/"

# pager
export LS_COLORS="di=0;36"
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# node version manager - nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# fzf and fd
export FZF_DEFAULT_OPTS=" -1 -i 
--prompt '⯈ ' 
--marker=+ 
--cycle
--keep-right  
--reverse 
--height 100%
--color=fg:250,fg+:15,hl:203,hl+:203  
--bind 'btab:toggle-up,tab:toggle-down'
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

# zoxide
eval "$(zoxide init zsh)"

# utils
export KEYTIMEOUT=1
export PROMPT_EOL_MARK=''
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # make prompt faster
export DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster
