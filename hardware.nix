{
  modulesPath,
  lib,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  boot.loader.grub.device = "/dev/vda";
  boot.initrd.kernelModules = ["nvme"];
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  networking = {
    nameservers = ["67.207.67.3" "67.207.67.2"];
    defaultGateway = "161.35.96.1";
    defaultGateway6 = "2604:a880:400:d0::1";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "161.35.100.187";
            prefixLength = 20;
          }
          {
            address = "10.10.0.5";
            prefixLength = 16;
          }
        ];
        ipv6.addresses = [
          {
            address = "2604:a880:400:d0::23:8001";
            prefixLength = 64;
          }
          {
            address = "fe80::2ccf:67ff:fe03:6d48";
            prefixLength = 64;
          }
        ];
        ipv4.routes = [
          {
            address = "161.35.96.1";
            prefixLength = 32;
          }
        ];
        ipv6.routes = [
          {
            address = "2604:a880:400:d0::1";
            prefixLength = 128;
          }
        ];
      };
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="2e:cf:67:03:6d:48", NAME="eth0"
    ATTR{address}=="0e:3d:2f:af:ea:7c", NAME="eth1"
  '';
}
