# Global variables # ------------------------------------------------------------------------------
set -g fish_prompt_pwd_dir_length 3
#set -g fish_greeting ""
# set -g Z_SCRIPT_PATH (brew --prefix)/etc/profile.d/z.sh
#set -gx EDITOR vim

alias ga 'git add'
alias gb 'git branch'
alias gc 'git commit'
alias gclean 'git clean -fd'
alias gco 'git checkout'
alias gcob 'git checkout -b'
alias gd 'git diff'
alias gdca 'git diff --cached'
alias gdt 'git difftool'
alias gf 'git fetch'
alias gl 'git pull'
alias glog 'git log --oneline --decorate --graph'
alias gp 'git push'
alias gpf 'git push --force-with-lease'
alias gr 'git rebase'
alias gri 'git rebase -i'
alias grim 'git rebase -i origin/master'
alias gst 'git status'
alias gwt 'git worktree'
alias groot "cd (git rev-parse --show-toplevel)"

# wrap tmux to avoid issues with environment loading
alias tmux "direnv exec / tmux"

# Language specific configuration
# ------------------------------------------------------------------------------

# Go
# set -x GOPATH $HOME/.go
# set -x PATH /usr/local/opt/go/libexec/bin $PATH
# set -x PATH $GOPATH/bin $PATH

if type direnv >/dev/null ^/dev/null
    eval (direnv hook fish)
end

if type rbenv >/dev/null ^/dev/null
    set -l rbenv_path "$HOME/.rbenv"

    if test -d "$rbenv_path"
        # set PATH "$rbenv_path/bin" $PATH
        set PATH "$rbenv_path/shims" $PATH
        rbenv rehash >/dev/null ^/dev/null
    end
end

# Workaround https://coderwall.com/p/-k_93g/mac-os-x-valueerror-unknown-locale-utf-8-in-python
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
