#!/bin/sh
# Usage: bash < <(curl -s https://gist.github.com/raw/965142/install.sh)

if [ ! -d "/Developer/Applications/Xcode.app" ]; then
  echo "Please install Xcode first. Exiting."  
  exit 1
fi

# Have sudo ask us for our password before we kick everything off so we can walk away.
sudo echo "Here we go..."

echo "Installing Homebrew..."
ruby -e "$(curl -fsSLk https://gist.github.com/raw/323731/install_homebrew.rb)"
brew install git

echo "Installing other Homebrew packages..."
brew install zsh
brew install svn
brew install tmux
brew install jslint
brew install mcrypt
brew install ack
brew install ctags
brew install z
brew install imagemagick
brew install ffmpeg
brew install sphinx
brew install scala
brew install erlang
brew install node
brew install go
brew install io
brew install mysql

#
brew install tornado
brew install pymongo

unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo "Installing dotfiles..."
/usr/local/bin/git clone git@github.com:rockerBOO/dotfiles.git ~/.dotfiles
(cd ~/.dotfiles && rake)
sudo chsh -s /usr/local/bin/zsh $(whoami)

echo "Installing RubyGems..."
gem install rails
gem install sinatra
gem install jekyll
gem install capistrano
gem install sass
gem install boom
gem install jslint

echo "Installing Pow..."
curl get.pow.cx | sh

echo "Installing MacVim..."
brew install macvim
sudo ln -s $(brew --prefix macvim)/MacVim.app /Applications

echo "Installing iTerm..."
curl -s http://iterm2.googlecode.com/files/iTerm2-beta1.zip > /tmp/iterm.zip
unzip /tmp/iterm.zip
sudo mv iTerm.app /Applications

echo "Done. Enjoy it."
