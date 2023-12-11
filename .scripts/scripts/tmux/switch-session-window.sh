#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function main {
  local sessions
  local session
  local query
  local sess_arr
  local retval
  sessions=$(tmux list-windows -a | 
    fzf --exit-0 --print-query --reverse)
  retval=$?

  IFS=$'\n' read -rd '' -a sess_arr <<<"$sessions"

  session=$(echo ${sess_arr[1]} | sed 's/: .*//g')
  query=${sess_arr[0]}

  if [ $retval == 0 ]; then
    if [ "$session" == "" ]; then
        session=$(echo "$query" | sed 's/: .*//g')
    fi
    tmux switch-client -t "$session"
  elif [ $retval == 1 ]; then
    tmux command-prompt -b -p "Press enter to create and go to [$query] session" \
      "run '$CURRENT_DIR/make_new_session.sh \"$query\" \"%1\"'"
  fi
}
main
