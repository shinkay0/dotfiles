{
  networking.firewall = {
    allowedTCPPorts = [
      80 443
      22
      6443
    ];
  };
}
