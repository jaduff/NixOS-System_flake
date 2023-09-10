# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, nixpkgs-unstable, ... }:

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ./doom.d;  # Directory containing your config.el, init.el
                                # and packages.el files
  };
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "jaduff";
    homeDirectory = "/home/jaduff";
  };

  programs ={
    fish = {
      enable = true;
     };
   };
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.tmux = {
    enable=true;
    extraConfig = ''
      set -g default-shell /home/jaduff/.nix-profile/bin/fish
    '';
  };

  home.packages = with pkgs; [
    unstable.anytype
    doom-emacs
    emacsPackages.org-roam
    emacsPackages.org-roam-ui
    emacsPackages.ripgrep
    emacsPackages.all-the-icons
    emacs-all-the-icons-fonts
    vlc
    firefox
    lm_sensors
    cifs-utils
    iotop
    inetutils
    protonvpn-gui
    postgresql
    alacritty
    remmina
    oh-my-fish
    fish
    borgbackup
    vorta
    virt-manager
    htop-vim
    libreoffice
    protonvpn-gui
    telegram-desktop
    krita
    inkscape
    gimp
    librewolf
    nextcloud-client
    joplin-desktop
    zotero
    zettlr
    protonmail-bridge
    thunderbird
    espanso
    skypeforlinux
    kdeconnect
    kate
    ripgrep
  ]; 
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
