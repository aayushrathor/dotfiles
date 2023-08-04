##
## Keybindings
##

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
# bindkey -s '^K' 'ls^M'
# bindkey -s '^O' '_smooth_fzf^M'

# prepend sudo on the current commmand
bindkey -M vicmd '' _sudo_command_line
bindkey -M viins '' _sudo_command_line

# fix backspace and other stuff in vi-mode
bindkey -M viins '\e/' _vi_search_fix
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line

# set completion-map-case on
# set editing-mode vi
# set show-mode-in-prompt on
# set vi-cmd-mode-string " \1\e[1;31m\2⣿\1\e[0m\2 "
# set vi-ins-mode-string " \1\e[1;33m\2⟫\1\e[0m\2 "
#
# set colored-stats on
# set visible-stats on
# set page-completions off
# set enable-bracketed-paste

# vim:ft=zsh:nowrap
