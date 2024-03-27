#!/bin/bash

SCRIPT_PATH="$HOME"/Projects/dotfiles

function spin() {
  local title="$1"
  shift
  gum spin --spinner line --title "$title" "$@"
}

function install_yay() {
  if ! command -v yay &> /dev/null; then
      spin "Installing yay..." -- \
        git clone https://aur.archlinux.org/yay.git &&
        cd yay &&
        makepkg -si &&
        cd .. &&
        rm -rf yay
  fi
}

function install_gum() {
  if ! command -v gum &> /dev/null; then
      echo "Gum not found. Installing..."
      sudo pacman -S gum --noconfirm
  fi
}

function install_programs() {
  echo "Which program lists do you want to install?"
  PROGRAM_LISTS=$(printf "system-apps\naur-apps\npacman-apps\ndesktop-drivers" | gum choose --no-limit)

  for list in $PROGRAM_LISTS; do
      spin "Installing $list..." -- "$(yay -S --noconfirm - < ./paclists/28-05-23/"$list".txt)"
  done
}

function install_scripts() {
  SCRIPTS=$(ls private/scripts)

  for script in $SCRIPTS; do
    sudo ln -s "$SCRIPT_PATH"/private/scripts/"$script" /usr/local/bin
  done
}

function install_zsh_configuration() {
  curl -L git.io/antigen > "$HOME"/antigen.zsh
  ln -s "$SCRIPT_PATH"/zsh/.zshrc "$HOME"
}

function main() {
  install_gum

  echo "What do you want to do?"
  ACTIONS="all\ninstall_yay\ninstall_programs\ninstall_scripts\ninstall_zsh_configuration\ntest"
  CHOOSEN_ACTIONS=$(echo $ACTIONS | gum choose --no-limit)

  if [[ $ACTIONS == "all" ]]; then
    # TODO: Remove all from actions
    for action in $ACTIONS; do
        $action
    done
  else
    for action in $CHOOSEN_ACTIONS; do
        $action
    done
  fi
}

main