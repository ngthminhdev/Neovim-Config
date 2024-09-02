-- init.lua for Neovim in VSCode

local map = vim.keymap.set
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.foldlevel = 20
-- Insert Mode
map("i", "<C-h>", "<C-o>h", { desc = "Move left" })
map("i", "<C-l>", "<C-o>l", { desc = "Move right" })
map("i", "<C-j>", "<C-o>j", { desc = "Move down" })
map("i", "<C-k>", "<C-o>k", { desc = "Move up" })

-- Normal Mode - Window Management
map("n", "<Bar>", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

map("n", "<C-b>", "<Cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>", { desc = "Toggle breakpoint" })

map("n", "<A-.>", "<cmd>tabnext<CR>", { desc = "Tab next" })
map("n", "<leader>l", "<C-w>l", { desc = "Switch window right" })
map("n", "<leader>j", "<C-w>j", { desc = "Switch window down" })
map("n", "<leader>k", "<C-w>k", { desc = "Switch window up" })

-- Kiểm tra xem đang chạy trong VSCode hay không
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

local function configure_hop()
  local hop = require('hop')
  hop.setup()

  local directions = require('hop.hint').HintDirection

  vim.keymap.set('n', '<leader>s', function()
    hop.hint_char1({ current_line_only = false })
  end, { silent = true, noremap = true, desc = "Hop to character" })
end
  -- Cấu hình các plugin
  require("lazy").setup({
    -- Các plugin cần thiết
    "tpope/vim-repeat",
  {
    "phaazon/hop.nvim",
    lazy = false,
    branch = "v2",
    config = configure_hop,
  },
    {
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()
      end,
    },
    {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup()
      end,
    },
    {
      "echasnovski/mini.ai",
      config = function()
        require("mini.ai").setup()
      end,
    },
    {
      "echasnovski/mini.pairs",
      config = function()
        require("mini.pairs").setup()
      end,
    },
    {
      "echasnovski/mini.surround",
      config = function()
        require("mini.surround").setup()
      end,
    },
    {
      "gbprod/yanky.nvim",
      config = function()
        require("yanky").setup()
      end,
    },
    {
      'vscode-neovim/vscode-multi-cursor.nvim',
      cond = not not vim.g.vscode,
      event = 'VeryLazy',
      opts = {},
      config = function()
      require('vscode-multi-cursor').setup {
        default_mappings = true,
        -- no_selection = true,
        keymaps = {
          -- Tạo cursor không có selection
          ['mi'] = {
            method = require('vscode-multi-cursor').add_cursor,
            opts = { no_select = true }
          },
          ['ma'] = {
            method = require('vscode-multi-cursor').add_cursor,
            opts = { no_select = true }
          },

          -- Tạo cursor có selection
          ['mI'] = {
            method = require('vscode-multi-cursor').add_cursor,
            opts = { no_select = false }
          },
          ['mA'] = {
            method = require('vscode-multi-cursor').add_cursor,
            opts = { no_select = false }
          },
        },
      }
      end,
    },
  })

vim.keymap.set('n', '<C-n>', 'mciw*<Cmd>nohl<CR>', { remap = true })
