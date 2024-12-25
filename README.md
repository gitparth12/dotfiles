# My Dotfiles
Don't think I need to explain this. All my configs are here.

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow
```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/gitparth12/dotfiles.git
$ cd dotfiles
```

then use GNU Stow to create symlinks

```
$ stow .
```

[Inspo Vid](https://www.youtube.com/watch?v=y6XCebnB9gs)
