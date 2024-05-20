function update --description "Updates Linux/MacOS apps, brew and their installed packages"
    if test (uname -s) = "Linux"
        sudo apt update
        sudo apt upgrade -y
        sudo apt dist-upgrade -y
        sudo apt full-upgrade -y
        sudo apt autoremove -y
        sudo apt clean
    end

    if test (uname -s) = "Darwin"
        sudo softwareupdate --install --all
    end

    if type -q brew
        brew-update
    end
end