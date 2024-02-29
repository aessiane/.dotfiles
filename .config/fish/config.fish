eval "$(/opt/homebrew/bin/brew shellenv)"

set -gx PYENV_ROOT $HOME/.pyenv
pyenv init - | source

set -gx PATH $HOME/scripts $PATH


set -gx EDITOR nvim

function areDotfilesPushed
    if dotfiles status | grep -q "nothing to commit"
        true
    else
        set -U EM_R "\033[1;31m"
        set -U EM_W "\033[1;37m"
        set -U COLOR_RESET "\033[0m"
        echo -e "🚨$EM_W Dotfiles are not pushed $COLOR_RESET🚨"
        echo
        echo -e "Run $EM_R dotfiles diff $COLOR_RESET to see what's changed, then push the most recent changes"
    end
end


if status is-interactive
    alias vim=nvim
    alias grep=rg
    alias cat=bat
    alias find=fd
    alias diff=difft
    alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    areDotfilesPushed
end

