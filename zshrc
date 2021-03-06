# Exports# {{{

export GITHUB_USER="bazinski"
export PATH="$PATH:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/gems/bin:$HOME/.rvm/bin:$HOME/.local/bin:$HOME/.local/vim/bin" # Add RVM to PATH for scripting
export MANPAGER="less -X" # sceen is not cleared after quitting the man page
export EDITOR="vim"
export VISUAL="vim"

# OpenSceneGraph variables for installation
export OPENTHREADS_INC_DIR="/usr/local/include"
export OPENTHREADS_LIB_DIR="/usr/local/lib64:/usr/local/lib"
export PATH="$OPENTHREADS_LIB_DIR:$PATH"
export LD_LIBRARY_PATH="$HOME/lib:/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH"
#export OSG_FILE_PATH="/usr/local/OpenSceneGraph/data:/usr/local/OpenSceneGraph/data/Images"

#for ALICE 
export OCDB_PATH=/cvmfs/alice-ocdb.cern.ch

# Qt5
#export QT5PREFIX=/opt/Qt/5.5/gcc_64

#not sure why i need this here, it should work with out it.
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# allow terminal to support 256 color schemes
if [[ $TERM == xterm ]]; then
    export TERM="xterm-256color"
fi

export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

## }}}

# Alias # {{{

alias vi="vim"
alias tmux="tmux -2" # 256 colors mode
alias tmuxkillall="tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}" # tmux kill all sessions
alias weather="curl wttr.in/"
alias ad="cd /home/bazinski/alicedata/"
alias btc="curl rate.sx"
#alias ct="ctags -R --exclude=.git --exclude=node_modules"
## }}}
# Environment variables # {{{
dots="$HOME/github/dotfiles"
insitu="$HOME/github/chpcgrid"
## }}}

# Other # {{{
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# spelling corrector
setopt CORRECT

# auto-correction
ENABLE_CORRECTION="true"

# display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# enable dircolors for ls and such
eval `dircolors ~/.dircolors`
## }}}
# Install ruby gems to ~/gems
export GEM_HOME="$HOME/gems"


