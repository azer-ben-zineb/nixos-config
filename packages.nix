# Comprehensive Development Packages Configuration
# Full-stack development: Rust, Go, Python, C++, Java, JavaScript, SQL

{ config, pkgs, lib, ... }:

let
  # Proper JavaFX-enabled JDK using override
  javaWithFX = pkgs.openjdk21.override {
    enableJavaFX = true;
    openjfx_jdk = pkgs.openjfx21;
  };
in
{
  # Allow insecure packages if needed
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    # ==========================================
    # CORE SYSTEM UTILITIES
    # ==========================================
    wget git neovim nano
    bottom tree
    unzip zip gnutar gzip unrar
    rsync rclone
    obs-studio
    google-chrome
    gimp3
    rPackages.affinity

    # ==========================================
    # DEVELOPMENT TOOLS BY LANGUAGE
    # ==========================================

    # Rust Development
    rustc cargo rustfmt rust-analyzer clippy

    # Go Development
    go gopls golangci-lint delve

    # Python Development
    (python3.withPackages(ps: with ps; [
      pip setuptools wheel virtualenv
      numpy matplotlib pandas scipy
      jupyter notebook jupyterlab
      black flake8 pytest sphinx
      requests httpie
      pyyaml argcomplete
    ]))

    # C++ Development
    gcc clang gnumake cmake ninja meson
    gdb valgrind lldb
    autoconf automake libtool pkg-config

    # Java Development with JavaFX
    javaWithFX
    maven
    gradle_8
    scenebuilder

    # ==========================================
    # DEVELOPMENT ENVIRONMENTS & EDITORS
    # ==========================================
    vscode
    jetbrains.idea-community-bin

    # ==========================================
    # DATABASE TOOLS
    # ==========================================
    sqlite postgresql mysql80
    dbeaver-bin
    pgadmin4

    # ==========================================
    # VERSION CONTROL & CODE QUALITY
    # ==========================================
    git gitui lazygit
    nodePackages.prettier
    nodePackages.eslint

    # ==========================================
    # BUILD TOOLS & CONTAINERIZATION
    # ==========================================
    docker docker-compose

    # ==========================================
    # NETWORK & SYSTEM TOOLS
    # ==========================================
    networkmanager networkmanager-openvpn
    curl wget
    nmap netcat-gnu
    lshw pciutils usbutils

    # ==========================================
    # TERMINAL & SHELL TOOLS
    # ==========================================
    alacritty tmux
    zsh

    # ==========================================
    # APPLICATIONS
    # ==========================================
    firefox
    vlc
    libreoffice
    discord
    bitwarden

    # ==========================================
    # SYSTEM MONITORING & UTILITIES
    # ==========================================
    neofetch fastfetch
    pavucontrol pamixer
    brightnessctl
    bluez bluez-tools

    # ==========================================
    # DEVELOPMENT UTILITIES
    # ==========================================
    postman insomnia
    doxygen
    mdbook
    jq yq
    awscli2 terraform
    wl-clipboard
    lshw pciutils usbutils
    intel-gpu-tools

    # ==========================================
    # FONTS & THEMES
    # ==========================================
    font-awesome
    catppuccin-kde
    papirus-icon-theme

    # ==========================================
    # SECURITY & PRIVACY
    # ==========================================
    gnupg pass

    # ==========================================
    # SYSTEM UTILITIES
    # ==========================================
    bleachbit
    timeshift
    stress-ng

    # JavaScript Development
    nodejs nodePackages.npm nodePackages.yarn
    nodePackages.live-server nodePackages.http-server
    nodePackages.typescript nodePackages.ts-node
  ];

  # ==========================================
  # ENVIRONMENT VARIABLES
  # ==========================================
  environment.sessionVariables = {
    # Development
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";

    # Rust
    CARGO_HOME = "$HOME/.cargo";
    RUSTUP_HOME = "$HOME/.rustup";

    # Go
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";

    # Node.js
    NODE_PATH = "$HOME/.npm-global/lib/node_modules";

    # Python
    PYTHONPATH = "/run/current-system/sw/lib/python3.12/site-packages";

    # Java - Point to JavaFX-enabled JDK
    JAVA_HOME = "${javaWithFX}";

    # Intel graphics
    LIBVA_DRIVER_NAME = "iHD";
  };

  # JavaFX module paths for easy access
  environment.shellAliases = {
    javafx-compile = "javac --module-path ${javaWithFX}/lib/openjfx --add-modules javafx.controls,javafx.fxml";
    javafx-run = "java --module-path ${javaWithFX}/lib/openjfx --add-modules javafx.controls,javafx.fxml";
  };
}
