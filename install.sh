# This is an installer of all the dependencies and my dotfiles
# Prerequisites to all of the files
# Homebrew PKGs moved to brewdepen.sh
echo "Installing Homebrew and it's custom packages"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Enrolling in homebrew dev branch"
export HOMEBREW_DEVELOPER=1

echo "Tapping packages"
brew tap homebrew/cask-fonts
brew tap homebrew/cask
brew tap homebrew/bundle
brew tap homebrew/core
brew tap homebrew/services
brew tap d12frosted/emacs-plus

echo "Installing fonts"
brew install --cask font-fira-code-nerd-font
brew install --cask font-sf-mono
brew install --cask font-roboto-mono-nerd-font
brew install --cask font-alegreya

echo "Installing Dependencies"
brew install ranger
brew install ripgrep
brew install aspell

echo "Building Neovim nightly"
brew install luajit --HEAD
brew install neovim --HEAD

echo "setting up fish"
brew install --cask alacritty
brew install fish
brew install starship
brew install fortune cowsay
sudo sh -c 'echo $(which fish) >> /etc/shells'
chsh -s $(which fish)
set -U fish_user_paths $(which brew) $fish_user_paths

echo "Installing Apps from MAS"
brew install mas
mas install 1480933944
mas upgrade

echo "Install doom emacs"
brew install emacs-plus@28 --with-xwidgets --with-native-comp --with-elrumo2-icon
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

echo "Installing Latex Packages"
brew install --cask basictex
sudo tlmgr install dvipng dvisvgm l3packages xcolor soul adjustbox collectbox amsmath siunitx cancel mathalpha

#Clone Dotfile Repo
echo "Cloning Dotfiles"
git clone https://github.com/shaunsingh/vimrc-dotfiles.git

#Clone bar into default Übersicht location
echo "installing bar"
brew install --cask ubersicht
git clone https://github.com/zzzeyez/pecan.git "$HOME/Library/Application Support/Übersicht/widgets/pecan"
cd vimrc-dotfiles

echo "Installing Dotfiles from Cloned Repository"
cp -R .config ~
cp .zshrc .skhdrc .yabairc .gitconfig ~
cp -R .doom.d ~

echo "Installing and syncing emacs"
doom sync -u

echo "Installing and syncing Neovim"
nvim --headless +PackerSync +qa

echo "grabbing wallpapers"
cp -R wallpapers ~

echo "Cleanup"
brew services start yabai
brew services start skhd
brew update
brew upgrade
brew cleanup

cd
rm -R vimrc-dotfiles


echo "Done!"

echo "                Further User Setup                   "
echo "-----------------------------------------------------"
echo "                                                     "
echo "       You can copy over colors.css for pecan        "
echo "   You can re-run doom sync to sync emacs plugins    "
echo "  You can re-run :PackerSync to sync neovim plugins  "
echo "                                                     "
echo "     Install Vimium and Firenvim for Vi in Chrome    "
echo "                                                     "
echo "      Thats it, thanks for downloading, enjoy :)     "
