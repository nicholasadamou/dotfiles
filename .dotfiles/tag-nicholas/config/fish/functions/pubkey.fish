function pubkey
    if ! -f ~/.ssh/id_rsa.pub; then
        echo 'No public key found.'
        return 1
    end

    cat ~/.ssh/id_rsa.pub | pbcopy; and echo '=> Public key copied to pasteboard.'
end
