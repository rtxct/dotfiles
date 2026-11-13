function fish_setup_cancel_text -v fish_color_cancel -v fish_color_normal
    set -g __fish_cancel_text ""
    if set -q fish_color_cancel
        set __fish_cancel_text (echo -sn (set_color $fish_color_cancel) $__fish_cancel_text (set_color normal))
    end
    if command -sq tput
        # Clear to EOL (to erase any autosuggestions)
        set -l el (tput el 2>/dev/null; or tput ce 2>/dev/null)
        set __fish_cancel_text (echo -sn $__fish_cancel_text $el)
    end
end
fish_setup_cancel_text

# This is meant to be bound to something like \cC.
function cancel_commandline
    set -l cmd (commandline)
    if test -n "$cmd"
        echo -sn $__fish_cancel_text
        # `commandline -L` prints the line the cursor is on (starting from the prompt), so move the cursor
        # "to the end" then call `commandline -L` to get the total number of lines typed in at the prompt.
        commandline -C 10000000
        printf (string repeat -n (commandline -L) "\n")
        commandline ""
        emit fish_cancel
    else
        echo -sn $__fish_cancel_text
        echo
    end

    # cancel: Close the pager if it's open (#4298)
    # repaint: Repaint even if we haven't cancelled anything so the prompt refreshes
    # and the terminal scrolls to it.
    commandline -f cancel -f repaint
end
