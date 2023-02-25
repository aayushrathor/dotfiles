# alias zsh

# ls - exa
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

# docker x k8s
#alias docker='podman'
alias docker-compose='docker compose'
alias k='kubectl'
alias dip='docker image prune'
alias mstart='minikube start'
alias mstat='minikube status'

# git
alias gadd='git add .'
alias gct='git commit -m'
alias gst='git status'
alias gpl='git pull'
alias gps='git push origin --force'
alias grb='git rebase'
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gdiff='git diff --name-only --diff-filter=d | xargs bat --diff'

# utils
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias s='startx'
alias npm='pnpm'
alias cat='bat -Pp'
alias cd='z'
alias dc='z'
alias pdf='zathura'
alias dot='cd ~/.config && nvim'
alias minecraft='java -jar ~/Desktop/minecraft/TLauncher-2.876.jar'
alias mpv="devour mpv"
alias aayush="cd ~/"
alias sleep="systemctl suspend"
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot now"
alias aup="paru -Syyu"
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

# exractor
alias ex='atool --explain --extract'

# get fastest mirrors 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose" 
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay" 
alias mirrors="sudo reflector --latest 50 --number 20 --sort score" 
alias mirrora="sudo reflector --latest 50 --number 20 --sort age" 

# set your countries like --country France --country Germany -- or more.
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && sudo updatedb'

# package manager
alias yay="paru"
alias yayup='sudo pacman -Sy && paru -Su'
alias cleanup='yay -Rns $(yay -Qtdq)'