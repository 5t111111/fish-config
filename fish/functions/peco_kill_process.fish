function peco_kill_process -d "Peco source to select and kill process"
    ps aux | peco "PROCESS>" | awk '{ print $2 }' | read pid

    if test -n "$pid"
        commandline "kill $pid"
        commandline -f execute
    end
end
