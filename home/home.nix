{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jaduff";
  home.homeDirectory = "/home/jaduff";
  
  imports = [ ./tmux.nix  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.emacs = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      neorg
      orgmode
    ];
  };
  home.file."./.config/nvim/" = {
     source = ./nvim;
     recursive = true;
   };
  programs.git = {
    enable = true;
    userName = "jaduff";
    userEmail = "jaduff@protonmail.com";
  };
  programs ={
  fish = {
      enable = true;
      shellAliases = {
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        mkdir = "mkdir -p";
      };
      shellAbbrs = {
        g = "git";
        m = "make";
        n = "nvim";
        o = "open";
        p = "python3";
      };
   };
   };
   home.packages = [
    pkgs.anytype
    pkgs.joplin-desktop
    pkgs.zotero
    pkgs.zettlr
    pkgs.protonmail-bridge
    pkgs.thunderbird
    pkgs.espanso
    pkgs.skypeforlinux
    pkgs.kdeconnect
    pkgs.kate
   ];

}
