set -g fish_prompt_pwd_dir_length 3
set -gx EDITOR vim

begin
    set -l source_dirs aliases
    set -l fish_config_dir "$HOME/.config/fish"

    pushd $fish_config_dir

    for dir in $source_dirs
        if test -d $dir; and not test (git check-ignore $dir)
            for src in (ls $dir)
                if not test (git check-ignore $dir/$src)
                    source $dir/$src
                end
            end
        end
    end

    popd
end

# Homebrew's sbin
if not contains "/usr/local/sbin" $fish_user_paths
    set -U fish_user_paths "/usr/local/sbin" $fish_user_paths
end

# Initalize pluggable environent settings
go_init
rbenv_init
direnv_init
yarn_init

# Source local specific config
begin
    set -l fish_local_config "$HOME/.config/fish/config.local.fish"
    if test -f $fish_local_config
        source $fish_local_config
    end
end
