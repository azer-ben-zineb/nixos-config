# Optimized NixOS KDE Plasma Configuration
# Full-stack development setup with hardware optimizations

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Core system libraries
    stdenv.cc.cc.lib
    glibc
    zlib

    # Common libraries that many programs need
    icu
    openssl
    curl
    expat

    # X11 libraries (needed for Java GUI applications)
    xorg.libX11
    xorg.libXext
    xorg.libXtst
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXrender
    xorg.libXi
    xorg.libXcomposite

    # Graphics
    libGL

    # Font rendering (important for IDEs)
    fontconfig
    freetype

    # GTK libraries
    gtk3
    cairo
    pango
    atk
    gdk-pixbuf

    # Audio
    alsa-lib

    # Add specific libraries your programs need
  ];

# Boot Configuration with optimizations
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    kernelPackages = pkgs.linuxPackages_latest;

    # Intel and performance optimizations
    kernelParams = [
      "intel_pstate=active"      # Better CPU power management
      "i915.enable_fbc=1"        # Frame buffer compression for Intel graphics
      "i915.enable_psr=1"        # Panel self refresh for better battery
      "quiet"                    # Cleaner boot
      "splash"
    ];
  };

  # Networking
  networking = {
    hostName = "nixos-azer";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # Set your time zone.
  time.timeZone = "Africa/Tunis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_TN.UTF-8";
    LC_IDENTIFICATION = "ar_TN.UTF-8";
    LC_MEASUREMENT = "ar_TN.UTF-8";
    LC_MONETARY = "ar_TN.UTF-8";
    LC_NAME = "ar_TN.UTF-8";
    LC_NUMERIC = "ar_TN.UTF-8";
    LC_PAPER = "ar_TN.UTF-8";
    LC_TELEPHONE = "ar_TN.UTF-8";
    LC_TIME = "ar_TN.UTF-8";
  };

  # Services
  services = {
    # Display Manager - Using SDDM for KDE
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Touchpad support
    libinput.enable = true;

    # Audio - PipeWire (better than PulseAudio)
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Bluetooth
    blueman.enable = true;

    # Printing
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Auto-mount USB devices
    udisks2.enable = true;

    # SSD optimization
    fstrim.enable = true;

    # Power management for laptops
    power-profiles-daemon.enable = true;

    # Firmware updates
    fwupd.enable = true;

    # SSH (useful for development)
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };

  users.users.azer = {
    isNormalUser = true;
    description = "azer";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # CPU and Power Management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";  # Better than "ondemand" for modern CPUs
  };

  # Hardware with Intel optimizations
  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver    # Hardware video acceleration
        vaapiIntel           # VA-API support for Intel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    # Intel firmware
    enableRedistributableFirmware = true;

    # Intel CPU microcode
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # Virtualization
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;  # For VMs if needed
  };

  environment.sessionVariables = {
    # Qt theming
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      # Base fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf

      # Programming fonts
      fira-code
      fira-code-symbols
      jetbrains-mono

      # Icon fonts
      font-awesome

      # Nerd fonts for terminal
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.sauce-code-pro
      nerd-fonts.ubuntu-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Fira Code" "JetBrains Mono" ];
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  # Programs
  programs = {
    # Dconf
    dconf.enable = true;

    # KDE Connect
    kdeconnect.enable = true;

    # Git - system-wide only enables the program
    git.enable = true;
  };

  # Nix Configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "azer" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Swap file (optional - 8GB for hibernation)
  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;  # 8GB swap file
    }
  ];

  # System Version
  system.stateVersion = "25.05";
}
