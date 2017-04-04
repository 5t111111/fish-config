function peco -a prompt -d "wrapper function for peco"
    if test -n "$prompt"
        command peco --layout=bottom-up --prompt $prompt
    else
        command peco --layout=bottom-up
    end
end
