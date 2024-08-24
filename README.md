Setup born from the desire to stop wasting time and energies by re-installing everything in VDI machines every few months. The idea is to be able to easily re-provision all the software I use easily and in an automated fashion (hopefully just a few commands).

This includes:

- AWS CLI
- GitHub CLI
- Python
- Node.js
- Rust
- Other system tools and utilities


# Install

## 1. Install nix (single user install)

```bash
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh
. $HOME/.nix-profile/etc/profile.d/nix.sh
```

## 2. Clone the repo

In the home dir:

```bash
mkdir -p repos
cd repos
git clone https://git.renre.com/luciano-mammino/.dotfiles.git
```

## 3. Symlink the nix.conf

in the home dir

```bash
mkdir -p .config/nix
ln -s $HOME/repos/.dotfiles/config/nix.conf $HOME/.config/nix/nix.conf
ln -s $HOME/repos/.dotfiles/config/home-manager $HOME/.config/home-manager
```

## 4. Install and enable home-manager

```bash
nix-shell -p home-manager --command "home-manager switch" 
```


# Configure the terminal emulator

This configuration will install and use fish shell.

In order to use fish shell directly you should use the following binary path in your terminal configuration:

```bash
type fish
```


# Update and refresh the configuration

If you perform any change to the configuration, you should commit all the changes and then run the following command for the new config to be enabled:

```bash
home-manager switch
```
