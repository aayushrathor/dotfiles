# .zshrc

START=$(date +%s.%N)


## zsh Performance
# zmodload zsh/zprof
# zprof

# Use profiles
source ~/zsh/.zprofile

# load/source zsh files
for file in ~/zsh/*.zsh; do
  source "$file"
done

# pip_fzf
source ~/scripts/pip_fzf

# set vi mode
set -o vi

# zxoide
eval "$(zoxide init zsh)"

# shell prompts - starship
eval "$(starship init zsh)"

# history zsh
HISTFILE=~/zsh/.zhistory
HISTSIZE=50000
SAVEHIST=10000

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

# eval "$(ssh-agent -s)"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec Hyprland
fi

# Performance Warning
END=$(date +%s.%N)
ZSHRC_PERF=$(printf %.2f $(echo "$END - $START" | bc))
if (( $ZSHRC_PERF > 0.14)); then
  echo "\033[0;31mperformance warning!"
  echo ".zshrc startup time" $ZSHRC_PERF "seconds\e[0m"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

