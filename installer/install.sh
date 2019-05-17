#!/bin/bash
echo "---------------------------"
echo "|    Updating APT list    |"
echo "---------------------------"
sudo apt update
echo "---------------------------"
echo "|     Installing zsh      |"
echo "---------------------------"
sudo apt install zsh -y
echo "---------------------------"
echo "|     Installing tmux     |"
echo "---------------------------"
sudo apt install tmux -y
echo "---------------------------"
echo "|     Installing git      |"
echo "---------------------------"     
sudo apt install git -y
echo "---------------------------"
echo "|   Installing oh-my-zsh  |"
echo "---------------------------"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "-------------------------------------------------------------"
echo "|   Do you want Devarshi's custom tmux conf and zsh theme?  |"
echo "-------------------------------------------------------------"
read -p "Do you want to install Devarshi's custom tmux conf and zsh theme? y/n:" customconf
if [ "$customconf" = "y" ] || [ "$customconf" = "yes" ]; then
    echo "-----------------------------------"
    echo "|   adding Devarshi's custom conf |"
    echo "-----------------------------------"
    git clone https://github.com/dhsathiya/dotfiles.git
    sed -i 's/robbyrussell/gnzh/g' ~/.zshrc
    cd dotfiles/
    cp -r .vim ~/
    cp .bashrc ~/
    cp .kubectl_aliases ~/
    cp .tmux.conf ~/ 
    cp .vimrc ~/
    rm -rf ~/git
    echo "----------------------"
    echo "|   You're all set   |"
    echo "----------------------"
    elif [ "$customconf" = "n" ] || [ "$customconf" = "no" ]; then
        echo "----------------------"
        echo "|   You're all set   |"
        echo "----------------------"
    else
        echo "---------------------------------------------------------"
        echo "|   Invalid option selected so not adding custom conf   |"
        echo "---------------------------------------------------------"
fi
zsh
rm ./setup

