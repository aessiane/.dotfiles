eval "$(/opt/homebrew/bin/brew shellenv)"

set -gx PYENV_ROOT $HOME/.pyenv
pyenv init - | source

alias kjobs='/Users/abel/1.Projects/fax/../kueue-jobs-cli/jobs.py'

set -gx PATH /opt/homebrew/anaconda3/bin/ $PATH
set -gx PATH $PYENV_ROOT/bin $PATH
set -gx PATH $HOME/scripts $PATH
set -gx PATH $HOME/.local/bin $PATH

set -gx PATH /Users/abel/bin $PATH
set -gx PATH /Users/abel/.cargo/bin $PATH
set -gx PATH $PATH $HOME/.krew/bin
set -gx CLOUDSDK_PYTHON_SITEPACKAGES 1

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
    alias tree='tree -C'
    alias vim='OPENAI_API_KEY=(cat /Users/abel/1.Projects/shell-companion/.env | sed "s/.*=//") nvim'
    alias grep=rg
    alias cat=bat
    alias find=fd
    alias diff=difft
    alias dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
    alias psql=pgcli
    areDotfilesPushed

    alias ai='OPENAI_API_KEY=(cat /Users/abel/1.Projects/shell-companion/.env | sed "s/.*=//") poetry -C /Users/abel/1.Projects/shell-companion run ai '
end

fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp
source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/abel/miniconda3/bin/conda
    eval /Users/abel/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/abel/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/abel/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/abel/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


# pnpm
set -gx PNPM_HOME "/Users/abel/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
