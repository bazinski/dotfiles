# !/bin/bash/

# tester file to install zsh environment

# clone the repo
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# default settings
FILES="zpreztorc zprofile zshenv"
for ifs in `echo $FILES`; do
		SP="$(pwd)/$ifs"
		SH="$HOME/.$ifs"
done

# change default shell to zsh
#sh -s /bin/zsh
