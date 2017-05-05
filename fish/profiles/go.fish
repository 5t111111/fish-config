if type go >/dev/null ^/dev/null
    begin
        set -l go_path ''

        if set -q GOPATH
            set go_path "$GOPATH"
        else
            set go_path "$HOME/go"
        end

        if not test -d "$go_path"
            mkdir "$go_path"
        end

        set -gx fish_user_paths "$go_path" $fish_user_paths
        set -gx fish_user_paths "$go_path/bin" $fish_user_paths

        set -x GOPATH "$go_path"
    end
end
