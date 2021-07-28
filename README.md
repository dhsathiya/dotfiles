# dotfiles
Backup kinda things !

## GNOME Extensions
```
Current_screen_only_for_Alternate_Tab@bourcereau.fr  desktop-icons@csoriano  pixel-saver@deadalnix.me  ubuntu-appindicators@ubuntu.com  ubuntu-dock@ubuntu.com
```

My script to install oh-my-zsh, tmux and tmux.conf [WIP - Making it completely GitHub base]

```shell
#!/bin/bash
clear
echo "---------------------------"
echo "|    Updating APT list    |"
echo "---------------------------"
sudo apt update
clear
echo "---------------------------"
echo "|     Installing zsh      |"
echo "---------------------------"
sudo apt install zsh -y
clear
echo "---------------------------"
echo "|     Installing tmux     |"
echo "---------------------------"
sudo apt install tmux -y
clear
echo "---------------------------"
echo "|   Installing oh-my-zsh  |"
echo "---------------------------"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
clear
echo "-------------------------------------------------------------"
echo "|   Do you want Devarshi's custom tmux conf and zsh theme?  |"
echo "-------------------------------------------------------------"
read -p "Do you want to install Devarshi's custom tmux conf and zsh theme? y/n:" customconf
if [ "$customconf" = "y" ] || [ "$customconf" = "yes" ]; then
    clear
    echo "-----------------------------------"
    echo "|   adding Devarshi's custom conf |"
    echo "-----------------------------------"
    sed -i 's/robbyrussell/bira/g' .zshrc
    wget -qO .tmux.conf devarshi.xyz/setup/tmuxconf
    clear
    echo "----------------------"
    echo "|   You're all set   |"
    echo "----------------------"
    elif [ "$customconf" = "n" ] || [ "$customconf" = "no" ]; then
        clear
        echo "----------------------"
        echo "|   You're all set   |"
        echo "----------------------"
    else
        clear
        echo "---------------------------------------------------------"
        echo "|   Invalid option selected so not adding custom conf   |"
        echo "---------------------------------------------------------"
fi
zsh
rm ./setup
```
web based command (Nope, I don't have verification methods implemented yet.)
```shell
wget -qO setup devarshi.xyz/setup && sudo bash setup
```


vim color scheme : https://github.com/sjl/badwolf
