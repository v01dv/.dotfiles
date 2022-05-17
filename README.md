I use GNU Stow (http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) to manage these. If you want to start using any of my configurations:

    1. install stow:
        Ubuntu/Debian: sudo apt install stow
        Arch: sudo pacman -S stow
    2. clone the repo:
        git clone git@github.com:v01dv/.dotfiles ~/.dotfiles
        cd ~/.dotfiles
    3. install the desired configuration files:
        stow nvim
        stow tmux
        etc.

Source: https://github.com/jamesbvaughan/dotfiles
