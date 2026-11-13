set -g fish_greeting

for file in ~/.config/fish/conf.d/env/*.fish
    source $file
end

set -g FISH_PROMPT starship

if status is-interactive
    switch $FISH_PROMPT
        case starship
            starship init fish | source
    end

    for file in ~/.config/fish/functions/__*.fish
        source $file
    end
end

source ~/.config/fish/.env
