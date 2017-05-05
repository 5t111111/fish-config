if type yarn >/dev/null ^/dev/null
    set -gx fish_user_paths (yarn global bin) $fish_user_paths
end
