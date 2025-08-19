{ pkgs, ... }:

{
  imports = [
    ../../../modules/services/k3s.nix
    ../../../modules/services/docker.nix
    ../../../modules/services/firewall.nix
  ];

  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nova";

  environment.systemPackages = (import ./packages.nix) { inherit pkgs; };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "ext4";
  };
/*  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];*/

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fr";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
    "ext4"
  ];

  users.users = {
    root.hashedPassword = "!";
    shin = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKGoMmLFGcsjonbiisgNCPRSDZbp5aNsuEOKeURKNAa"
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  virtualisation.docker.enable = true;

  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
