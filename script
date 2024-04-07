#!/bin/bash
#Welcome to *tup, your tool to optimize your start-up, feel free to change what you want, happy coding/hacking
#BANNER
echo -e "\e[1;32m             888
      o      888
     d8b     888
    d888b    888888 888  888 88888b.
\"Y888888888P\"888    888  888 888 \"88b
  \"Y88888P\"  888    888  888 888  888
  d88P\"Y88b  Y88b.  Y88b 888 888 d88P
 dP\"     \"Yb  \"Y888  \"Y88888 88888P\"
                             888
@ n0x1us idea                888
@ 73xt0n write               888 \e[0m"

#KEYBOARD LAYER:
echo -e "\e[1;32m > > > > > > > > Configuring Keyboard Layer: \e[0m"

#1-.You can change the keyboard layer after the command setxkbmap
#es stands for Spanish layer
#gb for English layer.
setxkbmap es

setxkbmap -query -v
echo -e "\e[1;32m Done! \e[0m"

#TIMEZONE:
echo -e "\e[1;32m > > > > > > > > Checking timezone: \e[0m"
date

#2-.Put your timezone city after grep command.
out=$(ls -la /etc/localtime | grep Madrid)
if [[ -z $out ]]; then
echo -e "\e[1;32m > > > > > > > > Configuring time-zone: \e[0m"

#Put your timezone city after 'set-timezone'.
        timedatectl set-timezone Europe/Madrid
        timedatectl
        echo -e "\e[1;32m Done! \e"
fi

#UPDAT/GRADING:
#FIRST TRY
echo -e "\e[1;32m > > > > > > > > Do you want to update and upgrade now?\e[0m $answer"
        read answer
if [[ $answer =~ ([yY][eEaAhHsS]*) ]]; then
        echo -e "\e[1;32m > > > > > > > > Updating Kali-Linux: \e[0m"
        sudo apt update

#If you want a normal upgrade, change the # of the sentence bellow and put on the beggining of the next one (like this: sudo apt -y upgrade & #sudo apt -y full-upgrade):
	#sudo apt -y upgrade
        sudo apt -y full-upgrade

        sudo apt -y autoremove
elif [[ $answer =~ ([nN][oOpPeE]*) ]]; then
        echo -e "\e[1;32m > > > > > > > > Confirm your choice: \e[0m";
else
        echo -e "\e[1;32m > > > > > > > > Please, for safety, answer the question [y/n] \e[0m"
fi

#SECOND TRY
$answerb
        read answerb
if [[ $answerb =~ ([yY][eEaAhHsS]*) ]]; then
        echo -e "\e[1;32m > > > > > > > > Updating Kali-Linux: \e[0m"
        sudo apt update
        sudo apt -y full-upgrade
        sudo apt -y autoremove
else
        echo -e "\e[1;32m > > > > > > > > Continuing without updates \e[0m";
fi
lsb_release -a
echo -e "\e[1;32m ******** STARTUP COMPLETED SUCCESSFULLY ******** \e[0m"

#COOL FINISH:
# Istall Screenfetch or remove this part to avoid the final error.
#You can change the message of "Today you will have:" changing the message next to the equal.
screenfetch -c "1:32,1;37" -C 'Creator=73xt0n,Today you will have=HAPPY HACKING DAY'
