#!/bin/sh
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
export LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/bin:$PATH"

install_vim(){

  #check packages 
  if yum listed installed "ncurses-devel" > /dev/null 2>&1; then
     echo "ncurses-devel installed for vim build"
  else
    echo " your system is missing ncurses-devel this is too much to build, fix it rather."
    exit 1
  fi
  if yum listed installed "python-devel" > /dev/null 2>&1; then
     echo "python-devel installed for vim build"
  else
    echo " your system is missing python-devel this is too much to build, fix it rather."
    exit 1
  fi

mkdir -p $HOME/tmp/vim 
cd $HOME/tmp/vim
git clone https://github.com/vim/vim.git
cd src && git check v8.0.1522

./configure --disable-nls --enable-cscope --enable-gui=no \
            --enable-multibyte  --enable-pythoninterp --enable-rubyinterp \
            --prefix=${HOME}/.local/vim --with-features=huge  \
            --with-python-config-dir=/usr/lib/python2.7/config --with-tlib=ncurses --without-x
make && make install

}

install_tmux(){
mkdir -p $HOME/tmp/tmuxinstall 
cd $HOME/tmp/tmuxinstall 
if [ ! -e libevent-2.1.8-stable.tar.gz ]; then
  wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
fi
if [ ! -e libevent-2.1.8-stable.tar.gz ]; then
  echo "failed to download libevent figure out why ... exiting"
  exit 1
fi
tar xvzf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
if [ ! -e $HOME/lib/libevent-2.1.so.6   ]; then 
  #this has not been built or an error occured so rebuild
  ./configure --prefix=$HOME
  make && make install
fi

cd $HOME/tmp/tmuxinstall 
if [ ! -e tmux-2.2.tar.gz ]; then 
  wget https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
fi
if [ ! -e tmux-2.2.tar.gz ]; then 
    echo "failed to download tmux-2-2 figure out why ... exiting"
    exit 1
fi
tar xvzf tmux-2.2.tar.gz
cd tmux-2.2
LDFLAGS="-L$HOME/lib -Wl,-rpath=$HOME/lib" CFLAGS="-I $HOME/include" ./configure --prefix=$HOME
make
make install

}

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

#install tmux if < v2.3 or non existant
tmux_ver="$(tmux -V | awk '{print $2}' )"
echo "tmux is version : "${tmux_ver}
#we need tmux 1.9 or greater for tpm to manage plugins in tmux
if [[ `echo "$tmux_ver < 1.9"|bc` -eq 1 ]]; then
  echo "tmux ver is too low";
  install_tmux
else 
  echo "tmux ver is fine $tmux_ver";
fi


#install vim if < v7.4.209 or non existant
vim_ver="$(vim --version | awk '{print $5}' | head -n 1 )"
echo "vim is version : "${vim_ver}
#we need tmux 1.9 or greater for tpm to manage plugins in tmux
if [[ `echo "$vim_ver < 7.4"|bc` -eq 1 ]]; then
  echo "vim version is too low";
  install_vim
else 
  echo "vim version is fine $vim_ver";
fi

  # tmux plugins 
printf "This scipt is about to remove tmux plugins\n"
read -p "Are you sure to overwrite the tmux settings?" -n 1 -r
echo
export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins/
if [[ $REPLY =~ ^[Yy]$ ]]; then 
  printf "Checking for .tmux directory \n"
  if [ -d ~/.tmux ]; then 
    rm -rf ~/.tmux/
  fi
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  git clone https://github.com/bazinski/tmux-continuum ~/.tmux/plugins/tmux-continuum
  export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
   ~/.tmux/plugins/tpm/bin/install_plugins
fi

cd ~/.tmux/plugins/tpm
git pull
~/.tmux/plugins/tpm/bin/update_plugins all
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
