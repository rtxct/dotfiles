# Prompt Config
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS='--color=bg+:-1,bg:-1,border:#FFFFFF,spinner:#81A1C1,hl:#81A1C1,fg:#FFFFFF,header:#81A1C1,info:#FFFFFF,pointer:#81A1C1,marker:#81A1C1,fg+:-1,preview-bg:-1,prompt:#FFFFFF,hl+:#81A1C1,gutter:-1'

autoload -U colors && colors
setopt prompt_subst

bold_cyan="%B%F{cyan}"
white="%F{white}"
gray="%F{242}"

reset="%f%b%k"


# PS1="${gray}󰣇  "
PS1="${white}%1~"
PS1+='$(branch=$(git_branch_name); [ -n "$branch" ] && { short_branch=${branch:0:12}; [ ${#branch} -gt 12 ] && short_branch="${short_branch}…"; echo " ${gray}  ${white}${short_branch}${gray}"; })'
PS1+=" ${gray}${reset} "
