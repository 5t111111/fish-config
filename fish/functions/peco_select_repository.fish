function peco_select_repository -d "Peco source to cd to repository using ghq"
    ghq list -p | peco "REPOSITORY>" | read repository

    if test -n "$repository"
        commandline "cd $repository"
        commandline -f execute
    end
end
