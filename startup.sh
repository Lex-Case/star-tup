#!/bin/bash

#Welcome to *tup, your tool to optimize your start-up, feel free to change what do you want, happy coding/hacking

############
# MESSAGES #
############

bye="\e[1;32m > > > > > > > > WARNING: Unidentified response. Exiting without changes... \e[0m"

##############
# GVARIABLES #
##############

who=$(whoami)
cusers=($(cat /etc/passwd | grep /home | awk -F':' '{ print $1 }'))
args=()
dires=('Tools/MyTools' 'Tools/Dev' 'Labs/Dev' 'Labs/Xploit' 'Ops' 'Vault/VPNs' 'Vault/MyWL')
tools=('seclists' 'zaproxy' 'gobuster' 'docker.io' 'gnome-terminal' 'screenfetch' )
repos=('tarunkant/Gopherus' 'vladko312/SSTImap' 'lgandx/Responder' 'openwall/john' 's0md3v/XSStrike' 'Bashfuscator/Bashfuscator' 'danielbohannon/Invoke-DOSfuscation' 'Lex-Case/fuse4me' )
olduname=''
LAYER='es'
TIMECITY='Madrid'
TIMEZONE='Europe/Madrid'
SKIP_UPDATE=false

#####################
# STARTUP FUNCTIONS #
#####################

######################### BANNER 

