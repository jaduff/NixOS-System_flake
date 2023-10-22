# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, nixpkgs-unstable, ... }:

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

programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  home.packages = with pkgs; [
    calibre
    unstable.anytype
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
    skypeforlinux
    kdeconnect
    kate
    ripgrep
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    nodePackages.javascript-typescript-langserver
    sqlite
    editorconfig-core-c
    emacs-all-the-icons-fonts
    kdenlive
    mediainfo
    glaxnimate
    hexchat
    kcalc
    unstable.netcoredbg
     (unstable.vscode-with-extensions.override {
    vscodeExtensions = with unstable.vscode-extensions; [
      unstable.vscode-extensions.ms-dotnettools.csharp
      unstable.vscode-extensions.ms-azuretools.vscode-docker
      unstable.vscode-extensions.ms-dotnettools.csharp
      ];   })

  ];
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

home = {
    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom-config";
      DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "emacs" = {
        source = builtins.fetchGit {
		url = "https://github.com/hlissner/doom-emacs";
		rev = "986398504d09e585c7d1a8d73a6394024fe6f164";
		};
        onChange = "${pkgs.writeShellScript "doom-change" ''
          export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
          export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
          if [ ! -d "$DOOMLOCALDIR" ]; then
            ${config.xdg.configHome}/emacs/bin/doom install
          else
            ${config.xdg.configHome}/emacs/bin/doom sync -u
          fi
        ''}";
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
