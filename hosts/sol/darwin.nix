{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Essential packages
    curl
    git
    wget
    vim
    htop
    
    # Development tools
    direnv
    jq
    
    # Modern CLI tools
    eza
    bat
    fd
    ripgrep
    fzf
    delta
  ];

  # Homebrew integration (for GUI apps not available in nixpkgs)
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "1password"
      "raycast"
    ];
  };

  # Disable nix-darwin's Nix management (using Determinate Nix)
  nix.enable = false;
  
  # Disable PAM management to avoid permission issues
  security.pam.services.sudo_local.touchIdAuth = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set the primary user
  system.primaryUser = "shin";
  
  # macOS system settings
  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        minimize-to-application = true;
      };
      
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
    };
    
    # Set macOS version (this should match your current macOS version)
    stateVersion = 4;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;
}
