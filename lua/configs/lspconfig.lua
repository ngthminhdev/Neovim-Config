-- lspconfig.lua
local M = {}

function M.defaults()
  local nvim_lsp = require('lspconfig')
  local cmp = require'cmp'
  
  -- Cấu hình nvim-cmp.
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<tab>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    },
  })

  -- Khả năng LSP cho nvim-cmp.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Hàm on_attach để cài đặt key mappings sau khi LSP được đính kèm vào buffer.
  local on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-i>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  end

  -- Cấu hình các LSP servers.
  local servers = { 'lua_ls', 'tsserver', 'clangd' }
  for _, lsp in ipairs(servers) do
    local config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if lsp == 'tsserver' then
      config.settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          }
        }
      }
    end

    nvim_lsp[lsp].setup(config)
  end
end

return M

-- local M = {}
-- local map = vim.keymap.set

-- -- export on_attach & capabilities
-- M.on_attach = function(_, bufnr)
--   local function opts(desc)
--     return { buffer = bufnr, desc = "LSP " .. desc }
--   end

--   map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
--   map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
--   map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
--   map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
--   map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
--   map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

--   map("n", "<leader>wl", function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, opts "List workspace folders")

--   map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

--   map("n", "<leader>ra", function()
--     require "nvchad.lsp.renamer"()
--   end, opts "NvRenamer")

--   map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
--   map("n", "gr", vim.lsp.buf.references, opts "Show references")
-- end

-- -- disable semanticTokens
-- M.on_init = function(client, _)
--   if client.supports_method "textDocument/semanticTokens" then
--     client.server_capabilities.semanticTokensProvider = nil
--   end
-- end

-- M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- M.capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }

-- M.defaults = function()
--   dofile(vim.g.base46_cache .. "lsp")
--   require "nvchad.lsp"

--   require("lspconfig").lua_ls.setup {
--     on_attach = M.on_attach,
--     capabilities = M.capabilities,
--     on_init = M.on_init,

--     settings = {
--       Lua = {
--         diagnostics = {
--           globals = { "vim" },
--         },
--         workspace = {
--           library = {
--             vim.fn.expand "$VIMRUNTIME/lua",
--             vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
--             vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
--             vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
--           },
--           maxPreload = 100000,
--           preloadFileSize = 10000,
--         },
--       },
--     },
--   }
-- end

-- return M
