#install nvim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
sudo apt install nvim-linux64.deb

#install PlugInstall
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#install ccls
#sudo apt install ccls
sudo snap install ccls --classic

#install cppman
pip install cppman
