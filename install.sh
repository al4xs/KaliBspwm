#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

sudo apt update -y

# Instalando dependencias

sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Instalando requerimentos do polybar

sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev

# Dependencias do picom

sudo apt install -y meson picom libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev

# Instalamos pacotes adicionais

sudo apt install -y kitty feh scrot scrub rofi xclip bat locate ranger neofetch wmname acpi bspwm sxhkd imagemagick cmatrix hollywood exiftool bpytop apktool seclists villain rlwrap python3-venv aircrack-ng

# Criamos a pasta do Repositorio

mkdir ~/github

# Descarregamos repositorios necessarios

cd ~/github
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/ibhagwan/picom.git

# Instalando Polybar

cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Instalando Picom

cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Configuramos o tema Nord de Rofi:

mkdir -p ~/.config/rofi/themes
cp $ruta/rofi/nord.rasi ~/.config/rofi/themes/

# Instando lsd

sudo dpkg -i $ruta/lsd.deb

# Instalamos as fonts

sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/

# Instalando tudo de config

sudo rm -rf ~/.config/bin
sudo rm -rf ~/.config/bspwm
sudo rm -rf ~/.config/dunst
sudo rm -rf ~/.config/kitty
sudo rm -rf ~/.config/notify
sudo rm -rf ~/.config/picom
sudo rm -rf ~/.config/polybar
sudo rm -rf ~/.config/rofi
sudo rm -rf ~/.config/sxhkd
sudo rm -rf /opt/kitty

sudo cp -v $ruta/Config/polybar/fonts/* /usr/share/fonts/truetype/
cp -rv $ruta/Config/* ~/.config/

# Instalando Wallpapers

mkdir ~/Wallpaper
cp -v $ruta/Wallpaper/* ~/Wallpaper/
mkdir ~/ScreenShots
sudo cp -rv $ruta/kitty /opt/

# Copia de configuracao de .p10k.zsh e .zshrc

sudo rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc
sudo rm -rf ~/.p10k.zsh
cp -v $ruta/.p10k.zsh ~/.p10k.zsh

sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh
cp -rv $ruta/home/* ~/
cp -rv $ruta/home/.* ~/

# Script

sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/

# Plugins ZSH

sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Configuramos a shell do zsh

sudo ln -s -fv ~/.zshrc /root/.zshrc

# Damos as permissoes do Scritps

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py
sudo chmod +x /usr/local/bin/screenshot

# Configuramos o tema Rofi

rofi-theme-selector

# Instalamos o i3lock

sudo apt install -y i3lock-color
cd $ruta
sudo cp -R $ruta/Components/i3lock-color-everblush/i3lock-everblush /usr/bin/
xfconf-query --create -c xfce4-session -p /general/LockCommand -t string -s "i3lock-everblush"

# Removemos Repositorio

rm -rf ~/github
sleep 5
rm -rfv $ruta

# Mensagem

notify-send "BSPWM INSTALADO"
