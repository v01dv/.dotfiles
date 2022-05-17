 # Create list of official repository packages 
pacman -Qqe | grep -vx "$(pacman -Qqm)" > pkglist-official.txt

# Create the list of AUR and other foreign packages that have been explicitly installed.
pacman -Qqm > pkglist-foreign.txt

# Update repository database, then restore packages from list
sudo pacman -Sy
sudo pacman -S --needed $(cat pkglist-official.txt)   

 # Paru doesn't have --needed check
paru -S $(cat pkglist-foreign.txt)


Details:
https://bbs.archlinux.org/viewtopic.php?id=76218
https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages

