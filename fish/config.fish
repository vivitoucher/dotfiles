# completely suppress the chatty default text greeting on shell launch
function fish_greeting
    # silent canvas
end

# interactive shell aliases and universal git automation shortcuts
if status is-interactive
    # short navigation mappings
    alias ..="cd .."
    alias ...="cd ../.."
    alias c="clear"
    
    # zero-compromise git stream shortcuts
    alias ga="git add"
    alias gs="git status"
    alias gd="git diff"
    alias gc="git commit -m"
    alias gp="git push origin main"
    
    # the ultimate 3-letter shortcut to push rice updates to github instantly
    # usage: gsync "layer 3 updated"
    function gsync
        git add -A
        git commit -m "$argv"
        git push origin main
    end

    # automatically initialize the universal starship prompt layout if installed
    if type -q starship
        starship init fish | source
    end
end
