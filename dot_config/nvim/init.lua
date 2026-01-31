-- Clipboard settings
vim.opt.clipboard = "unnamedplus"

-- Leader key (Space)
vim.g.mapleader = " "

-- Keymaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<Leader>ee", ":NvimTreeToggle<CR>")

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and load plugins from lua/plugins/
require("lazy").setup("plugins")

-- Mason & LSP Setup (configured after plugins are loaded)
-- Note: It's often better to put this in the plugin config or a separate file, 
-- but the article snippet puts it in init.lua or implies it runs after.
-- Since we are loading plugins via 'require("lazy").setup("plugins")', 
-- dependencies will be installed. We need to make sure this runs after mason is loaded.
-- However, 'require("lazy").setup' is synchronous in setup but installation is not.
-- The safe bet is to wrapping these in a way that they run, or just put them here 
-- assuming the user restarts nvim after first install.

-- Actually, looking at the article:
-- "require('mason').setup()" etc are listed in "init.lua" snippet.
-- So I will append them here.

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- These might fail if plugins aren't installed yet, but that's normal for first run
    pcall(function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers({
        function (server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })

      vim.diagnostic.config()
    end)
  end,
})
