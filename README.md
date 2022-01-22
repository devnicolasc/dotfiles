# Dotfiles

Dotfiles are a collection of configuration files that are used to setup easily user preferred configurations.

## dotfiles deployment with shell script
run the following command and you ready to go.
```
GITHUB_USER=devnicolasc
if (( $EUID == 0 ))
  then apt update && apt install -y curl git zsh wget tmux && curl -sSL https://raw.githubusercontent.com/"$GITHUB_USER"/dotfiles/main/dotfiles-install.sh | sh; 
  else sudo apt update && sudo apt install -y curl git zsh wget tmux && curl -sSL https://raw.githubusercontent.com/"$GITHUB_USER"/dotfiles/main/dotfiles-install.sh | sh;
fi 
```

## manually use dotfiles:
1) install cli dependencies as root user or with sudo:
```
if (( $EUID == 0 ))
  then apt update && apt install -y git zsh wget tmux
  else sudo apt update && sudo apt install -y git zsh wget tmux
fi
```
3) remove dotfiles folder if exist
```
if [ -d "$DOTFILES_DIR" ]; then
    printf '%s\n' "Removing Lock ($DOTFILES_DIR)"
    rm -rf "$DOTFILES_DIR"
fi
```
4) clone dotfiles repository
```
DOTFILES_DIR=$HOME/dotfiles
GITHUB_USER=nicolas-cho
git clone --bare https://github.com/"$GITHUB_USER"/dotfiles.git $DOTFILES_DIR
```
5) Download dotfiles repo via HTTPS
```
git clone --bare https://github.com/"$GITHUB_USER"/dotfiles.git $DOTFILES_DIR
```
6) add configurations (config is an alias directly to the configurations folder ('dotfiles' in this case)
```
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```
7) [install dependencies](#install-dependencies)

### tests:
1) check if 'config' alias configured correctly
```
> config status
nothing to commit, working directory clean
```
2) check if "alias config.." is in your .zsh file 
```
cat ~/.zshrc
```
### install dependencies 
1) Download and install OH-MY-ZSH with --unattended and --keep-zshrc flags.
```
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O ohmyzsh-setup.sh
unset ZSH
sh ohmyzsh-setup.sh --unattended --keep-zshrc
```
2) Download powerlevel10k theme and plugins
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```
3) Change the default shell to zsh
```
sudo chsh -s $(which zsh) $(whoami)
```
4) run zsh command to enter the shell
```
zsh
```

test:
```
zsh --version
```

