```sh
brew install tmux fd bat fish fzf ripgrep difftastic gh git htop jq k9s kubernetes-cli node pyenv python tree wget
brew install --HEAD neovim
# Install oh my tmux: https://github.com/gpakosz/.tmux (follow instructions to install in ~/.config/tmux
# Install oh my fish: curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# Add keys to GH

# Clone dotfiles
git clone --bare <git-repo-url> $HOME/.dotfiles.git
git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME config --local status.showUntrackedFiles no

# Change default shell to fish
which fish
sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
# Restart terminal

# Install monofur font: https://www.nerdfonts.com/font-downloads
#   -> https://support.apple.com/en-gb/guide/font-book/fntbk1000/mac
#   -> Change Regular & Non-ASCII fonts in iTerm2
# Install vim-plug
# Configure pyenv (should be installed and configured through previous commands, all that should be needed is the below)
pyenv install 3
pyenv global 3

# Add python3 support for nvim
pip install --user --upgrade pynvim
```
