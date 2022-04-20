sudo apt install curl
sudo apt install python3-pip
sudo apt install git
#sudo apt install gcc

git config --global user.email "kyle.grains@gmail.com"
git config --global user.name "Kyle"

#install nvim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb

sudo pip3 install --upgrade pynvim

#for coc nvim
sudo apt install -y nodejs
sudo apt install -y npm

#install PlugInstall
mkdir -p $HOME/.local/share/nvim/site/autoload
cp ./plug.vim $HOME/.local/share/nvim/site/autoload
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir ~/.config/nvim/
cp init.vim ~/.config/nvim/

#install ccls
#sudo apt install ccls
sudo snap install ccls --classic

#install cppman
pip3 install cppman

sudo ln -s /usr/bin/nvim /usr/bin/vim


#snap install cmake --channel=latest/stable --classic
#pip3 install conan
#conan profile new default --detect
#conan profile update settings.compiler.libcxx=libstdc++11 default
