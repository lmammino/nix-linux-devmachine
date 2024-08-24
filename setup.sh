#!/bin/env/bash

set -eou pipefail

REPO="https://git.renre.com/luciano-mammino/.dotfiles.git"

echo -e ">>> 1. Installing nix\n\n"
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh
. $HOME/.nix-profile/etc/profile.d/nix.sh

echo -e "\n\n>>> 2. Cloning repository ($REPO)\n\n"
mkdir -p repos
cd repos
git clone $REPO

echo -e "\n\n>>> 3. Linking configuration\n\n"
mkdir -p .config/nix
ln -s $HOME/repos/.dotfiles/config/nix.conf $HOME/.config/nix/nix.conf
ln -s $HOME/repos/.dotfiles/config/home-manager $HOME/.config/home-manager


echo -e "\n\n>>> 4. Installing and enabling home-manager\n\n"
nix-shell -p home-manager --command "home-manager switch"

echo -e "\n\n>>> ALL DONE\n\n"
type fish