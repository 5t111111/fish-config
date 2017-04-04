function peco_git_checkout -d "Peco source ro checkout branch"
    git branch -a | peco "BRANCH>" | tr -d ' ' | read branch

    if test -n "$branch"
        if echo $branch | grep -q -E '^.*remotes/.*$'
            set -l b (echo $branch | sed -e 's/^\([^\/]*\)\/\([^\/]*\)\///g')
            commandline "git checkout -b $b $branch"
            commandline -f execute
        else
            commandline "git checkout $branch"
            commandline -f execute
        end
    end
end
