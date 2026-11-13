
function vpn
    if not set -q VPN_PATH
        echo "VPN_PATH is not set."
        return 1
    end

    set -l config (fd --type f --extension ovpn --hidden -- "$VPN_PATH" |
        fzf --prompt='VPN config > ')

    if test -n "$config"
        openvpn --config "$config"
    end
end

