set -g fish_prompt_pwd_dir_length 3
set -gx EDITOR vim

begin
    set -l source_dirs aliases profiles
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

# Workaround https://coderwall.com/p/-k_93g/mac-os-x-valueerror-unknown-locale-utf-8-in-python
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

thefuck --alias | source
