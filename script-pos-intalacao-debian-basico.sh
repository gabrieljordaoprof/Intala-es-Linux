#!/bin/bash

# Configura o /etc/apt/sources.list
cat <<EOL > /etc/apt/sources.list
deb http://deb.debian.org/debian/ stable main contrib non-free
deb-src http://deb.debian.org/debian/ stable main contrib non-free

deb http://deb.debian.org/debian-security/ stable-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ stable-security main contrib non-free

deb http://deb.debian.org/debian/ stable-updates main contrib non-free
deb-src http://deb.debian.org/debian/ stable-updates main contrib non-free
EOL

# Atualiza a lista de pacotes
apt update

# Instala o Xorg e o ambiente gráfico
apt install --no-install-recommends -y xorg

# Instala o gerenciador de arquivos, painel, gerenciador de login, navegador e suíte de escritório
apt install --no-install-recommends -y pcmanfm lxpanel slim firefox-esr libreoffice libreoffice-l10n-pt-br firefox-esr-l10n-pt-br

# Instala o GNOME Software como gerenciador de pacotes gráfico
apt install --no-install-recommends -y gnome-software

# Instala o Flatpak
apt install --no-install-recommends -y flatpak

# Adiciona o repositório Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Integra o Flatpak ao GNOME Software
apt install --no-install-recommends -y gnome-software-plugin-flatpak

# Instala o Nitrogen para gerenciar papéis de parede
apt install --no-install-recommends -y nitrogen

# Instala o lxsession
apt install --no-install-recommends -y lxsession

# Instala o Openbox
apt install --no-install-recommends -y openbox

# Instala o PulseAudio e o pavucontrol
apt install --no-install-recommends -y pulseaudio pavucontrol

# Instala o gedit
apt install --no-install-recommends -y gedit

# Instala o Network Manager e a interface gráfica
apt install --no-install-recommends -y network-manager network-manager-gnome

# Instala o feh para visualizar imagens
apt install --no-install-recommends -y feh

# Instala o mpv para assistir vídeos
apt install --no-install-recommends -y mpv

# Instala o UFW
apt install --no-install-recommends -y ufw

# Instala o Sakura (emulador de terminal)
apt install --no-install-recommends -y sakura

# Configura o UFW
ufw default deny incoming  # Negar todas as conexões de entrada
ufw default allow outgoing  # Permitir todas as conexões de saída
ufw enable                 # Ativar o UFW

# Configura o teclado para ABNT2
setxkbmap -layout br -variant abnt2

# Adiciona o comando para configurar o teclado ao autostart
echo "setxkbmap -layout br -variant abnt2" >> ~/.config/lxsession/LXDE/autostart

# Configura o Slim como gerenciador de login
echo "slim" >> /etc/X11/default-display-manager

# Habilita o Slim para iniciar com o sistema
systemctl enable slim

# Adiciona programas para iniciar automaticamente
# Exemplo: Adicionando o lxpanel e nitrogen ao autostart
mkdir -p ~/.config/lxsession/LXDE  # Garante que o diretório exista
echo "@lxpanel" >> ~/.config/lxsession/LXDE/autostart
echo "nitrogen --restore &" >> ~/.config/lxsession/LXDE/autostart

# Adiciona o Openbox ao autostart
echo "openbox-session" >> ~/.config/lxsession/LXDE/autostart

# Adiciona o controle de volume ao lxpanel
echo "volumeicon &" >> ~/.config/lxsession/LXDE/autostart

# Adiciona a tarefa ao crontab do root
(crontab -l 2>/dev/null; echo "5 * * * * /usr/bin/apt update && /usr/bin/apt upgrade -y && /usr/bin/apt full-upgrade -y") | crontab -

# Finaliza a instalação
echo "Instalação concluída.
