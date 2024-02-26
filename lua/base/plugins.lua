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
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
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
  { "scalameta/nvim-metals" },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^4',
  --   ft = { 'rust' },
  --   config = function()
  --   end,
  -- },
}

lvim.plugins = base
