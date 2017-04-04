function peco_find -d "Peco source to find file"
    find . -name "*$argv[1]*" | grep -v "/\." | peco "FIND>" | read entry

    if test -n "$entry"
        commandline $entry
    end
end
