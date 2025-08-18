#!/usr/bin/env bash
set -e

echo "🚀 Installing NixOS Configuration..."

# Backup existing configurations
echo "📋 Creating backups..."
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup 2>/dev/null || true
sudo cp /etc/nixos/packages.nix /etc/nixos/packages.nix.backup 2>/dev/null || true

# Copy configurations
echo "⚙️  Copying configurations..."
sudo cp configuration.nix /etc/nixos/
sudo cp packages.nix /etc/nixos/

# Note about hardware config
echo "ℹ️  Don't forget to use your own hardware-configuration.nix!"

# Rebuild NixOS
echo "🔄 Rebuilding NixOS..."
sudo nixos-rebuild switch

echo "✅ Installation complete! Reboot recommended."
