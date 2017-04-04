function peco_select_history -d "Peco source to select from history"
    history | peco "HISTORY>" | read entry

    if test -n "$entry"
        commandline $entry
    end
end
