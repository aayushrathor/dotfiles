# functions zsh

# git log
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

# extract tool - replaced with atool
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

# check between all installed packages
packs() {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

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

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
