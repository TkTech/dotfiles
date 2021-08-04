# Explicitly update brew, then disable the automatic check.
if ! command -v brew &> /dev/null
then
    echo "Homebrew must be installed before using this utility."
    exit 1
fi

brew update
export HOMEBREW_NO_AUTO_UPDATE=1

brew install --cask iterm2
brew install tmux ripgrep
brew install --HEAD neovim
