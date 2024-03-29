# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "uas" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  services.fstrim.enable = true;
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3c230a1e-3f24-420c-9b86-717c0b32efec";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-66b893c5-ee6c-4be7-853e-a1ae8c0a1451".device = "/dev/disk/by-uuid/66b893c5-ee6c-4be7-853e-a1ae8c0a1451";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0928-4F10";
      fsType = "vfat";
    };

  swapDevices = 
    [ { device = "/dev/disk/by-uuid/e7036f89-c6e0-469f-be5d-be097ff2e4fe"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u1u4.useDHCP = lib.mkDefault true;
  # networking.interfaces.virbr0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
