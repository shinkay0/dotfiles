{ config, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      #"--disable traefik"
      "--disable-cloud-controller"
      "--kubelet-arg=cloud-provider=external"
      "--write-kubeconfig-mode=0644"
      "--node-name=nova"
      # Add your public IP or DNS so kubeconfig works from your machine:
      "--tls-san=k8s.shacorp.fr"
    ];
  };
}