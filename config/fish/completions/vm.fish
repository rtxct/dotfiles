
function __fish_vm_complete
    set -l VM_DIR /usr/local/lib/vm
    set -l args (commandline -opc)
    set -l current (commandline -ct)

    set -e args[1]

    if test (count $args) -gt 0
        if test "$args[-1]" = "$current"
            set -e args[-1]
        end
    end

    for file in $VM_DIR/vm-*
        test -f "$file"; or continue

        set -l parts (string split '-' -- (string replace "$VM_DIR/vm-" '' -- "$file"))

        set -l matches 1

        for i in (seq (count $args))
            if test "$parts[$i]" != "$args[$i]"
                set matches 0
                break
            end
        end

        test $matches -eq 1; or continue

        set -l index (math (count $args) + 1)

        if test $index -le (count $parts)
            string match -q -- "$current*" "$parts[$index]"
            and echo $parts[$index]
        end
    end
end

complete -c vm -f -a '(__fish_vm_complete)' -d 'VM command'

