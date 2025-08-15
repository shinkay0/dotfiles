# Dotfiles & Nix System Configuration

This repository contains personal dotfiles and system configuration managed with [Nix](https://nixos.org/) and Nix Flakes. It provides reproducible setups for development environments, editor configurations, system services, and more.

## Features
- **Nix Flake**: Declarative system and user configuration
- **Editor Configs**: Helix editor customizations
- **Service Management**: Docker, Caddy, Firewall, K3s
- **Host Profiles**: Per-host configuration (e.g., nova)
- **Modular Structure**: Easily extendable modules for programs and services

## Directory Structure
```
flake.nix           # Nix flake entry point
dotfiles/
├── config/         # Editor and tool configs
│   └── helix/      # Helix editor config
├── home/           # Home-manager configs
├── hosts/          # Host-specific configs
├── modules/        # Modular Nix configs (programs, services)
├── pkgs/           # Custom Nix packages
└── nova/           # Example host (docker, caddy, nix)
```

## Getting Started
### Prerequisites
- [Nix](https://nixos.org/download.html) (with Flakes enabled)

### Clone and Apply
```sh
# Clone the repo
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Build or apply a host configuration (example: nova)
nix build .#nova
# or for home-manager
nix run .#homeConfigurations.yourUser.activationPackage
```

### Using Home Manager
This repo supports [Home Manager](https://nix-community.github.io/home-manager/). See `home/` for user-level configs.

## Customization
- Edit configs in `config/` for editors and tools
- Add or modify modules in `modules/`
- Define new hosts in `hosts/`

## Contributing
Pull requests and suggestions are welcome! Please open an issue for major changes.

## Cert-Manager

```bash
helm install \
  cert-manager oci://quay.io/jetstack/charts/cert-manager \
  --version v1.18.2 \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true
```

## AgoCD

```bash
helm install argocd argo/argo-cd --version 8.3.0 \
  -f k8s/argocd/values.yaml \
  --namespace argocd \
  --create-namespace 
```

```bash
kubectl port-forward service/argocd-server -n argocd 8080:443
```

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d
```

## License
MIT

