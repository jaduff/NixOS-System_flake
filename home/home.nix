{ config, pkgs, ... }:

{
  home.username = "jaduff";
  home.homeDirectory = "/home/jaduff/";

  home-manager.useGlobalPkgs = true;
  home.stateVersion = "23.11";
  hone.packages = [
    pkgs.kdeconnect
    pkgs.kate
    pkgs.kcalc
    pkgs.joplin-desktop
    pkgs.zotero
    pkgs.zettlr
    pkgs.protonmail-bridge
    pkgs.thunderbird
    pkgs.anytype
    pkgs.espanso
    pkgs.skypeforlinux
  ];
  home.sessionVariables = {
	XDG_CURRENT_DESKTOP = "KDE";
  };
}
