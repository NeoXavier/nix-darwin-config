{pkgs, ...}: {
  plugins = {
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = {ghost_text = true;};
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet.expand = "function(args)
              require('luasnip').lsp_expand(args.body)
          end";
        mapping = {
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-n>" = "cmp.mapping.select_next_item({behavior = cmp.ConfirmBehavior.Insert})";
          "<C-p>" = "cmp.mapping.select_prev_item({behavior = cmp.ConfirmBehavior.Insert})";
          "<C-space>" = "cmp.mapping.complete()";
          "<C-y>" = "cmp.mapping.confirm({select = true, behavior = cmp.ConfirmBehavior.Insert })";
        };
        window.documentation.border = [
          "╭"
          "─"
          "╮"
          "│"
          "╯"
          "─"
          "╰"
          "│"
        ];
        sources = [
          {name = "nvim_lsp";}
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          {name = "nvim_lua";}
          # {name = "cmdline";}
          {name = "path";}
          {
            name = "luasnip";
            keywordLength = 3;
          }
        ];
      };
    };
    cmp-buffer.enable = true;
    cmp-nvim-lsp.enable = true; #lsp
    cmp-nvim-lua.enable = true;
    cmp-cmdline.enable = true; # autocomplete for cmdline
    cmp-path.enable = true; # file system paths
    luasnip = {
      enable = true;
      extraConfig = {
        history = true;
        updateevents = "TextChanged,TextChangedI";
        enable_autosnippets = true;
      };
    }; # snippets
    friendly-snippets.enable = true;
  };
  extraConfigLua = ''
    -- Extra options for cmp-cmdline setup
    local cmp = require("cmp")
    cmp.setup.cmdline(":", {
    	mapping = cmp.mapping.preset.cmdline(),
    	sources = cmp.config.sources({
    		{ name = "path" },
    	}, {
    		{
    			name = "cmdline",
    			option = {
    				ignore_cmds = { "Man", "!" },
    			},
    		},
    	}),
    })
  '';
  plugins.lspkind = {
    enable = true;
    symbolMap = {
      Copilot = "";
    };
    extraOptions = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };
}
