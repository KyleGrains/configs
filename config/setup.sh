#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_packages() {
  sudo apt update
  sudo apt install -y \
    clangd \
    curl \
    fzf \
    git \
    nodejs \
    npm \
    python3-pip \
    tmux

  python3 -m pip install --user --upgrade pynvim cppman
}

link_file() {
  local source_file="$1"
  local target_file="$2"

  mkdir -p "$(dirname "$target_file")"
  ln -sfn "$source_file" "$target_file"
}

setup_git() {
  git config --global user.email "kyle.grains@gmail.com"
  git config --global user.name "Kyle"
}

setup_shell_tools() {
  link_file "$CONFIG_DIR/.screenrc" "$HOME/.screenrc"
  link_file "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
  link_file "$CONFIG_DIR/.ccls" "$HOME/.ccls"
}

setup_nvim() {
  mkdir -p "$HOME/.config/nvim"

  link_file "$CONFIG_DIR/init.vim" "$HOME/.config/nvim/init.vim"
  link_file "$CONFIG_DIR/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload"
  if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
      --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

setup_vim_alias() {
  if command -v nvim >/dev/null 2>&1 && [ ! -e /usr/bin/vim ]; then
    sudo ln -s "$(command -v nvim)" /usr/bin/vim
  fi
}

install_packages
setup_git
setup_shell_tools
setup_nvim
setup_vim_alias

cat <<'EOF'
Done.

Open nvim and run:
  :PlugInstall
  :CocInstall coc-marketplace coc-cmake coc-clangd
EOF
