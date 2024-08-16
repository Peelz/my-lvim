-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require('base.plugins')
reload('base.options')

require('custom.custom')

-- lsp install
lvim.lsp.installer.setup.ensure_installed = {
  "pyright", "jsonls", "yamlls", "bashls", "rust_analyzer",
}

-- lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "helm_ls" }
local pyright_opts = {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "basic",   -- off, basic, strict
        useLibraryCodeForTypes = true
      }
    }
  },
}

require("lvim.lsp.manager").setup("pyright", pyright_opts)
-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python", "rust"
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { command = "rustfmt" },
}
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.lua", "*.rs" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    name = "shellcheck",
    args = { "--serveriry", "warning" }
  }
}

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- pyenv
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    require('swenv.api').auto_venv()
  end
})
require('swenv').setup({

  -- Should return a list of tables with a `name` and a `path` entry each.
  -- Gets the argument `venvs_path` set below.
  -- By default just lists the entries in `venvs_path`.
  get_venvs = function(venvs_path)
    return require('swenv.api').get_venvs(venvs_path)
  end,
  -- Path passed to `get_venvs`.
  venvs_path = vim.fn.expand('~/venvs'),
  -- venvs_path = vim.fn.getcwd(),
  -- Something to do after setting an environment, for example call vim.cmd.LspRestart
  post_set_venv = function(venv)
    vim.cmd('LspRestart')
  end,
})

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  p = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
  c = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show current Env" },
}

-- always open nvim tree
lvim.builtin.nvimtree.on_config_done = function()
  require("nvim-tree.api").tree.toggle({ focus = false })
end

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "file_history")
end
