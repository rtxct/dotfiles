function fzf_file
    set -l file (
        fd --type f --hidden --exclude .git |
        fzf \
            --scheme=path \
            --prompt='Files > ' \
            --preview 'bat --style=numbers --color=always --line-range=:300 -- {} 2>/dev/null' \
            --preview-window='right,60%,border-left'
    )

    if test -n "$file"
        nvim "$file"
    end

    commandline -f repaint
end
