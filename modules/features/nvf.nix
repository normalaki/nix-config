{ self, inputs, ... }: {

  flake.nixosModules.nvf = { pkgs, config, lib, ... }: {
    imports = [
      inputs.nvf.nixosModules.default
    ];

    programs.nvf = {
      enable = true;
      enableManpages = true;

      settings.vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        # Basic vim options
        opts.expandtab = true;

        spellcheck = {
          enable = true;
          programmingWordlist.enable = false; # Set to false (Default)
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true; # Enabled on non-maximal
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
          presets.harper.enable = false;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages active in the default configuration
          nix.enable = true;
          markdown.enable = true;

          # Maximal-only languages disabled cleanly below
          bash.enable = false;
          clang.enable = false;
          cmake.enable = false;
          css.enable = false;
          scss.enable = false;
          html.enable = false;
          json.enable = false;
          sql.enable = false;
          java.enable = false;
          kotlin.enable = false;
          typescript.enable = false;
          go.enable = false;
          lua.enable = false;
          zig.enable = false;
          python.enable = false;
          typst.enable = false;
          rust = {
            enable = false;
            extensions.rustaceanvim.enable = false;
            extensions.crates-nvim.enable = false;
          };
          toml.enable = false;
          xml.enable = false;
          tex.enable = false;
          docker.enable = false;
          env.enable = false;
          arduino.enable = false;
          assembly.enable = false;
          astro.enable = false;
          awk.enable = false;
          beancount.enable = false;
          csharp.enable = false;
          dart.enable = false;
          elixir.enable = false;
          fish.enable = false;
          fluent.enable = false;
          fsharp.enable = false;
          gettext.enable = false;
          gleam.enable = false;
          glsl.enable = false;
          haskell.enable = false;
          hcl.enable = false;
          jinja.enable = false;
          jq.enable = false;
          julia.enable = false;
          just.enable = false;
          liquid.enable = false;
          lisp.enable = false;
          make.enable = false;
          nu.enable = false;
          ocaml.enable = false;
          openscad.enable = false;
          pug.enable = false;
          qml.enable = false;
          r.enable = false;
          ruby.enable = false;
          scala.enable = false;
          standard-ml.enable = false;
          svelte.enable = false;
          tera.enable = false;
          tsx.enable = false;
          twig.enable = false;
          vala.enable = false;
          vue.enable = false;
          zsh.enable = false;
          http.enable = false;
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          blink-indent.enable = true;
          indent-blankline.enable = true;
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        # Uses standard cmp framework for fast startup without Rust builds
        autocomplete = {
          nvim-cmp.enable = true;
          blink-cmp.enable = false;
        };

        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = false;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false;
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = false;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = false;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          qmk-nvim.enable = false;
          icon-picker.enable = false;
          surround.enable = false;
          leetcode-nvim.enable = false;
          multicursors.enable = false;
          smart-splits.enable = false;
          undotree.enable = false;
          nvim-biscuits.enable = false;
          grug-far-nvim.enable = false;

          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = false;
          };
        };

        notes = {
          neorg.enable = false;
          orgmode.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false;
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = false;
          };
          codecompanion-nvim.enable = false;
          avante-nvim.enable = false;
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
          cord-nvim.enable = false;
        };
      };
    };
  };
}
