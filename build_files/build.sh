#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux 

dnf5 remove gnome-\*

# Base Packages
PACKAGES=(
    bibata-cursor-themes
    papirus-icon-theme
    mpv
    keyd
    gnome-keyring-pam
    NetworkManager-tui
    NetworkManager-openvpn
    xdg-user-dirs
)



dnf5 group install -y cosmic-desktop

dnf install -y --allowerasing \
    --setopt=install_weak_deps=False \
    -x bluefin-readymade-config \
    "${PACKAGES[@]}"

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

#systemctl enable podman.socket

systemctl disable gdm && \
systemctl disable sddm && \
systemctl enable cosmic-greeter