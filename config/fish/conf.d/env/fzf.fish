set -g FZF_CO0OR_FG        '#c0c0c0'
set -g FZF_COLOR_BG        '-1'
set -g FZF_COLOR_HL        '#ffffff'

set -g FZF_COLOR_FG_PLUS   '#ffffff'
set -g FZF_COLOR_BG_PLUS   '-1'
set -g FZF_COLOR_HL_PLUS   '#ffffff'

set -g FZF_COLOR_INFO      '#888888'
set -g FZF_COLOR_PROMPT    '#ffffff'
set -g FZF_COLOR_POINTER   '#ffffff'
set -g FZF_COLOR_MARKER    '#ffffff'
set -g FZF_COLOR_SPINNER   '#aaaaaa'
set -g FZF_COLOR_HEADER    '#888888'
set -g FZF_COLOR_BORDER    '#555555'
set -g FZF_COLOR_LABEL     '#aaaaaa'
set -g FZF_COLOR_QUERY     '#ffffff'
set -g FZF_COLOR_SCROLLBAR '#777777'

# FZF defaults
set -gx FZF_DEFAULT_OPTS "\
    --height=100% \
    --layout=reverse \
    --border=none \
    --padding=0 \
    --margin=0 \
    --info=inline \
    --cycle \
    --color=fg:$FZF_COLOR_FG,bg:$FZF_COLOR_BG,hl:$FZF_COLOR_HL,fg+:$FZF_COLOR_FG_PLUS,bg+:$FZF_COLOR_BG_PLUS,hl+:$FZF_COLOR_HL_PLUS,info:$FZF_COLOR_INFO,prompt:$FZF_COLOR_PROMPT,pointer:$FZF_COLOR_POINTER,marker:$FZF_COLOR_MARKER,spinner:$FZF_COLOR_SPINNER,header:$FZF_COLOR_HEADER,border:$FZF_COLOR_BORDER,label:$FZF_COLOR_LABEL,query:$FZF_COLOR_QUERY,scrollbar:$FZF_COLOR_SCROLLBAR"

# Default FZF file search (also used by other FZF integrations)
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'


