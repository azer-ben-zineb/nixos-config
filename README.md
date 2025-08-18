# 🐧 NixOS Configuration - KDE Plasma 6 Development Setup

Professional NixOS configuration optimized for full-stack development with KDE Plasma 6, Intel hardware optimizations, and modern development tools.

![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![KDE](https://img.shields.io/badge/KDE-1D99F3?style=for-the-badge&logo=kde&logoColor=white)

## ✨ Features

### 🖥️ Desktop Environment
- **KDE Plasma 6** with Wayland support
- **SDDM** display manager with Wayland
- **Blur effects** and compositor optimizations
- **Intel graphics** hardware acceleration

### 🛠️ Development Stack
- **Rust**: cargo, rust-analyzer, clippy
- **Go**: gopls, golangci-lint, delve
- **Python**: Full scientific stack with Jupyter
- **C/C++**: GCC, Clang, GDB, Valgrind
- **Java**: OpenJDK 21, Maven, Gradle
- **JavaScript**: Node.js, npm, TypeScript
- **Databases**: PostgreSQL, MySQL, SQLite
- **Containerization**: Docker, Docker Compose

### ⚡ System Optimizations
- **Intel CPU/GPU optimizations**
- **Power management** for laptops
- **SSD optimizations** with fstrim
- **Modern kernel** with performance tweaks
- **Nix flakes** and garbage collection

## 🚀 Quick Installation

### Prerequisites
- Fresh NixOS installation
- Git installed
- Admin access

### One-Command Install
```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/nixos-config/main/install.sh | bash
```

### Manual Installation
```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/nixos-config.git
cd nixos-config

# Backup existing config
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup

# Copy configurations
sudo cp configuration.nix /etc/nixos/
sudo cp packages.nix /etc/nixos/
sudo cp hardware-configuration.nix /etc/nixos/  # Optional: use your own

# Apply configuration
sudo nixos-rebuild switch

# Reboot
sudo reboot
```


## ⚙️ Configuration Highlights
<img width="1920" height="1080" alt="Screenshot_20250818_055823" src="https://github.com/user-attachments/assets/bfa917eb-287f-41fd-abac-88e8492499ea" />
<img width="1920" height="977" alt="Screenshot_20250818_055543" src="https://github.com/user-attachments/assets/e966f5d2-e97b-4075-8724-10f8f2d18561" />



### Development Environment
- **200+ packages** for full-stack development
- **Automatic LSP servers** installation
- **Container development** with Docker
- **Database tools** and GUIs
- **Cloud development** tools (AWS, Terraform)

## 🎯 Target Use Cases

- **Full-stack developers** needing multi-language support
- **System administrators** wanting modern NixOS setup
- **Students** learning development on Linux
- **Anyone** wanting a professional NixOS configuration

## 🔧 Customization

### Adding Packages
Edit `packages.nix` and add to `environment.systemPackages`:
```nix
environment.systemPackages = with pkgs; [
  # Add your packages here
  your-package
];
```

### Modifying Services
Edit `configuration.nix` services section:
```nix
services = {
  # Add or modify services
  your-service.enable = true;
};
```

### Hardware Specific
Replace `hardware-configuration.nix` with your own:
```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

## 📦 Included Packages

### Development Tools
- **Editors**: VS Code, Neovim, Nano
- **Version Control**: Git, GitUI, Lazygit
- **Databases**: DBeaver, pgAdmin4
- **Containers**: Docker, Docker Compose
- **Cloud**: AWS CLI, Terraform

### System Utilities
- **Terminal**: Alacritty, Tmux
- **File Management**: Built-in KDE tools
- **Monitoring**: htop, bottom, neofetch
- **Network**: NetworkManager, curl, wget

### Media & Productivity
- **Browser**: Firefox
- **Media**: VLC
- **Office**: LibreOffice
- **Communication**: Discord
- **Password**: Bitwarden

## 🛠️ Maintenance

### Update System
```bash
./update.sh
# Or manually:
sudo nixos-rebuild switch --upgrade
```

### Clean Old Generations
```bash
sudo nix-collect-garbage -d
sudo nixos-rebuild switch
```

### Rollback if Issues
```bash
sudo nixos-rebuild switch --rollback
```

## 🤝 Related Projects

- **[Neovim Config](https://github.com/azer-ben-zineb/nvim-config)** - My transparent Neovim setup

## 📋 Requirements

- **NixOS 24.05+** (tested on 24.11)
- **4GB+ RAM** (8GB recommended for development)
- **20GB+ storage** (packages can be large)
- **Intel CPU/GPU** (optimized for, but works on others)

## 🛡️ Security Features

- **Firewall** enabled by default
- **SSH** with key-only authentication
- **Secure boot** compatible
- **Regular updates** with automatic garbage collection

## 🆘 Troubleshooting

### Common Issues
1. **Build failures**: Check `nixos-rebuild --show-trace`
2. **Graphics issues**: Verify Intel drivers in `hardware.graphics`
3. **Package conflicts**: Run `nix-collect-garbage -d`

### Getting Help
- Check `docs/troubleshooting.md`
- Open an issue on GitHub
- Join NixOS Discord/Matrix

## 🙏 Acknowledgments

- [NixOS Community](https://nixos.org/)
- [KDE Team](https://kde.org/)
- Contributors and testers

---

⭐ **Star this repo if it helped you set up NixOS!**

🔗 **Check out my [Neovim configuration](https://github.com/azer-ben-zineb/nvim-config) for the perfect editor companion!**
