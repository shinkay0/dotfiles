# Dotfiles & Nix System Configuration

This repository contains personal dotfiles and system configuration managed with [Nix](https://nixos.org/) and Nix Flakes. It provides reproducible setups for development environments, editor configurations, system services, and more.

## Features
- **Nix Flake**: Declarative system and user configuration
- **Editor Configs**: Helix editor customizations
- **Service Management**: Docker, Caddy, Firewall, K3s
- **Host Profiles**: Per-host configuration (e.g., nova, sol)
- **Modular Structure**: Easily extendable modules for programs and services

## Directory Structure
```
flake.nix            # Nix flake entry point
config/              # Editor and tool configs
  helix/             # Helix editor config
hosts/               # Host-specific configs
  nova/              # NixOS host (docker, caddy, nix)
    nix/             # NixOS system configs
      configuration.nix
      packages.nix
    caddy/           # Caddy config
      Caddyfile
    docker-compose.yml
  sol/               # macOS host (nix-darwin, home-manager)
    darwin.nix       # macOS system config
    home.nix         # Home Manager config
k8s/                 # Kubernetes configs
modules/             # Modular Nix configs (programs, services)
  services/          # Service modules (docker, firewall, k3s)
pkgs/                # Custom Nix packages
```

## Getting Started
### Prerequisites
- [Nix](https://nixos.org/download.html) (with Flakes enabled)

### Clone and Apply
```sh
# Clone the repo
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Build or apply a NixOS host configuration (example: nova)
nix build .#nixosConfigurations.nova
# For macOS (nix-darwin)
nix build .#darwinConfigurations.sol
# For Home Manager (user-level config)
nix run .#homeConfigurations.shin@sol.activationPackage
```

### Using Home Manager
This repo supports [Home Manager](https://nix-community.github.io/home-manager/). See `hosts/sol/home.nix` for user-level configs.

## Customization
- Edit configs in `config/` for editors and tools
- Add or modify modules in `modules/`
- Define new hosts in `hosts/`

## Notes
- For macOS, use `darwinConfigurations` and Home Manager outputs.
- For NixOS, use `nixosConfigurations`.
- See each host's folder for specific configs and instructions.

## Contributing
Pull requests and suggestions are welcome! Please open an issue for major changes.
