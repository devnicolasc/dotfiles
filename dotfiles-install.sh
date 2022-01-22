#!/bin/bash

set -e

DOTFILES_DIR=$HOME/dotfiles
GITHUB_USER=devnicolasc

if [ -d "$DOTFILES_DIR" ]; then
    printf '%s\n' "Removing Lock ($DOTFILES_DIR)"
    rm -rf "$DOTFILES_DIR"
fi

# * Download dotfiles repo via HTTPS
git clone --bare https://github.com/"$GITHUB_USER"/dotfiles.git $DOTFILES_DIR

# * For SSH use the following command
#git clone --bare git@github.com:"$GITHUB_USER"/dotfiles.git $DOTFILES_DIR

# * Checkout the dotfiles repo
/usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$HOME checkout

# * Download and install OH-MY-ZSH with --unattended and --keep-zshrc flags.
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O ohmyzsh-setup.sh

unset ZSH
sh ohmyzsh-setup.sh --unattended --keep-zshrc

# * Download powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# * Download plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# * Change the defalt shell
# if [[ "$EUID" == 0 ]]; then 
chsh -s $(which zsh) $(whoami)
# fi

echo 'Well Done! now run zsh command to enter the shell'
