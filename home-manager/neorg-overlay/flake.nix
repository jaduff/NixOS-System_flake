{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };
  outputs = { self, nixpkgs, home-manager, neorg, ... }: {
    nixosConfigurations.machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ neorg-overlay.overlays.default ];
          home-manager.users.jaduff = {
            programs.neovim = {
              enable = true;
              plugins = with pkgs.vimPlugins; [
                neorg

                # optional
                neorg-telescope

                # optional — only if you want additional grammars besides norg and
                # norg_meta, otherwise auto-required.
                #
                # N.b.: Don't use plain nvim-treesitter as it would result in no
                # grammars getting installed, always the withPlugins function.
                # The minimal form is nvim-treesitter.withPlugins (_: [ ]) — the norg
                # grammars are added automatically.
                #
                # For all available grammars, nvim-treesitter.withAllGrammars or the
                # equivalent nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars)
                # can be used.
                (nvim-treesitter.withPlugins (p: with p; [
                  # Keep calm and don't :TSInstall
                  tree-sitter-lua
                ]))
              ];
              extraConfig = ''
                lua << EOF
                  require("nvim-treesitter.configs").setup {
                    highlight = {
                      enable = true,
                    }
                  }

                  require("neorg").setup {
                    load = {
                      ["core.defaults"] = {}
                    }
                  }
                EOF
              '';
            };
          };
        }
      ];
    };
  };
}
