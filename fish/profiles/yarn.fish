if type yarn >/dev/null ^/dev/null
    set -g fish_user_paths (yarn global bin) $fish_user_paths
end
