#!/usr/bin/bash

echo "Make sure to stow . first!"
echo ""

echo "-- Packages --"

echo "Installing yay..."
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/yay
pushd ~/yay
makepkg -si
popd
rm -rf ~/yay

pushd ~/dotfiles

echo "Installing packages with yay..."
yay -S --needed < ~/dotfiles/pkglist.txt
popd

echo "Installing Pacman auto-update pkglist hook..."
sudo mkdir /etc/pacman.d/hooks
sudo cp update_pkglist.hook /etc/pacman.d/hooks/
