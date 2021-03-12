#!/bin/bash
# docker images don't need sudo
SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi
$SUDO a_command

if grep -q Amazon /etc/*release
then
    $SUDO yum update
    $SUDO yum install -y tmux zsh git htop
fi
if grep -q "Ubuntu\|Debian" /etc/*release
then
    $SUDO apt update
    $SUDO apt install -y zsh tmux git htop
fi
locale-gen en_US.UTF-8 
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
pip install python-language-server 
cp append_zshrc ~
cp .vimrc ~
mkdir -p ~/.config/nvim
cp 2.finish_setup.sh ~
cp 3.vim_setup.sh ~
cp init.vim ~/.config/nvim/init.vim 
cp .tmux.conf ~
cd
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
git clone https://github.com/zsh-users/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors
git clone https://github.com/zsh-users/zsh-autosuggestions
mkdir ~/.zsh
mv ~/zsh-autosuggestions ~/.zsh
mv ~/zsh-syntax-highlighting ~/.zsh
git config --global user.email "crjward@gmail.com"
git config --global user.name "doncarlos999"
wget https://nodejs.org/dist/v15.9.0/node-v15.9.0-linux-x64.tar.xz
mkdir ~/opt
tar xvf node-v15.9.0-linux-x64.tar.xz \
    --exclude CHANGELOG.md \
    --exclude LICENSE \
    --exclude README.md \
    --strip-components 1 \
    -C ~/opt
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
