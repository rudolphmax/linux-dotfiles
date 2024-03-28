#!/usr/bin/bash

echo " -- SDDM --"
echo "Copying Theme..."
pushd ~/dotfiles/sddm
sudo cp -r  ./reactionary /usr/share/sddm/themes/
sudo cp ./sddm.conf /etc/
popd

