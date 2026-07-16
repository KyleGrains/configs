#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/configs-backup"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"
BACKUP_CREATED=0
MIN_NVIM_VERSION="0.9.0"
MIN_NODE_VERSION="18.0.0"

version_at_least() {
  local actual="$1"
  local minimum="$2"
  [ "$(printf '%s\n%s\n' "$minimum" "$actual" | sort -V | head -n 1)" = "$minimum" ]
}

require_supported_system() {
  if [ ! -r /etc/os-release ]; then
    echo "Cannot identify the operating system." >&2
    exit 1
  fi

  # shellcheck disable=SC1091
  source /etc/os-release
  if [ "${ID:-}" != "ubuntu" ] || ! version_at_least "${VERSION_ID:-0}" "24.04"; then
    echo "This setup supports Ubuntu 24.04 or newer." >&2
    exit 1
  fi
  if [ "$EUID" -ne 0 ] && ! command -v sudo >/dev/null 2>&1; then
    echo "sudo is required when setup is not run as root." >&2
    exit 1
  fi
}

check_tool_versions() {
  local nvim_version
  local node_version

  nvim_version="$(nvim --version | sed -n 's/^NVIM v\([0-9.]*\).*/\1/p' | head -n 1)"
  node_version="$(node --version | sed 's/^v//')"

  if ! version_at_least "$nvim_version" "$MIN_NVIM_VERSION"; then
    echo "Neovim $MIN_NVIM_VERSION or newer is required; found $nvim_version." >&2
    exit 1
  fi
  if ! version_at_least "$node_version" "$MIN_NODE_VERSION"; then
    echo "Node.js $MIN_NODE_VERSION or newer is required; found $node_version." >&2
    exit 1
  fi
}

run_as_root() {
  if [ "$EUID" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

install_packages() {
  run_as_root apt-get update
  run_as_root apt-get install -y \
    build-essential \
    clangd \
    cmake \
    curl \
    fzf \
    git \
    neovim \
    nodejs \
    ripgrep \
    screen \
    tmux \
    unzip
}

backup_target() {
  local target_file="$1"
  local relative_target="${target_file#"$HOME"/}"
  local backup_file="$BACKUP_DIR/$relative_target"

  if [ -e "$target_file" ] || [ -L "$target_file" ]; then
    mkdir -p "$(dirname "$backup_file")"
    mv "$target_file" "$backup_file"
    BACKUP_CREATED=1
    echo "Backed up $target_file to $backup_file"
  fi
}

link_file() {
  local source_file="$1"
  local target_file="$2"

  if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
    return
  fi

  backup_target "$target_file"
  mkdir -p "$(dirname "$target_file")"
  ln -s "$source_file" "$target_file"
}

setup_git() {
  if ! git config --global user.email >/dev/null; then
    git config --global user.email "kyle.grains@gmail.com"
  fi
  if ! git config --global user.name >/dev/null; then
    git config --global user.name "Kyle"
  fi
}

setup_shell_tools() {
  link_file "$CONFIG_DIR/.screenrc" "$HOME/.screenrc"
  link_file "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
}

setup_nvim() {
  mkdir -p "$HOME/.config/nvim"

  link_file "$CONFIG_DIR/init.vim" "$HOME/.config/nvim/init.vim"
  link_file "$CONFIG_DIR/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload"
  if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    curl --connect-timeout 15 --retry 3 --retry-delay 2 \
      -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
      --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

install_nvim_plugins() {
  nvim --headless -u "$HOME/.config/nvim/init.vim" -i NONE \
    "+PlugInstall --sync" \
    "+qa"

  nvim --headless -u "$HOME/.config/nvim/init.vim" -i NONE \
    "+CocInstall -sync coc-clangd coc-basedpyright" \
    "+qa"
}

verify_setup() {
  nvim --headless -u "$HOME/.config/nvim/init.vim" -i NONE "+qa!"
}

main() {
  require_supported_system
  install_packages
  check_tool_versions
  setup_git
  setup_shell_tools
  setup_nvim
  install_nvim_plugins
  verify_setup

  echo
  echo "Setup complete."
  if [ "$BACKUP_CREATED" -eq 1 ]; then
    echo "Previous configuration was saved under: $BACKUP_DIR"
  fi
  echo "Open Neovim with: nvim"
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  main "$@"
fi
