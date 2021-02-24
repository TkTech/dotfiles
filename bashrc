# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Shut up the warning about zsh being the new default shell on OS X.
export BASH_SILENCE_DEPRECATION_WARNING=1

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will match
# all files and zero or more directories and subdirectories.
# Bash > 4.1.0 only.
if shopt | grep globstar 2>/dev/null; then
    shopt -s globstar
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Use vim as our preferred editor.
if [ -x "$(command -v vim)" ]; then
    export VISUAL=vim
    export EDITOR="$VISUAL"
fi

# Use starship for our prompt.
if [ -x "$(command -v starship)" ]; then
    function set_win_title(){
        echo -ne "\033]0; $(basename $PWD) \007"
    }

    starship_precmd_user_func="set_win_title"
    eval "$(starship init bash)"
fi

# Include Cargo in the path if it's present.
[ -x $HOME/.cargo/env ] && source $HOME/.cargo/env

# Setup rbenv if it's present
if [ -f $HOME/.rbenv/bin/rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
