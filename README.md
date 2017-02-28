## Overview

This is my personal environment of dot files.

This is a conflagration of a pile of dotfile directories on github.
It is attempted to keep is as simple as possible and a trivial install process.
 

* LXTerminal
* prezto zsh
* tmux - terminal multiplier
* vim (customized for C++, C ), a bit of python and puppet as well.


## Platforms

It is known to work on debian testing (what ever the latest version is), Centos6 and Centos7

## Requirements

Most of the packages are present on Linux by default. 

* `git`
* `zsh`
* `vim`
* `tmux`
* `mc`

## Installation  

To perform the download, run from terminal:  

```
$ git clone https://github.com/bazinski/dotfiles.git  
$ cd dotfiles
$ git submodule update --init --recursive  
```

```
$ ./install.sh
```

For Linux, it has to be run under `sudo` and bash must be enforced:
  
```
$ chmod +x install.sh
$ sudo bash install.sh
```





