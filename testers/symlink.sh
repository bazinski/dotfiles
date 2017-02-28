# !/bin/bash/

# symbolic links

# files with $HOME destination
FILES="zshrc tmux.conf vimrc dircolors"

rm -f ~/.vimrc
rm -f ~/.zshrc
rm -f ~/.config/lxterminal/lxterminal.conf
rm -f ~/.tmux.conf
rm -f ~/.oh-my-zsh/themes/bazinski.zsh-theme
rm -f ~/.vim/template.cpp

for ifs in `echo $FILES`; do
	SP="$(pwd)/$ifs"
	SH="$HOME/.$ifs"
done


