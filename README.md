Setup born from the desire to stop wasting time and energies by re-installing everything in VDI machines every few months. The idea is to be able to easily re-provision all the software I use easily and in an automated fashion (hopefully just a few commands).

This includes:

- AWS CLI
- GitHub CLI
- Python
- Node.js
- Rust
- Other system tools and utilities


# 1. Install nix (single user install)

```bash
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh
. /home/luciano.mammino/.nix-profile/etc/profile.d/nix.sh
```

# 2. Clone the repo

In the home dir:

```bash
mkdir -p repos
cd repos
git clone https://git.renre.com/luciano-mammino/.dotfiles.git
```

# 3. Symlink the nix.conf

in the home dir

```bash
mkdir -p .config/nix
ln -s $HOME/repos/.dotfiles/nix/config/nix.conf .config/nix/nix.conf
```

TBC