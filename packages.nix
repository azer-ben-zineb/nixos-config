# Comprehensive Development Packages Configuration
# Full-stack development: Rust, Go, Python, C++, Java, JavaScript, SQL

{ config, pkgs, ... }:

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
    # ==========================================
    # DEVELOPMENT TOOLS BY LANGUAGE
    # ==========================================

    # Rust Development
    rustc cargo rustfmt rust-analyzer clippy

    # Go Development
    go gopls golangci-lint delve

    # Python Development - Using withPackages for automatic dependency resolution
    (python3.withPackages(ps: with ps; [
      # Core packages
      pip setuptools wheel virtualenv

      # Scientific computing
      numpy matplotlib pandas scipy

      # Jupyter ecosystem
      jupyter notebook jupyterlab

      # Development tools
      black flake8 pytest sphinx

      # Web and networking
      requests httpie

      # Data formats
      pyyaml
      # Add this for YQ:
      argcomplete
      # All dependencies are automatically included!
    ]))

    # C++ Development
    gcc clang gnumake cmake ninja meson
    gdb valgrind lldb
    autoconf automake libtool pkg-config

    # Java Development
    openjdk21 maven gradle
    pkgs.jdk
    # JavaScript Development
    nodejs nodePackages.npm nodePackages.yarn
    nodePackages.live-server nodePackages.http-server
    nodePackages.typescript nodePackages.ts-node

    # ==========================================
    # DEVELOPMENT ENVIRONMENTS & EDITORS
    # ==========================================
    vscode                          # Universal IDE
    jetbrains.idea-community        # Java development
    # ==========================================
    # DATABASE TOOLS
    # ==========================================
    sqlite postgresql mysql80
    dbeaver-bin                     # Universal database GUI
    pgadmin4                        # PostgreSQL admin

    # ==========================================
    # VERSION CONTROL & CODE QUALITY
    # ==========================================
    git gitui lazygit               # Git tools
    nodePackages.prettier           # Code formatter
    nodePackages.eslint             # JavaScript linter

    # ==========================================
    # BUILD TOOLS & CONTAINERIZATION
    # ==========================================
    docker docker-compose
    # ==========================================
    # NETWORK & SYSTEM TOOLS
    # ==========================================
    networkmanager networkmanager-openvpn
    curl wget  # Removed httpie since it's now in Python packages
    nmap netcat-gnu
    lshw pciutils usbutils

    # ==========================================
    # TERMINAL & SHELL TOOLS
    # ==========================================
    alacritty tmux
    zsh               # Modern shell prompt

    # ==========================================
    # FILE MANAGEMENT
    # ==========================================
                          # Terminal file managers

    # ==========================================
    # APPLICATIONS
    # ==========================================

    # Browsers
    firefox

    # Media
    vlc

    # Graphics & Design

    # Office & Productivity
    libreoffice

    # Communication
    discord

    # Password Management
    bitwarden

    # ==========================================
    # SYSTEM MONITORING & UTILITIES
    # ==========================================
    neofetch fastfetch
    pavucontrol pamixer             # Audio control
    brightnessctl                   # Brightness control
    bluez bluez-tools               # Bluetooth

    # ==========================================
    # DEVELOPMENT UTILITIES
    # ==========================================

    # API Testing
    postman insomnia

    # Documentation
    doxygen                        # C++ docs
    mdbook                         # Rust docs

    # JSON/YAML tools
    jq yq

    # Cloud tools
    awscli2 terraform
    # Clipboard
    wl-clipboard

    # Hardware info
    lshw pciutils usbutils

    # Intel graphics tools
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
    bleachbit                      # System cleaner
    timeshift                      # System backup

    # Intel graphics tools
    intel-gpu-tools

    # Performance monitoring
    stress-ng                      # System stress testing
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

    # Java
    JAVA_HOME = "${pkgs.openjdk21}";

    # Intel graphics
    LIBVA_DRIVER_NAME = "iHD";
  };
}
