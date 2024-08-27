#!/bin/bash

#Welcome to *tup, your tool to optimize your start-up, feel free to change what do you want, happy coding/hacking

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
@ 73xt0n write               888  v2.1 \e[0m"


#Follow the numbers (#1,2,3-.) to configure your *tup.
#
#=======================================================================>
#STARTUP FUNCTIONS
#Help
function usage() {
    cat <<USAGE

    Usage: $0 [-flag]

    Options:
        -su, --skip-update ============> do not update & upgrade the system
        -h, --help ====================> show this helpsheet
        -s, --setup ===================> configure your *tup
	-f, --full ====================> set the time zone and keyboard layer settings and start a full update
USAGE
    exit 1
}

####################
# SETUP ZONE START #
####################

LAYER='es'
TIMECITY='Madrid'
TIMEZONE='Europe/Madrid'

#Setup
function current() {
    echo -e "\e[1;32m > > > > > > > > Welcome to the *tup settings \e[0m"
    echo "CURRENT CONFIGURATION"
    echo "Layer: "
    echo -e "\e[1;32m "$LAYER" \e[0m"
    echo "Time City: "
    echo -e "\e[1;32m "$TIMECITY" \e[0m"
    echo "Time Zone: "
    echo -e "\e[1;32m "$TIMEZONE" \e[0m"
}

function settings() {    
    echo -e "\e[1;32m > > > > > > > > Do you want to make any changes? \e[0m $answer"
    read $answer
        if [[ $answer =~ ([yY][eEaAhHsS]*) ]]; then
            echo "CONFIGURING SETTINGS"
            echo "What's your layer?"
            echo "gb stands for English layer, es for Spanish and so on $answer1"
                read $answer1
                    LAYER=$answer1
                    echo "Layer set with $LAYER"
            echo "What's your time city? $answer2"
                read $answer2
                    TIMECITY=$answer2
                    echo "Time city set with $TIMECITY"
            echo "What's your time zone? $answer3"
                read $answer3
                    TIMEZONE=$answer3
                    echo "Time zone set with $TIMEZONE"
        elif
            [[ $answerb =~ ([nN][oOpPeE]*) ]]; then
                echo "Settings remain unchanged"
        else
            echo -e "\e[1;32m > > > > > > > > WARNING: I can't understand your answer, continuing without changes =) \e[0m";
        fi
}

#Keyboard layer
function keyboard() {
    echo -e "\e[1;32m > > > > > > > > Configuring Keyboard Layer: \e[0m"    
    setxkbmap $LAYER
    setxkbmap -query -v
    echo -e "\e[1;32m Done! \e[0m"
}

#Timezone
function timezone() {
        echo -e "\e[1;32m > > > > > > > > Checking timezone: \e[0m"
        date
        out=$(ls -la /etc/localtime | grep "$TIMECITY")
        if [[ -z $out ]]; then
        echo -e "\e[1;32m > > > > > > > > Configuring time-zone: \e[0m"
        timedatectl set-timezone $TIMEZONE
        timedatectl
        echo -e " Done!" 
fi
}

##################
# SETUP ZONE END #
##################

#Upgrade
function upgrade() {
    sudo apt update
    sudo apt -y upgrade
    sudo apt -y autoremove
}

#Full upgrade
function fupgrade() {
    sudo apt update
    sudo apt -y full-upgrade
    sudo apt -y autoremove
}

#Answer check
function check() {
    echo -e "\e[1;32m > > > > > > > > Do you want to update and upgrade now? \e[0m $answera"
        read answera
        if [[ $answera =~ ([yY][eEaAhHsS]*) ]]; then
            echo -e "\e[1;32m > > > > > > > > Do you want to upgrade the kernel? \e[0m $answerb"
                read answerb
                    if [[ $answerb =~ ([yY][eEaAhHsS]*) ]]; then
                        echo -e "\e[1;32m > > > > > > > > Full upgrade mode enabled \e[0m"
                        fupgrade
                    elif [[ $answerb =~ ([nN][oOpPeE]*) ]]; then
                        echo -e "\e[1;32m > > > > > > > > Normal upgrade mode enabled: \e[0m"
                        upgrade
                    fi
        elif [[ $answera =~ ([nN][oOpPeE]*) ]]; then
            echo -e "\e[1;32m > > > > > > > > Continuing without updates: \e[0m"
        else
            echo -e "\e[1;32m > > > > > > > > Please, for safety, answer the question [y/n]: \e[0m $answerc"
                read answerc
                    if [[ $answerc =~ ([yY][eEaAhHsS]*) ]]; then
                        echo -e "\e[1;32m > > > > > > > > Updating Linux: \e[0m"
                        upgrade
                    else
                        echo -e "\e[1;32m > > > > > > > > Continuing without updates: \e[0m"
                    fi
        fi
finish
}

#Cool finish
function finish() {
        lsb_release -a
        echo -e "\e[1;32m ******** STARTUP COMPLETED SUCCESSFULLY ******** \e[0m"
	screenfetch -c "1:32,1;37" -C 'Creator=73xt0n,Today you will have=HAPPY HACKING DAY'
}

#END OF STARTUP FUNCTIONS
#=======================================================================>
#FLAGS WHILE LOOP START

SKIP_UPDATE=false

while [ "$1" != "" ]; do
    case $1 in
    -su | --skip-update)
        SKIP_UPDATE=true
        ;;
    -h | --help)
        usage
        exit 1
        ;;
    -s | --setup)
        current
        settings
        ;;
    -f | --full)
        keyboard
        timezone
        fupgrade
        finish
        exit 1
        ;;
    *)
        echo -e "\e[1;32m > > > > > > > > WARNING: I can't recognize some flag, check them please =) \e[0m";
        usage
    esac
    shift #remove the current value for '$1' and use the next
done

#FLAGS WHILE LOOP END
#=======================================================================>
#CALLS
 
keyboard
timezone

#CALLS END
#=======================================================================>
#FLAGS CHECK START

if [[ $SKIP_UPDATE == true ]]; then
    echo -e "\e[1;32m > > > > > > > > Continuing without updates: \e[0m"
    finish
elif [[ $SKIP_UPDATE == false ]]; then
    check
fi

#FLAGS CHECK END
#======================================================================>
#Screenfetch install required
