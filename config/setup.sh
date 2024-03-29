#sudo echo "185.199.108.133 raw.githubusercontent.com" >> /etc/hosts
sudo apt install curl
sudo apt install python3-pip
sudo apt install git
#sudo apt install gcc

git config --global user.email "kyle.grains@gmail.com"
git config --global user.name "Kyle"

#install nvim
#wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
#sudo apt install ./nvim-linux64.deb

sudo apt install -y python3-pip
sudo pip3 install --upgrade pynvim

#for coc nvim
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install -y npm

#install PlugInstall
#mkdir -p $HOME/.local/share/nvim/site/autoload
#cp ./plug.vim $HOME/.local/share/nvim/site/autoload
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
#source ~/.profile
#conan profile new default --detect
#conan profile update settings.compiler.libcxx=libstdc++11 default

#sudo apt install cppcheck clang-tidy ccache

#:PlugInstall
#:CocConfig
#:CocInstall coc-marketplace
#:CocInstall coc-cmake

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
