{ pkgs, ... }:

let
  username = "shin";
in

{
  nixpkgs.config.allowUnfree = true;
  home.username = "${username}";
  home.homeDirectory = "/Users/${username}";

  home.packages = with pkgs; [
    helix
    nushell
    nodejs_24
    go gopls
    python313
    nil
    nixd
    lua-language-server
    kubectl kubernetes-helm
    d2
    docker-compose
    terraform
    ansible
    tree
    watch
    neofetch
    zellij
  ];

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      k = "kubectl";
      kgns = "k get ns";
      kgp = "k get pods";
      kgsv = "k get svc";
      ll = "eza --tree --level=1";
    };
    
    initContent = ''
      # Custom shell initialization
      export EDITOR="helix"
      
      # Add any additional shell configuration here
    '';
  };
  
  # Git configuration
  programs.git = {
    enable = true;
    userName = "shin";
    userEmail = "your-email@example.com"; # Update this with your email
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "current";
    };
  };
  
  # Direnv for automatic environment loading
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  
  # Modern terminal file manager
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };
  
  # Better cat alternative
  programs.bat = {
    enable = true;
    config = {
      theme = "";
      pager = "less -FR";
    };
  };
  
  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
