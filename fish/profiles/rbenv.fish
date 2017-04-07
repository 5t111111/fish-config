if type rbenv >/dev/null ^/dev/null
    begin
        set -l rbenv_path "$HOME/.rbenv"

        if test -d "$rbenv_path"
            # set -g fish_user_paths "$rbenv_path/bin" $fish_user_paths
            set -g fish_user_paths "$rbenv_path/shims" $fish_user_paths
            rbenv rehash >/dev/null ^/dev/null
        end
    end
end
