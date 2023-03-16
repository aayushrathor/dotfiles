# functions zsh

# Show $PATH
path(){
  echo -e ${PATH//:/\\n}
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

function _smooth_fzf() {
  local fname
  local current_dir="$PWD"
  cd "${XDG_CONFIG_HOME:-~/.config}"
  fname="$(fzf)" || return
  $EDITOR "$fname"
  cd "$current_dir"
}

function toppy() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n 21
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

findEmptyDirsAndFiles(){
  find . -type f -exec bash -c 'if [ `cat "{}" |wc -w` -eq 0 ]; then echo "file - {}";fi' \; -or -empty -exec bash -c "echo dir - {}" \;
}

# Get cheat sheet of command from cheat.sh. h <cmd>
cheat() {
    curl cheat.sh/${@:-cheat}
    # curl cheat.sh/$@
}

# exec into docker
ssh-docker() {
    docker exec -it "$@" bash
}

# remove old and unused images
docker-cleanup() {
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

#USAGE: mdrender README.md
mdrender() {
    HTMLFILE="$(mktemp -u).html"
        jq --slurp --raw-input '{"text": "\(.)", "mode": "markdown"}' "$1" |
        curl -s --data @- https://api.github.com/markdown >"$HTMLFILE"
    echo Opening "$HTMLFILE"
    open "$HTMLFILE"
}

convertAllMDFilesToTabs() {
  find . -name '*.md' ! -type d -exec sh -c 'expand -t 4 "$1" > "${1%.md}.tmp" && mv "${1%.md}.tmp" "$1"' _ {} \;
}

# Search aliases/functions
falias() {
    CMD=$(
        (
            (alias)
            (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_" )
        ) | fzf | cut -d '=' -f1
    );

    eval $CMD
}

# Lowercase every file in current dir
lowercaseCurrentDir(){
  for i in *; do mv $i ${(L)i}; done
}

# zs - Search for most visited directories from z index and open them in finder.
zs() {
  z $1 && open .
}

# Serves the current directory over HTTP, on an optionally-specified port
# If on Mac OS X, opens in the default browser
server() {
  port=$1
  if [ $# -ne  1 ]; then
    port=8000
  fi
  python3 -m http.server $port
}

# compress <file/dir> - Compress <file/dir>.
compress()
  {
    dirPriorToExe=`pwd`
    dirName=`dirname $1`
    baseName=`basename $1`

    if [ -f $1 ] ; then
      echo "It was a file change directory to $dirName"
      cd $dirName
      case $2 in
        tar.bz2)
          tar cjf $baseName.tar.bz2 $baseName
          ;;
        tar.gz)
          tar czf $baseName.tar.gz $baseName
          ;;
        gz)
          gzip $baseName
          ;;
        tar)
          tar -cvvf $baseName.tar $baseName
          ;;
        zip)
          zip -r $baseName.zip $baseName
          ;;
        *)
          echo "Method not passed compressing using tar.bz2"
          tar cjf $baseName.tar.bz2 $baseName
          ;;
      esac
      echo "Back to Directory $dirPriorToExe"
      cd $dirPriorToExe
    else
      if [ -d $1 ] ; then
        echo "It was a Directory change directory to $dirName"
        cd $dirName
        case $2 in
          tar.bz2)
            tar cjf $baseName.tar.bz2 $baseName
            ;;
          tar.gz)
            tar czf $baseName.tar.gz $baseName
            ;;
          gz)
            gzip -r $baseName
            ;;
          tar)
            tar -cvvf $baseName.tar $baseName
            ;;
          zip)
            zip -r $baseName.zip $baseName
            ;;
          *)
            echo "Method not passed compressing using tar.bz2"
            tar cjf $baseName.tar.bz2 $baseName
            ;;
        esac
        echo "Back to Directory $dirPriorToExe"
        cd $dirPriorToExe
      else
        echo "'$1' is not a valid file/folder"
      fi
    fi
    echo "Done"
    echo "###########################################"
  }

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  SELECTED_FILES="$(rg --hidden --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW -m --preview "rg --ignore-case --pretty --context 10 '$1' {}")"
  if [ -n "$SELECTED_FILES" ]; then
    nvim $(echo $SELECTED_FILES)
  fi
}

function monitor() {
  watch -n1 -t "lsof -i -n|awk '{print \$1, \$2, \$9}'|column -t";
}

# ram <process-name> - Find how much RAM a process is taking.
ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

# activate python virtual env
penv () {
  [ ! -d "venv/" ] && python3 -m venv venv
  source venv/bin/activate
}

pyclean () {
  # Cleans py[cod] and __pychache__ dirs in the current tree:
  find . | grep -E "(__pycache__|\.py[cod]$)" | xargs rm -rf
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	# shellcheck disable=SC2199
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg -- .[^.]* *
	fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
	tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Get colors in manual pages
man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}

# Colour/Color echo prompt outputs
#USAGE: cecho @b@green[[Success]]
cecho() (
  echo "$@" | sed \
    -e "s/\(\(@\(red\|green\|yellow\|blue\|magenta\|cyan\|white\|reset\|b\|u\)\)\+\)[[]\{2\}\(.*\)[]]\{2\}/\1\4@reset/g" \
    -e "s/@red/$(tput setaf 1)/g" \
    -e "s/@green/$(tput setaf 2)/g" \
    -e "s/@yellow/$(tput setaf 3)/g" \
    -e "s/@blue/$(tput setaf 4)/g" \
    -e "s/@magenta/$(tput setaf 5)/g" \
    -e "s/@cyan/$(tput setaf 6)/g" \
    -e "s/@white/$(tput setaf 7)/g" \
    -e "s/@reset/$(tput sgr0)/g" \
    -e "s/@b/$(tput bold)/g" \
    -e "s/@u/$(tput sgr 0 1)/g"
)

# Found at <http://www.askapache.com/linux/zen-terminal-escape-codes.html#3rd_Dimension_Broken_Bash>
colortest() {
  x=`tput op` y=`printf %$((${COLUMNS}-6))s`
  for i in {0..256}
  do
    o=00$i
    echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x
  done
}

function _sudo_command_line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # If $SUDO_EDITOR or $VISUAL are defined, then use that as $EDITOR
    # Else use the default $EDITOR
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}

    # If $EDITOR is not set, just toggle the sudo prefix on and off
    if [[ -z "$EDITOR" ]]; then
      case "$BUFFER" in
        sudo\ -e\ *) _sudo_replace_buffer "sudo -e" "" ;;
        sudo\ *) _sudo_replace_buffer "sudo" "" ;;
        *) LBUFFER="sudo $LBUFFER" ;;
      esac
      return
    fi

    # Check if the typed command is really an alias to $EDITOR

    # Get the first part of the typed command
    local cmd="${${(Az)BUFFER}[1]}"
    # Get the first part of the alias of the same name as $cmd, or $cmd if no alias matches
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"

    # Note: ${var:c} makes a $PATH search and expands $var to the full path
    # The if condition is met when:
    # - $realcmd is '$EDITOR'
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "cmd --with --arguments"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "cmd"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is /alternative/path/to/cmd that appears in $PATH
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
      _sudo_replace_buffer "$cmd" "sudo -e"
      return
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
      $editorcmd\ *) _sudo_replace_buffer "$editorcmd" "sudo -e" ;;
      \$EDITOR\ *) _sudo_replace_buffer '$EDITOR' "sudo -e" ;;
      sudo\ -e\ *) _sudo_replace_buffer "sudo -e" "$EDITOR" ;;
      sudo\ *) _sudo_replace_buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle redisplay
  }
}

# vim:ft=sh
