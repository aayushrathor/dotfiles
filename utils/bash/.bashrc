#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1="[\[\033[32m\]\w]\[\033[0m\]<arch>\n</arch>\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"

#PS1='%F{green}%f%F{blue}%1~%f%F{green}%f$vcs_info_msg_0_ %F{magenta} %f '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#auto startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# set vim mode in cli
set -o vi

eval "$(zoxide init bash)"

source ~/.scripts/scripts/pacman.sh 

### Useful aliases ###
#find packages installed
alias packs="pacman -Qq | fzf --preview 'pacman -Qi {}' --cycle --color=dark" 

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
alias kube='kubectl'
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
alias cd='z'
alias dc='z'
alias pdf='zathura'
alias dot='cd ~/.config && nvim'
alias mpv="devour mpv"
alias aayush="cd ~/"
alias sleep="systemctl suspend"
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot now"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
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
