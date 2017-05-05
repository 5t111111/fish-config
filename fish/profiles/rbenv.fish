begin
    set -l rbenv_path "$HOME/.rbenv"

    if test -d "$rbenv_path/bin"
    	set -gx fish_user_paths "$rbenv_path/bin" $fish_user_paths
    end

    set -gx fish_user_paths "$rbenv_path/shims" $fish_user_paths
    rbenv rehash >/dev/null ^/dev/null
end
