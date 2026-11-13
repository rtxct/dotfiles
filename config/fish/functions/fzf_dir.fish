function fzf_dir
    set -l dir (
        fd --type d --hidden --exclude .git |
        fzf \
            --scheme=path \
            --prompt='Directories > ' \
            --preview 'eza --tree --level=2 --color=always --icons=never -- {} 2>/dev/null' \
            --preview-window='right,50%,border-left'
    )

    if test -n "$dir"
        cd "$dir"
    end

    commandline -f repaint
end
