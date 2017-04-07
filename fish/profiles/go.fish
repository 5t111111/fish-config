if type direnv >/dev/null ^/dev/null
    begin
        set -l gopath "$HOME/go"

        if not test -d "$gopath"
            mkdir "$gopath"
        end

        set -g fish_user_paths "$gopath" $fish_user_paths
        set -g fish_user_paths "$GOPATH/bin" $fish_user_paths
    end
end
