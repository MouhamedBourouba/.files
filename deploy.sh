ALL_PACKAGES=(
  # login manager
  ly

  # window manager
  i3-wm
  i3status
  alacritty

  # base develepment tools
  git
  base-devel
  
  # compilers
  gcc
  clang
  go
  nodejs

  # code editors
  code
  neovim

  # build tools 
  make
  cmake

  # gui tools
  lxappearance
  rofi
  flameshot
  pavucontrol
  telegram-desktop
  nemo

  # cli tools
  tmux
  xcolor
  feh
  zoxide
  stow
  fastfetch
  eza
  gdu
  fzf
  tokei
  unzip
  unrar
  entr
  btop
  wget
  
  # formmaters
  gopls
  prettier
  stylua
  
  # package managers
  pnpm
  
  # langage servers
  bash-language-server
  lua-language-server
  tailwindcss-language-server
  typescript-language-server
  vscode-css-languageserver
  vscode-html-languageserver
  vscode-json-languageserver
)

print_logo() {
  echo -e "\033[1;32m"
  cat <<'EOF'


   ██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗
   ██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝
   ██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝ 
   ██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝  
   ██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   
   ╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   
                                                  
                                                  
          🚀  SYSTEM SETUP IN PROGRESS  🚀
EOF
  echo -e "\033[0m"
}

print_title() {
  echo -e "\033[1;32m"
  echo "------------------------------------------------------------------"
  echo "$1"
  echo "------------------------------------------------------------------"
  echo -e "\033[0m"
}

install_yay() {
  if ! which yay &> /dev/null; then 
    print_title "intalling YAY aur helper"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay && (
    cd /tmp/yay 
    makepkg -si
    rm -rf ../yay)
  else
    print_title "YAY already installed"
  fi
}

install_package() {
  local pkg="$1"

  if ! pacman -Qi $pkg &> /dev/null; then 
    echo "Installing $pkg..."
    sudo pacman -S --noconfirm $pkg
  else
    echo "$pkg Already intalled"
  fi
}

install_all_packages() {
  print_title "Intalling pakages"
  for item in "${ALL_PACKAGES[@]}"; do
    install_package "$item"
  done
}

print_logo
install_yay
install_all_packages
