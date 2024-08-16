local base = {
  { "lunarvim/colorschemes" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  "AckslD/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  -- "nvim-neotest/neotest",
  -- "nvim-neotest/neotest-python",
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 1 -- Change the value to 1 here
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
      "Glog"
    },
    ft = { "fugitive" }
  },
  { "sindrets/diffview.nvim" },
  { 'towolf/vim-helm',       ft = 'helm' },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^4',
  --   ft = { 'rust' },
  --   config = function()
  --   end,
  -- },
  {
    'dawsers/telescope-file-history.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require('file_history').setup {
        -- This is the location where it will create your file history repository
        backup_dir = "~/.file-history-git",
        -- command line to execute git
        git_cmd = "git"
      }
    end
  },
  {
    "tpope/vim-surround",
  },
  {
    "scalameta/nvim-metals",
    config = function()
      require("user.metals").config()
    end,
  },
}

lvim.plugins = base
