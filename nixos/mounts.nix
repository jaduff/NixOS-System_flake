# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:
{
fileSystems."/mnt/share" = {
      device = "//e4014s01sv001.indigo.schools.internal/fsschools";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=1000,gid=100";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
fileSystems."/mnt/rmms" = {
      device = "//e4014s01sv003.indigo.schools.internal/rmms";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=1000,gid=100";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
fileSystems."/mnt/staffshared" = {
      device = "//e4014s01sv019.indigo.schools.internal/staff shared";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=1000,gid=100";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
}

