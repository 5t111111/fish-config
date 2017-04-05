if type direnv >/dev/null ^/dev/null
    begin
        set -l gopath "$HOME/go"

        if not test -d "$gopath"
            mkdir "$gopath"
        end

        set -x GOPATH "$gopath"
        set -x PATH "$GOPATH/bin" $PATH
    end
end
