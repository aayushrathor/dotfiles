# _________  _   _
#|__  / ___|| | | |
#  / /\___ \| |_| |
# / /_ ___) |  _  |
#/____|____/|_| |_|
#
export PATH="$HOME/.local/bin:$PATH"
export LC_MESSAGES=en_US.UTF-8
export LANGUAGE=en_US
export LANG=en_US.UTF-8
export EDITOR=nvim
export TERM=xterm-256color
export TESSDATA_PREFIX="$HOME/.config/tesseract/tessdata/"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

### zoxide ###
eval "$(zoxide init zsh)"

## set vim mode ##
set -o vi

if [ -d "$HOME/.local/lib" ]; then
  export PATH=$HOME/.local/lib:$PATH
fi

# starship
eval "$(starship init zsh)"
function set_win_title(){
  echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
}
precmd_functions+=(set_win_title)

# Use profiles
#source ~/.profile

## Options section
unsetopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Completion.
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
#
# zstyle ':completion:*:descriptions' format '%U[%d]%u'
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

#fzf-tab
[ -f ~/zsh/fzf-tab.plugin.zsh ] && source $HOME/zsh/fzf-tab.plugin.zsh

# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000

#find packages installed
alias packs="pacman -Qq | fzf --preview 'pacman -Qi {}' --cycle" 

### Useful aliases ###
# Replace ls with exa
export LS_COLORS="di=0;36"
alias ls='exa -a --icons --color=always --group-directories-first' # preferred listing
alias sl='exa -a --icons --color=always --group-directories-first'
alias la='exa -a --icons --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.="exa -a | egrep '^\.'"
alias la='(exa -ahl --color=always --group-directories-first) | bat ' # my preferred listing
alias lr='(exa -aR --color=always --group-directories-first) |bat '  # all files and dirs
alias l='(exa -a --color=always --group-directories-first) |bat '  # all files and dirs
alias ld='(exa -l --color=always --group-directories-first) | bat'  # long format

# Docker & Kube
#alias docker='podman'
alias docker-compose='docker compose'
alias k='kubectl'
alias dip='docker image prune'
alias mstart='minikube start'
alias mstat='minikube status'

# Git
alias gadd='git add .'
alias gct='git commit -m'
alias gst='git status'
alias gpl='git pull'
alias gps='git push origin --force'
alias grb='git rebase'
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gdiff='git diff --name-only --diff-filter=d | xargs bat --diff'

# interactive git difference by https://github.com/rothgar/mastering-zsh
function gd() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
    | fzf --ansi --preview "echo {} \
    | grep -o '[a-f0-9]\{7\}' \
    | head -1 \
    | xargs -I % sh -c 'git show --color=always %'" \
    --bind "enter:execute:
      (grep -o '[a-f0-9]\{7\}' \
        | head -1 \
        | xargs -I % sh -c 'git show --color=always % \
        | less -R') << 'FZF-EOF'
              {}
              FZF-EOF"
            }

# Common use aliases
alias cat='bat -Pp'
alias cd='z'
alias dc='z'
alias pdf='zathura'
alias dot='cd ~/.config && nvim'
alias minecraft='java -jar ~/Documents/TLauncher-2.841.jar'
alias mpv="devour mpv"
alias course="dev && cd imp-docs"
alias leet="dev && cd DSA/leetcode"
alias dsprac="dev && cd DSA/DSA-self-prac"
alias aayush="cd ~/"
alias docs="devour sioyek"
alias dev="cd ~/Desktop/DEV && nvim"
alias sleep="systemctl suspend"
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot now"
alias aup="pamac upgrade --aur"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias devr='docs ~/Desktop/DEV/imp-docs/2.png'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cod='cd ~/Media/Linux/Buffer/coding && clear'
alias c='clear'
alias e='exit'
alias h='htop'
alias p='pfetch'
alias n='neofetch'
alias s='sensors'
alias b='btop'
alias t='tmux new-session \; send-keys 'cod' C-m \; splitw -hp 40 \; send-keys 'cod' C-m'
alias rr='ranger'
alias cal='cal -3 -s'
# alias spr="command curl -fsLF 'sprunge=<-' http://sprunge.us"
alias P='sudo powertop'
alias cc='sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"'
alias bb='sudo sh -c "echo 2 > /proc/sys/vm/drop_caches"'
alias cb='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages
alias nv='nvim' 
alias sq='sudo mysql -u root'
alias wall='feh --bg-scale --no-fehbg --random'
alias code='devour code .'
alias sz='du -sh ./* | sort -h'
alias makecfile='echo "#include <stdio.h>\n#include <stdlib.h>\n\n\nint main(){\n}" >> '
alias makecppfile='echo "#include <stdio.h>\n#include <stdlib.h>\n#include <iostream>\n#include <bits/stdc++.h>\nusing namespace std;\nint main(){\nreturn 0;}" >> '

