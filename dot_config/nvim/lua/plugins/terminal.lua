return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- サイズ
        size = 20,
        -- 開閉のショートカットキー (Ctrl + @) に変更
        open_mapping = [[<C-@>]],
        -- "horizontal" (下), "vertical" (横/右), "float" (浮遊), "tab" (タブ)
        direction = "horizontal", 
        
        -- ターミナルモードでのキー設定
        on_open = function(term)
          -- Esc でターミナルモードから抜ける設定
          vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = term.bufnr })
          -- jk で抜ける設定も追加（お好みで）
          vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { buffer = term.bufnr })
        end,
      })
    end
  }
}
