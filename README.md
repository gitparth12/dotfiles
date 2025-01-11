# My Dotfiles

All my configs are here, currently optimized for MacOS. Fork this repository to keep your own copy to develop off of.

## Requirements

Ensure you have the following installed on your system

- Git
- Nix darwin or Stow (if you don't want to use nix)

## Installation

First, clone the dotfiles repo in your `$HOME` directory using git and initialise the neovim submodule so that it updates with the dotfiles repo

```
$ git clone git@github.com/gitparth12/dotfiles.git
$ cd dotfiles
$ git submodule update --init --recursive
```

### Nix Setup

If you don't already have nix setup, install it using the following command that I got from [here](https://github.com/DeterminateSystems/nix-installer)

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

Ensure nix is installed using something like `nix run "nixpkgs#hello"`. Once
confirmed, use gnu stow inside a nix shell to create symlinks. We do this
inside a shell because stow will later be installed through our nix flake.

```
$ nix-shell -p stow
```

Once inside, run `stow -nv .` to see a simulation of what will happen. There
probably will be conflicts because some files already would exist, such as
`~/.zshrc`. If you want to use mine, I suggest taking a backup of your configs
by renaming your files with an added `.bak` at the end.

Given no conflicts, run `stow .` from inside your `~/dotfiles` directory to create
symlinks.

Finally, source zshrc and run darwin-rebuild through the alias in my zshrc.

```
$ source ~/.zshrc
$ rebuild
```

[Inspo Vid](https://www.youtube.com/watch?v=y6XCebnB9gs)
