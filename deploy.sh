#!/bin/sh
set -e

HOMESICK_DIR=$HOME/.homesick/repos
HOMESHICK_PATH=$HOMESICK_DIR/homeshick/bin
HOMESHICK=$HOMESHICK_PATH/homeshick
DOTFILES_DIR=$(pwd)/$(dirname $0)
installHomeshick() {
    echo "Homeshick not installed, installing..."
    mkdir -p $HOMESICK_DIR
    git clone git://github.com/andsens/homeshick.git $HOMESICK_DIR/homeshick
}

symlinkdotfiles(){
    echo "Symlinking dotfiles"
    [ ! -d $HOMESICK_DIR/dotfiles ] || { echo "Dotfiles directory exists" >&2; exit -1 ; }
    ln -s $DOTFILES_DIR $HOMESICK_DIR/dotfiles
    $HOMESHICK link dotfiles
}

deploy(){
    USER=$1
    CASTLE=$2
    $HOMESHICK list | grep "$USER/$CASTLE$" && { echo "$CASTLE already exists" >&2; exit -1 ; }
    $HOMESHICK clone -f $USER/$CASTLE
    $HOMESHICK cd $CASTLE
    [ ! -x deploy ] || ./deploy
    $HOMESHICK link -f $CASTLE
}

# Check whether homeshick is installed
command -v homeshick >/dev/null 2>&1 || [ -d $HOMESICK_DIR ] || installHomeshick
# Check whether this directory is symlinked
[ -h $HOMESICK_DIR/dotfiles ] || symlinkdotfiles

# Checkout vimplugins
deploy annonymouse vim-castle

