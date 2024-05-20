source /dev/stdin <<<"$(curl -s "https://raw.githubusercontent.com/nicholasadamou/utilities/master/utilities.sh")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

header() {
    echo -en "\n███████╗███████╗████████╗   ███╗   ███╗███████╗    ██╗   ██╗██████╗"
    echo -en "\n██╔════╝██╔════╝╚══██╔══╝   ████╗ ████║██╔════╝    ██║   ██║██╔══██╗"
    echo -en "\n███████╗█████╗     ██║█████╗██╔████╔██║█████╗█████╗██║   ██║██████╔╝"
    echo -en "\n╚════██║██╔══╝     ██║╚════╝██║╚██╔╝██║██╔══╝╚════╝██║   ██║██╔═══╝"
    echo -en "\n███████║███████╗   ██║      ██║ ╚═╝ ██║███████╗    ╚██████╔╝██║"
    echo -en "\n╚══════╝╚══════╝   ╚═╝      ╚═╝     ╚═╝╚══════╝     ╚═════╝ ╚═╝"
    echo -en "\n\n"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo -e "\n${bold}\$HOME sweet /~\n${normal}"

echo -e "Welcome to the '${bold}set-me-up${normal}' installer."
echo -e "For more information, please see [https://github.com/nicholasadamou/set-me-up]."
echo -e "Please follow the on-screen instructions.\n"

warn "${bold}This script sets up new machines, *use with caution*${normal}."
warn "${bold}Ensure your Mac or *Debian* Linux system is fully up-to-date${normal}."

header
