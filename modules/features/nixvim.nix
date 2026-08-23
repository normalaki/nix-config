{ self, inputs, ... }: {
  
  flake.nixosModules.nixvim = { pkgs, ... }: {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];

    programs.nixvim = {
      enable = true;
      colorschemes.gruvbox = {
        enable = true;
        #settings.style = "moon";
      };

      globals.mapleader = " ";
      opts = {
        number = true;
        relativenumber = true;
        clipboard = "unnamedplus";
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
      };

      plugins = {
        bufferline.enable = true;
        lualine.enable = true;
        noice.enable = true;
        notify.enable = true;
        which-key.enable = true;
        indent-blankline.enable = true;

        neo-tree.enable = true;
        telescope.enable = true;

        treesitter = {
          enable = true;
        };

        cmp = {
          enable = true;
          settings.sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };

        lsp = {
          enable = true;
          servers = {
            lua_ls.enable = true;
            pyright.enable = true; # python
            solargraph.enable = true; # ruby
          };
        };

        conform-nvim.enable = true;
        gitsigns.enable = true;
      };
    };
  };
}
