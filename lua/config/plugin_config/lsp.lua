-- ~/AppData/Local/nvim/lua/config/plugin_config/LSP.lua

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- Set up nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  }
})

-- Set up Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",  -- Use ts_ls if tsserver is deprecated
    "html",
    "lua_ls",
    "pyright",
    "cssls",
    "emmet_ls"
  }
})

-- Common capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP configurations
local lspconfig = require('lspconfig')

-- TypeScript/JavaScript (using tsserver)
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
    }
  }
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'htmldjango', 'javascriptreact', 'typescriptreact' }
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    }
  }
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities
})

-- Emmet
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact', 'htmldjango' },
})

-- Keybindings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.lua', '*.py', '*.js', '*.ts', '*.html', '*.css' },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})