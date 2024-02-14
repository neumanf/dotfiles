#!/bin/bash

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

function main() {
    install_gum
    install_yay
    install_programs
}

main