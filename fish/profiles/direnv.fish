if type direnv >/dev/null ^/dev/null
    eval (direnv hook fish)
end

# wrap tmux to avoid issues with environment loading
alias tmux "direnv exec / tmux"
