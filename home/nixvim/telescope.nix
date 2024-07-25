{ pkgs, ... }: {
  plugins.telescope = {
    enable = true;
    # settings = {
    #   defaults = {
    #     file_sorter.__raw = "require ('telescope.sorters').get_fzy_sorter";
    #     prompt_prefix = " >";
    #     color_devicons = true;
    #     file_previewer.__raw = "require (''telescope.previewers').vim_buffer_cat.new";
    #     grep_previewer.__raw = "require ('telescope.previewers').vim_buffer_vimgrep.new";
    #     qflist_previewer.__raw = "require ('telescope.previewers').vim_buffer_qflist.new";
    #     mappings = {
    #       i = {
    #         "<C-x>" = false;
    #         "<C-q>".__raw = "require('telescope.actions').send_to_qflist";
    #         "<CR>".__raw = "require('telescope.actions').select_default";
    #         "<C-t>".__raw = "require('trouble.sources.telescope').open";
    #       };
    #       n = { "<C-t>".__raw = "require('trouble.sources.telescope').open"; };
    #     };
    #   };
    # };
    keymaps = {
      "<leader>?" = {
        action = "oldfiles";
        options.desc = "[?] Find recently opened files";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "[F]ind existing [B]uffers";
      };
      "<leader>/" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "[/] Fuzzily search in current buffer]";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "[f]find [f]iles";
      };
      "<leader>sh" = {
        action = "help_tags";
        options.desc = "[s]earch [h]elp";
      };
      "<leader>sw" = {
        action = "grep_string";
        options.desc = "[s]earch current [w]ord";
      };
      "<leader>lg" = {
        action = "live_grep";
        options.desc = "[l]ive [g]rep";
      };
      "<leader>sd" = {
        action = "diagnostics";
        options.desc = "[s]earch [d]iagnotics";
      };
      "<leader>sk" = {
        action = "keymaps";
        options.desc = "[s]earch [k]eymaps";
      };
    };
  };
}