function bbanner() {
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
@ 73xt0n write               888  v2.2 \e[0m"
}


function lbanner() {
    echo -e "\e[1;32m+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
 |*|t|u|p| |m|a|n|a|g|e|m|e|n|t|
 +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
 v2.2 \e[0m"
}
function usage() { #Añadir nuevas opciones y ejemplos de uso
    cat <<USAGE

    Usage: $0 [-flag]

    Options:
        -h,--help ======================> show this helpsheet

        -s,--setup =====================> configure your keyboard layer & time zone
        -su,--skip-update ==============> only configure keyboard layer & time zone
        -u,--upgrade ===================> set the time zone, keyboard layer and start the update
        -f,--full ======================> set the time zone, keyboard layer and start a full update
        
        -iT,--install-tools ============> install tool list
        -sT,--show-tools ===============> show tools list
        -aT,--add-tool =================> add new tools
        -rT,--remove-tool ==============> remove tools with its index
        
        -iR,--install-repos target/dir => intall repository list, default dir: /home/${cusers[0]}
        -sR,--show-repos ===============> show repos list
        -aR,--add-repo =================> add new repository
        -rR,--remove-repo ==============> remove repositories with its index
        
        -nE,--new-environment ==========> set up a new environment (-s,-f,-pM,-uM,-dT,-iT,-iR,-n)
        
        -dT,--dir-tree =================> create new directory tree
        -mT,--manage-tree ==============> manage directory tree

        -uM,--users-management =========> manage account name
        -pM,--pass-management ==========> manage password credentials
        
        -n,--net =======================> show current network configuration
USAGE
}


######################### SETUP ZONE
function current() {
    echo -e "\e[1;32m > > > > > > > > Current configuration: \n\e[0m"
    echo -e "\e[1;32m Layer: \e[0m"
    echo "$LAYER"
    echo -e "\e[1;32m Time City: \e[0m"
    echo "$TIMECITY"
    echo -e "\e[1;32m Time Zone: \e[0m"
    echo "$TIMEZONE"
}

function settings() {    
    echo -e "\e[1;32m > > > > > > > > Do you want to make any changes? \e[0m $answer"
    read answer
    if [[ $answer =~ ([yYsS][iIpPeEaAhHsS]*) ]]; then
        echo -e "\e[1;32m> > > > > > > > Configuring settings: \e[0m"
        echo -e "\e[1;32mWhat's your keyboard layer? \e[0m $answer1"
        read $answer1
        LAYER=$answer1
        echo -e "\e[1;32mLayer set with $LAYER \e[0m"
        echo -e "\e[1;32mWhat's your time city? $answer2 \e[0m"
        read $answer2
        TIMECITY=$answer2
        echo -e "\e[1;32mTime city set with $TIMECITY \e[0m"
        echo -e "\e[1;32mWhat's your time zone? $answer3 \e[0m"
        read $answer3
        TIMEZONE=$answer3
        echo -e "\e[1;32mTime zone set with $TIMEZONE \e[0m"
        check
    elif
        [[ $answer =~ ([nN][oOpPeE]*) ]]; then
            echo -e "\e[1;32m> > > > > > > > Settings remain unchanged \e[0m"
    else
        echo -e "$bye"
        exit 1
    fi
}

######################### ENV MANAGEMENT
#Keyboard layer
function keyboard() {
    echo -e "\e[1;32m> > > > > > > > Configuring Keyboard Layer: \e[0m"    
    setxkbmap $LAYER
    setxkbmap -query -v
    echo -e "\e[1;32mDone! \e[0m"
}

#Timezone
function timezone() {
    echo -e "\e[1;32m> > > > > > > > Checking timezone: \e[0m"
    date
    out=$(ls -la /etc/localtime | grep "$TIMECITY")
    if [[ -z $out ]];then
    echo -e "\e[1;32m> > > > > > > > Configuring time-zone: \e[0m"
    timedatectl set-timezone $TIMEZONE
    timedatectl 
    fi
    echo -e "\e[1;32mDone! \e[0m"
}

######################### UPDATE ZONE
#Upgrade
function upgrade() {
    echo -e "\e[1;32m> > > > > > > > Update in progress... \e[0m"
    sudo apt update && apt -y upgrade && apt -y autoremove
}

#Full upgrade
function fupgrade() {
    echo -e "\e[1;32m> > > > > > > > Update in progress... \e[0m"
    sudo apt update && apt -y full-upgrade && apt -y autoremove
}

#Check
function check() {
    echo -e "\e[1;32m > > > > > > > > Do you want to update and upgrade now? \e[0m $answera"
    read answera
    if [[ $answera =~ ([yYsS][iIpPeEaAhHsS]*) ]];then
        echo -e "\e[1;32m > > > > > > > > Do you want to upgrade the kernel? \e[0m $answerb"
        read answerb
        if [[ $answerb =~ ([yYsS][iIpPeEaAhHsS]*) ]];then
            echo -e "\e[1;32m > > > > > > > > Full upgrade mode enabled \e[0m"
            fupgrade
        else
            echo -e "\e[1;32m > > > > > > > > Normal upgrade mode enabled: \e[0m"
            upgrade
        fi
    elif [[ $answera =~ ([nN][oOpPeE]*) ]];then
        echo -e "\e[1;32m > > > > > > > > Continuing without updates: \e[0m"
    else
        echo -e "\e[1;32m > > > > > > > > Please, for safety, answer the question [y/n]: \e[0m $answerc"
        read answerc
        if [[ $answerc =~ ([yYsS][iIpPeEaAhHsS]*) ]];then
            echo -e "\e[1;32m > > > > > > > > Updating Linux: \e[0m"
            upgrade
        else
            echo -e "\e[1;32m > > > > > > > > Continuing without updates: \e[0m"
        fi
    fi
finish
}


######################### NEW ENV ZONE
#Tree
function dirtree() {
    echo -e "\e[1;32m> > > > > > > > Preparing new environment... \e[0m"
    for user in "${cusers[@]}";do
        echo -e "\e[1;32mCreating the $user directory tree\e[0m"
        for dire in "${dires[@]}";do
                mkdir -p /home/"$user"/"$dire"
        done
        tree /home/"$user" -L 2
        echo -e "\e[1;32mDone!\e[0m"
    done
}

#Manage dirs tree
function mandirs() {
    ndires="${args[@]}"
    echo -e "\e[1;32m> > > > > > > > Managing tree directories \e[0m"
    echo -e "\e[1;32mCurrent distribution:\e[0m"
    echo "${dires[@]}"
    echo -e "\e[1;32mNew distribution:\e[0m"
    echo "$ndires"
    echo -e "\e[1;32m> > > > > > > > Do you want to save the changes? $answerd \e[0m"
    read answerd
    if [[ $answerd =~ ([yYsS][iIeEaAhHsS]*) ]];then
        unset 'dires[@]'
        for dire in "${args[@]}";do
                dires+=("$dire")
        done
        echo -e "\e[1;32m> > > > > > > > Saving changes... \e[0m"
        sed -i "/^dires=/c\dires=($(printf "'%s' " "${dires[@]}"))" "$0"
        echo -e "\e[1;32mDone!\e[0m"
    elif [[ $answerd =~ ([nN][oOpPeE]*) ]];then
        echo -e "\e[1;32m> > > > > > > > Exiting without changes..."
        exit 1
    else
        echo -e $bye
    fi
}

#Passwords management
function mpass() {
    echo -e "\e[1;32m> > > > > > > > Managing passwords... \e[0m"
    if [[ $who == root ]];then
        for user in "${cusers[@]}";do
            passwd "$user"
        done
        echo -e "\e[1;32mChanging password for root: \e[0m"
        passwd
    else
        for user in "${cusers[@]}";do
            passwd "$user"
        done
        echo -e "\e[1;32mChanging password for root: \e[0m"
        sudo passwd root
    fi
}


#Users management
function musers() {
    echo -e "\e[1;32m> > > > > > > > Do you want to change the name of the current account/s?\e[0m\n\e[5;31mWARNING: You have to be logged as root! $ansuser\e[0m"
    read ansuser
    if [[ $ansuser =~ ([sSyY][iIpPeEaAhHsS]*) ]];then
    echo -e "\e[1;32m> > > > > > > > Changing username...\e[0m"
    ucheck=($(users))
    for i in "${!ucheck[@]}"; do
            if [[ ${ucheck[$i]} == root ]];then
                    unset 'ucheck[$i]'
            fi
    done
        if [[ -z ${ucheck[@]} ]]; then
                for user in "${cusers[@]}";do
                    echo -e "\e[1;32mEnter a new name for account $user:\e[0m $ansname"
                    read ansname
                    nname="$ansname"
                    usermod -l "$nname" "$user"
                    usermod -d /home/"$nname" -m "$nname"
                    groupmod -n "$nname" "$user"
                    echo -e "\e[1;32mChecking results:\e[0m"
                    tree -L 1 /home
                    id "$nname"
                    echo -e "\e[1;32mDone!\e[0m"
                done
        else
            echo -e "\e[5;31m> > > > > > > > WARNING: Open sessions detected!\e[0m"
            echo -e "\e[1;32mIf you log out, log in as root and restart the process ($0 -uM)\e[0m]"
            echo -e "\e[1;32mClosing open sessions:\e[0m"
            echo $ucheck
            for user in "${ucheck[@]}";do
                pkill -u $user
                pkill -9 -u $user
            done
            echo -e "\e[1;32mDone!\e[0m"
            for user in "${cusers[@]}";do
                    echo -e "\e[1;32mEnter a new name for account $user:\e[0m $ansname"
                    read ansname
                    nname="$ansname"
                    usermod -l "$nname" "$user"
                    usermod -d /home/"$nname" -m "$nname"
                    groupmod -n "$nname" "$user"
                    echo -e "\e[1;32mChecking results:\e[0m"
                    tree -L 1 /home
                    id "$nname"
                    echo -e "\e[1;32mDone!\e[0m"
            done
        fi
    else
    echo -e "\e[1;32mContinuing without changes...\e[0m"
    fi
}

######################### TOOLS
#Install tools
function installtools() {
    echo -e "\e[1;32m> > > > > > > > Installing tools... \e[0m"
    if [[ $who == root ]];then
        apt install "${tools[@]}" -y
    else
        sudo apt install "${tools[@]}" -y
    fi
    echo -e "\e[1;32mDone!\e[0m"
}

#Check tools
function checktools() {
    echo -e "\e[1;32m> > > > > > > > Showing updated tool list: \e[0m"
    for i in "${!tools[@]}";do
        echo "$i ${tools[$i]}"
    done
    echo -e "\e[1;32m> > > > > > > > Do you want to save the changes? $answert \e[0m"
    read answert
    if [[ $answert =~ ([yYsS][iIpPeEaAhHsS]*) ]];then
        updatetools
    elif [[ $answert =~ ([nN][oOpPeE]*) ]];then
        echo -e "\e[1;32m> > > > > > > > Exiting without changes..."
        exit 1
    else
        echo -e "$bye"
        exit 1   
    fi
}

#Show tools
function showtools() {
    echo -e "\e[1;32mTool list: \e[0m"
    for i in "${!tools[@]}";do
        echo "$i ${tools[$i]}"
    done
}


#Add tools
function addtool() {
    echo -e "\e[1;32m> > > > > > > > Adding new tools... \e[0m"
    for tool in "${args[@]}";do
        tools+=("$tool")
    done
    echo -e "\e[1;32mDone!\e[0m"
    checktools
}

#Remove tools
function removetool() {
    echo -e "\e[1;32m> > > > > > > > Deleting tools... \e[0m"
    for index in "${args[@]}";do
        unset 'tools[$index]'
    done
    echo -e "\e[1;32mDone!\e[0m"
    checktools
}

#Update Tools Array
function updatetools() {
    echo -e "\e[1;32m> > > > > > > > Saving changes... \e[0m"
    sed -i "/^tools=/c\tools=($(printf "'%s' " "${tools[@]}"))" "$0"
    echo -e "\e[1;32mDone!\e[0m"
}

######################### REPOS 
#Repository target dir
function repodir() {
    if [[ -z "$2" ]];then
        targetdir="/home/${cusers[0]}/Tools"
    else
        targetdir="$2"
    fi
}


#Download repos
function installrepos() {
    echo -e "\e[1;32m> > > > > > > > Installing repositories... \e[0m"
    for repo in ${repos[@]};do
        namerepo=$(echo $repo | awk -F '/' '{print $2}')
        git clone https://github.com/"$repo" "$targetdir"/"$namerepo"
    done
    echo -e "\e[1;32mDone!\e[0m"
}

#Check repos
function checkrepos() {
    echo -e "\e[1;32m> > > > > > > > Repository list: \e[0m"
    for i in "${!repos[@]}";do
        echo "$i ${repos[$i]}"
    done
    echo -e "\e[1;32m> > > > > > > > Do you want to save the changes? $answerr \e[0m"
    read answerr
    if [[ $answerr =~ ([yYsS][iIeEaAhHsS]*) ]];then
        updaterepos
    elif [[ $answerr =~ ([nN][oOpPeE]*) ]];then
        echo -e "\e[1;32m> > > > > > > > Exiting without changes..."
        exit 1
    else
        echo -e $bye
        exit 1   
    fi
}

#Show repos
function showrepos() {
    echo -e "\e[1;32mRepository list: \e[0m"
    for i in "${!repos[@]}";do
        echo "$i ${repos[$i]}"
    done
}

#Add repos
function addrepo() {
    echo -e "\e[1;32m> > > > > > > > Adding new repositories... \e[0m"
    for repo in "${args[@]}";do
        repos+=("$repo")
    done
    echo -e "\e[1;32mDone!\e[0m"
    checkrepos
}

#Remove repos
function removetool() {
    echo -e "\e[1;32m> > > > > > > > Deleting repositories... \e[0m"
    for index in "${args[@]}";do
        unset 'repos[$index]'
    done
    echo -e "\e[1;32mDone!\e[0m"
    checkrepos
}

#Update repos array
function updaterepos() {
    echo -e "\e[1;32m> > > > > > > > Saving changes... \e[0m"
    sed -i "/^repos=/c\repos=($(printf "'%s' " "${repos[@]}"))" "$0"
    echo -e "\e[1;32mDone!\e[0m"
}

######################### NET INFO
function net() {
    echo -e "\e[1;32m> > > > > > > > Network information \e[0m"
    echo -e "\e[1;32mPublic IP: \e[0m"
    curl ifconfig.me
    echo -e "\n\e[1;32mLocal IPs: \e[0m"
    ip addr
    echo -e "\e[1;32m> > > > > > > > Checking IPs connectivity... \e[0m"
    inets=$(ip addr | grep -w inet | grep -v 127.0.0.1 | awk '{print $2}' | cut -d "/" -f 1)
    echo -e "\e[1;32mResults: \e[0m"
    for net in $inets;do
        if ping -c 1 $net &>/dev/null
            then
                echo "$net status: UP"
            else
                echo "$net status: DOWN"
        fi
    done
    echo -e "\e[1;32m> > > > > > > > Checking Netmasks: \e[0m"
    netmasks=$(ifconfig | grep -w inet | grep -v 127.0.0.1 | awk '{print $4}' | cut -d ":" -f 2)
    paste <(printf %s "$inets") <(printf %s "$netmasks")
    echo -e "\e[1;32m> > > > > > > > Checking DNS \e[0m"
    dnsip=$(cat /etc/resolv.conf | egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
    echo -e "\e[1;32mCurrent DNS:\e[0m"
    echo "$dnsip"
    echo -e "\e[1;32mChecking Connectivity... \e[0m"
    resultlu=$(host "$dnsip")
    ping -W 30 -Hv $dnsip -c 1
    checkrip=$(echo "$resultlu" | grep Host)
    if [[ -z "$checkrip" ]]; then
        echo -e "\e[1;32mResult: \e[0m" 
        echo "$resultlu"
        echo -e "\e[1;32mSuccessful DNS lookup \e[0m"
    else
        echo -e "\e[1;32mResult:\e[0m"
        echo -e "\e[1;31mDNS Server $dnsip:\e[0m\e[5;31m lookup failure \e[0m"
    fi
}

function removeoptions() {
        args=("$@")
        unset 'args[0]'
}


######################### FINAL BANNER
function finish() {
    echo -e "\e[1;32m ******** STARTUP COMPLETED SUCCESSFULLY ******** \e[0m"
        screenfetch -c "1:32,1;37" -C 'Creator=73xt0n,Today you will have=HAPPY HACKING DAY'
}

##########################
# FLAGS WHILE LOOP START #
##########################

if [[ $# == 0 ]];then
    bbanner
    keyboard
    timezone
    check
    exit 1
else
    while :; do
        case $1 in
        -h | --help)
            usage
            exit 1
            ;;
        -su | --skip-update)
            bbanner
            keyboard
            timezone
            finish
            exit 1
            ;;
        -s | --setup)
            lbanner
            current
            settings
            exit 1
            ;;
        -f | --full)
            bbanner
            keyboard
            timezone
            fupgrade
            finish
            exit 1
            ;;
        -u | --upgrade)
            bbanner
            keyboard
            timezone
            upgrade
            finisih
            exit 1
            ;;
        -iT | --install-tools)
            installtools
            exit 1
            ;;
        -aT | --add-tool)
            lbanner
            removeoptions "$@"
            addtool
            exit 1
            ;;
        -rT | --remove-tool)
            lbanner
            removeoptions "$@"
            removetool
            exit 1
            ;;
        -sT | --show-tools)
            lbanner
            showtools
            exit 1
            ;;
        -iR | --install-repos)
            repodir "$2"
            installrepos
            exit 1
            ;;
        -aR | --add-repo)
            lbanner
            removeoptions "$@"
            addrepo
            exit 1
            ;;
        -rR | --remove-repo)
            lbanner
            removeoptions "$@"
            removerepo
            exit 1
            ;;
        -sR | --show-repos)
            lbanner
            showrepos
            exit 1
            ;;
        -n | --net-check)
            bbanner
            net
            exit 1
            ;;
        -nE | --new-environment)
            bbanner
            current
            settings
            keyboard
            timezone
            mpass
            dirtree
            showtools
            installtools
            fupgrade
            showrepos
            repodir
            installrepos
            net
            sleep 2
            finish
            exit 1
            ;;
        -dT | --dir-tree)
            bbanner
            dirtree
            exit 1
            ;;
        -mT | --manage-tree)
            lbanner
            removeoptions "$@"
            mandirs
            exit 1
            ;;
        -uM | --user-management)
            bbanner
            musers
            exit 1
            ;;
        *)
            echo -e "\e[1;31m > > > > > > > > WARNING: I can't recognize some flag, check them please! \e[0m";
            usage
            exit 1
        esac
    done
fi
