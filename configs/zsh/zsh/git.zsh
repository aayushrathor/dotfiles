# functons for git zsh 

# function git-svn(){
#   if [[ ! -z "$1" && ! -z "$2" ]]; then
#           echo "Starting clone/copy ..."
#           repo=$(echo $1 | sed 's/\/$\|.git$//')
#           svn export "$repo/trunk/$2"
#   else
#           echo "Use: git-svn <repository> <subdirectory>"
#   fi  
# }

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

# Reset the head to a previous commit (defaults to direct parent):
function git_reset_head() {
  git reset HEAD~$2 $1
  # Failure case:
  if [[ $? != 0 ]]; then
    echo -n 'HEAD remains at '
    git log -1 --oneline | cat
    return 1
  # Success case:
  elif [[ $1 != '--hard' ]]; then
    echo -n 'HEAD is now at '
    git log -1 --oneline | cat
  fi
}

# Print short status and log of latest commits:
# function git_status_short() {
#   if [[ -z $(git status -s) ]]; then
#     echo 'Nothing to commit, working tree clean\n'
#   else
#     git status -s && echo ''
#   fi
#   git log -${1:-3} --oneline | cat
# }

# View the full change history of a single file:
function git_log_file() {
  if [[ -z $1 ]]; then
    echo "Usage:    git_log_file <file> [<from line>] [<to line>]"
    return 1
  elif [[ -z $2 ]]; then
    glog -p -- $1
    return 0
  elif [[ $2 == *,* ]]; then
    3=${2#*,}
    2=${2%,*}
  elif [[ -z $3 ]]; then
    3=$2
  fi
  glog -L $2,$3:$1
}

# git blame that optionally takes line numbers:
# Usage: git_blame_line <file> [<from line>] [<to line>]
# function git_blame_line() {
#   if [[ -z $1 ]]; then
#     echo "Usage:    git_blame_line <file> [<from line>] [<to line>]"
#     return 1
#   elif [[ -z $2 ]]; then
#     2=1   # Set 'from' line number to first line
#   elif [[ $2 == *,* ]]; then
#     3=${2#*,}
#     2=${2%,*}
#   elif [[ -z $3 ]]; then
#     3=$2
#   fi
#   git blame $1 -L $2,$3
# }

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
# ft() {
#   local out q k sha
#   while out=$(
#     git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
#     fzf --ansi --no-sort --query="$q" --print-query \
#         --expect=ctrl-d,ctrl-b);
#   do
#     mapfile -t out <<< "$out"
#     q="${out[0]}"
#     k="${out[1]}"
#     sha="${out[-1]}"
#     sha="${sha%% *}"
#     [[ -z "$sha" ]] && continue
#     if [[ "$k" == 'ctrl-d' ]]; then
#       git diff $sha
#     elif [[ "$k" == 'ctrl-b' ]]; then
#       git stash branch "stash-$sha" $sha
#       break;
#     else
#       git stash show -p $sha
#     fi
#   done
# }

# search local branches -> checkout to branch & delete branch you were on
# gbb() {
#   local branches branch
#   branches=$(git branch -vv) &&
#   branch=$(echo "$branches" | fzf +m) &&
#   git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
#   # delete previous branch I was on
#   git branch -D @{-1}
# }

# git checkout branch (searches local branches). ge <branch> = checkout branch
ge() {
  if [ $# -eq 0 ]; then
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  else
    git checkout "$@"
  fi
}

# Commit all changes with <commit-msg>. gw <commit-msg>
# gw() {
#     git add .
#     git commit -m "${(j: :)@}"
#     # TODO: check if there is configured push destination. If not, don't push.
#     # TODO: change other functions there to do the same
#     git push
# }

# Commit all changes with `add <commit-msg>`. gwa <commit-msg>
# gwa(){
#   git add .
#   git commit -m "add $*"
#   git push
# }

# Commit all changes with `<fix commit-msg>`. gwf <commit-msg>
# gwf(){
#   git add .
#   git commit -m "fix $*"
#   git push
# }
#
# # Commit all changes with `<remove commit-msg>`. gwr <commit-msg>
# gwr(){
#   git add .
#   git commit -m "remove $*"
#   git push
# }
#
# # Commit all changes with `improve <msg>`. gwi <msg>
# gwi() {
#     git add .
#     git commit -m "improve $*"
#     git push
# }
#
# # Commit all changes with `update <msg>`. gwe <msg>
# gwu() {
#     git add .
#     git commit -m "update $*"
#     git push
# }
#
# # Commit all changes with `refactor`
# gwe() {
#     git add .
#     git commit -m 'refactor'
#     git push
# }
#
# # git remote add origin of link found in clipboard
# gao() {
#     git remote add origin "$(pbpaste)"
# }

# git clone and cd instantly to cloned repo. gcd <git-url>
gcd() {
  git_url="$(wl-paste)"
  reponame=$(echo "$git_url" | sed 's/\.git$//' | sed 's/.*\///')
  git clone "$git_url" && cd "$reponame"
}
