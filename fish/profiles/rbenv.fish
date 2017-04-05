if type rbenv >/dev/null ^/dev/null
    begin
        set -l rbenv_path "$HOME/.rbenv"

        if test -d "$rbenv_path"
            # set -x PATH "$rbenv_path/bin" $PATH
            set -x PATH "$rbenv_path/shims" $PATH
            rbenv rehash >/dev/null ^/dev/null
        end
    end
end
