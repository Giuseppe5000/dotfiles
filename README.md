# How to setup
**You need both sudo and git installed!**

After basic Arch linux installation:
1. ```useradd -m -G wheel <username>```
2. In */etc/sudoers* uncomment ```%wheel ALL=(ALL:ALL) ALL```
3. ```su <username>```
4. ```git clone https://github.com/Giuseppe5000/dotfiles && cd dotfiles```
5. (Optional) Edit pacmanpkg.txt for adding or removing some packages
6. ```chmod +x install.sh && ./install.sh```
7. Reboot