#alias for ventoy
alias vgui='sudo ventoygui'

# Functions
ushort(){
  curl -F 'shorten='$1'' https://0x0.st
}

ufile(){
  curl -F 'file=@'$1'' https://0x0.st
}

ushareg(){
  curl -F 'url='$1'' https://0x0.st
}

spr (){
  cat "$@" \
    | command curl -fsLF 'sprunge=<-' http://sprunge.us/ \
    | tr -d "\n" \
    | xclip -in -sel clip && \
    notify-send -t 900 -u low "Sprunge copied to clipboard!"
  }

  em (){
    devour emacsclient -cq $1
  }

  iso (){
    sudo dd bs=4M if=$1 of=/dev/$2 status=progress && sync
  }

# ex ()
# {
#   if [ -f $1 ] ; then
#     case $1 in
#       *.tar.bz2)   tar xjf $1   ;;
#       *.tar.gz)    tar xzf $1   ;;
#       *.bz2)       bunzip2 $1   ;;
#       *.rar)       unrar x $1   ;;
#       *.gz)        gunzip $1    ;;
#       *.tar)       tar xf $1    ;;
#       *.tbz2)      tar xjf $1   ;;
#       *.tgz)       tar xzf $1   ;;
#       *.zip)       unzip $1     ;;
#       *.Z)         uncompress $1;;
#       *.7z)        7z x $1      ;;
#       *.deb)       ar x $1      ;;
#       *.tar.xz)    tar xf $1    ;;
#       *.tar.zst)   unzstd $1    ;;
#       *)           echo "'$1' cannot be extracted via ex()" ;;
#     esac
#   else
#     echo "'$1' is not a valid file"
#   fi
# }

alias ex='atool --explain --extract'

# Get fastest mirrors 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose" 
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay" 
alias mirrors="sudo reflector --latest 50 --number 20 --sort score" 
alias mirrora="sudo reflector --latest 50 --number 20 --sort age" 

# Replace yay with paru if installed
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

alias yayup='sudo pacman -Sy && paru -Su'

# Set your countries like --country France --country Germany -- or more.
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && sudo updatedb'

alias cleanup='yay -Rns $(yay -Qtdq)'

# Then load url-quote-magic and bracketed-paste-magic as above
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Now the fix, setup these two hooks:
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic 
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# and finally, make sure zsh-autosuggestions does not interfere with it:
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# eval "$(ssh-agent -s)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:nohidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | copy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind 'ctrl-v:execute(code {+})'
"
### colored man page ###
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# interactive man search by https://github.com/rothgar/mastering-zsh
function  mans(){
  man -k . \
    | fzf -n1,2 --preview "echo {} \
    | cut -d' ' -f1 \
    | sed 's# (#.#' \
    | sed 's#)##' \
    | xargs -I% man %" --bind "enter:execute: \
    (echo {} \
    | cut -d' ' -f1 \
    | sed 's# (#.#' \
    | sed 's#)##' \
    | xargs -I% man % \
    | less -R)"
  }

# Search and install packages with yay and fzf
yi() {
  SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -S $(echo $SELECTED_PKGS)
  fi
}

# Search and remove packages with yay and fzf
yr() {
  SELECTED_PKGS="$(yay -Qsq | fzf --header='Remove packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -Rns $(echo $SELECTED_PKGS)
  fi
}

md () {
  command mkdir -p "$1" && cd "$1"
}

feval(){
  echo | fzf -q "$*" --preview-window=up:99% --preview="eval {q}"
}
