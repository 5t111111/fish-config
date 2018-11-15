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

# Add /usr/local/bin to paths at first
if not contains "/usr/local/bin" $fish_user_paths
    set -g fish_user_paths "/usr/local/bin" $fish_user_paths
end

# Homebrew's sbin
if not contains "/usr/local/sbin" $fish_user_paths
    set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
end

# Haskell Stack bin
if not contains "$HOME/.local/bin" $fish_user_paths
    set -g fish_user_paths "$HOME/.local/bin" $fish_user_paths
end

# Go typical Linux installation bin
if not contains "/usr/local/go/bin" $fish_user_paths
    set -g fish_user_paths "/usr/local/go/bin" $fish_user_paths
end

# Rust $HOME/.cargo/bin
if not contains "$HOME/.cargo/bin" $fish_user_paths
    set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
end

# PHP $HOME/.composer/vendor/bin
if not contains "$HOME/.composer/vendor/bin" $fish_user_paths
    set -g fish_user_paths "$HOME/.composer/vendor/bin" $fish_user_paths
end

# fnm PATH (unexpectedly set after /usr/local/bin
set -g fish_user_paths "$HOME/.config/fnm/bin" $fish_user_paths

# Manually installed fzf
if not contains "$HOME/.fzf/bin" $fish_user_paths
    set -g fish_user_paths "$HOME/.fzf/bin" $fish_user_paths
end

# The latest Swift Toolchain

if not contains "/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin" $fish_user_paths
    set -g fish_user_paths "/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin" $fish_user_paths
end


# Initalize pluggable environent settings
go_init
rbenv_init
direnv_init
yarn_init

# Launch GPG Agent or connect to it
set -x GPG_TTY (tty)
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:0:1"
if [ ! (pgrep -x -u $USER "gpg-agent" | head -1) ]
    set -el DISPLAY
    echo "Invoking gpg-agent"
    gpg-connect-agent /bye
end

# Source local specific config
begin
    set -l fish_local_config "$HOME/.config/fish/config.local.fish"
    if test -f $fish_local_config
        source $fish_local_config
    end
end
