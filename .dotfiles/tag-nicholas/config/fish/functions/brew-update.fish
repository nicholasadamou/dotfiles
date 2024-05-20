function brew-update --description "Updates brew casks, formulae, and mas apps."
    if type -q mas
        mas upgrade
    end

    if type -q brew
        brew update
        brew upgrade
        
        if test (uname -s) = "Darwin"
            brew tap buo/cask-upgrade
            brew cu --all --yes --cleanup --quiet
        end

        brew cleanup
    end
end