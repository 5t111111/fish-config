# \c : control + key
# \e : option + key

function fish_user_key_bindings
    bind \cr fzf_select_history
    bind \cg fzf_select_repository
    bind \ef fzf_find
    bind \eo fzf_git_checkout
    bind \es fzf_git_status
    bind \ek fzf_kill_process
    bind \ee fzf_select_emoji
end
