{ modulesPath, lib, ... }:
{
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  boot.loader.grub.device = "/dev/vda";
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = { device = "/dev/vda1"; fsType = "ext4"; };

  networking = {
    nameservers = [ "67.207.67.3" "67.207.67.2" ];
    defaultGateway = "161.35.96.1";
    defaultGateway6 = "2604:a880:400:d0::1";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [{ address="161.35.100.187"; prefixLength=20; } { address="10.10.0.5"; prefixLength=16; }];
        ipv6.addresses = [{ address="2604:a880:400:d0::23:8001"; prefixLength=64; } { address="fe80::2ccf:67ff:fe03:6d48"; prefixLength=64; }];
        ipv4.routes = [{ address = "161.35.96.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "2604:a880:400:d0::1"; prefixLength = 128; }];
      };
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="2e:cf:67:03:6d:48", NAME="eth0"
    ATTR{address}=="0e:3d:2f:af:ea:7c", NAME="eth1"
  '';

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpWF/CahaYfT8299wOZhEvcGL7PCWO0HKGHdIZrOxRDdOOXbcHOylPdeuIOATj/UGRQGOwVLcVtJM8//jK7A/U2ngkQ1vm0bwy2sju61JRW4rtHrVOyIqDuNF2slbZjCG8Chwur/1NEr/oPPq1oOWgSmiz5fKE0p7uIHgloEE1sj3rJbiFXZe+u0Jaj7Hwu1OngpSULcXhb7ASiddm84ypBspiC75WXIM/85pwEHUFqcqqJ3jAqi0AMFQU3T/odmvXRi35Boua3w24SkUUAc7zZNvhtXNpD7KyTVWLyCwwtO85tiidWUybOPwofJ4/6dQ6Qi/9p2j3ZSnohdI9oEhRq+a7BQiU+T13hsIOeD18Z91k/kzg9vIgAnttD3C7ztLyGjQdN+pnPv4v2axZoqwkoygh/S/jBtT3+Ez16I7/IAl9vjeFK5RQLnm00QesadQKcYc8ZfK92MKlQ1Pl4e13H5QYHirTVcHKEXzvGp6A9RiaKRVoRowVFBsQ/EjkZeIQz3WGPH+fbZh3ON3wWzZbUo36o7plazP1Ge97A0vcqNLfmau7nDocTpYkWaFnrjDK0HPxATMrIURKDjCBAYK521x9TKQT4XO6kkGsUP87eNfpkAeHhRewNT7S+Qqc6wJhI+HEBBdZapTxxEGlcwt3dRB7izD5cKuNxq5TUp9Q2w==" 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIe/jjHus5bAaW1jfHWYFKbDBgP12XXSJTxIt5dCvloI christine@MacBook-Pro.local" 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINF7D2PMhBWTAtd8Boymc6LZDbivUTYKwPFfp9xz25i1 jake@ipad"
  ];
  
}
