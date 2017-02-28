# !/bin/bash/
# Check versions and if the packages are present
# Suggest to pull submodules
# Create all the necessary symbolic links

# general info
#printf "This script will install .configurations\n"
#printf "- vim\n"
#printf "- zsh\n"
#printf "- tmux\n"
#printf "- LXTerminal\n"
#printf "- dircolors (for commands such as ls)\n\n"

symlinker() {
# a function that performs a creation of symlinks
# input parameters:
# full_path_of_target full_path_of_link

ptarget=$1
plink=$2

printf "\nLink to be created: for file\n%s\n and with link to\n%s\n\n" $ptarget $plink

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    printf "Linux detedted\n"
    ln -sv $ptarget $plink
else
    printf "ERROR: current platform is not supported\n"
    exit 1
fi
}

# install Prezto

# clone the prezto repo
read -p "(Re-)Install Prezto? " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  if [ $? -ne 0 ]; then
    printf "ERROR: could not install prezto: is git installed? is there internet connection?\n"
    exit 1
  fi
fi

# remove previous config files, if any
read -p "Remove any previous config files? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    printf "Removing any existing config files...\n"
    rm -f ~/.vimrc
    rm -f ~/.zshrc
    rm -f ~/.config/lxterminal/lxterminal.conf
    rm -f ~/.tmux.conf
    rm -f ~/.zprezto/modules/prompt/functions/prompt_setup
    rm -f ~/.vim/template.cpp
    rm -f ~/.dircolors
    rm -f ~/.zlogin
    rm -f ~/.zlogout
    rm -f ~/.zpreztorc
    rm -f ~/.zprofile
    rm -f ~/.zshenv
    rm -f ~/.gitconfig
fi
printf "Done\n\n"

# create symbolic links
read -p "Overwrite symbolic links? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    printf "Creating symbolic links...\n"
    # dotfiles to copy to $HOME
    FILES="zshrc tmux.conf vimrc dircolors zpreztorc zprofile zshenv gitconfig"
    for ifs in `echo $FILES`; do
        symlinker "$(pwd)/$ifs" "$HOME/.$ifs"
    done
    symlinker "$(pwd)/lxterminal.conf" "$HOME/.config/lxterminal/lxterminal.conf"
    symlinker "$(pwd)/template.cpp" "$HOME/.vim/template.cpp"
    symlinker "$(pwd)/prompt_setup" "$HOME/.zprezto/modules/prompt/functions/prompt_setup"
fi
printf "Done\n\n"

# .vim directory and plugins
# delete any previous vim settings
printf "The scrip is about to remove any current vim settings\n"
read -p "Are you sure to overwrite the vim settings? " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]; then
    printf "Checking for .vim directory\n"
    mkdir -p ~/.vim
    if [ $? -ne 0 ]; then
        printf "ERROR: could not create ~/.vim directory, check if you have sufficient rights\n"
    exit 1
    fi
    printf "Done\n\n"
    
    printf "Loading and installing the necessary VIM plugins using Vundle\n"
    printf "Clean the Vundle folder, if needed\n"
    rm -r -f ~/.vim/bundle/Vundle.vim
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    printf "Done\n\n"

    printf "Installing other plugins using command line\n"
    printf "Done\n\n"
else
    printf "The vim setup is skipped\n"
fi

# change to zsh
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    chsh -s $(which zsh) 
else
	printf "ERROR: current platform is not supported\n"
	exit 1
fi
printf "Done\n\n"
