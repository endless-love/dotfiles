-- vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end

require("lsp-status").register_progress()

local register_server = function(server, config)
  local lsp_status = require("lsp-status")
  -- local completion = require("completion")

  config = config or {}

  config.on_attach = function(client, bufnr)
    -- completion.on_attach(client)
    lsp_status.on_attach(client)
    local mapper = function(mode, key, result)
      vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
    end

    mapper('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    mapper('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    mapper('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    mapper('n', 'gr', [[<cmd>lua require'telescope.builtin'.lsp_references{}<CR>]])
    mapper('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    mapper('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    -- mapper('n', '<M-Return>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    mapper('n', '<M-Return>', [[<cmd>lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>]])
    -- mapper('x', '<M-Return>', [[<cmd>lua require'telescope.builtin'.lsp_range_code_actions(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>]])
    mapper('x', '<M-Return>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
    mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    mapper('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    mapper('n', '<M-s>', [[<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>]])
    mapper('n', '<M-S>', [[<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>]])

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.resolved_capabilities.document_highlight == true then
      vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
    if client.resolved_capabilities.document_formatting == true then
      vim.cmd [[ command! -nargs=0 Format lua vim.lsp.buf.formatting() ]]
    end
  end

  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  server.setup(config)
end

local lspconfig = require('lspconfig')

--[[
register_server(nvim_lsp.solargraph, {
  settings = {
    solargraph = {
      autoformat = true,
      diagnostics = true,
      formatting = true,
      transport = "stdio"
    }
  }
})
--]]

register_server(lspconfig.gopls)

register_server(lspconfig.clangd, {
  cmd = {"clangd", "-clang-tidy", "-cross-file-rename"}
})

register_server(lspconfig.rust_analyzer)

register_server(lspconfig.pyright, {
  cmd = { "poetry", "run", "pyright-langserver", "--stdio" }
})

register_server(lspconfig.efm)

register_server(lspconfig.html)
register_server(lspconfig.cssls)
register_server(lspconfig.jsonls, {
  cmd = { "json-languageserver", "--stdio" }
})
register_server(lspconfig.yamlls, {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
        ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
      }
    }
  }
})
-- register_server(nvim_lsp.tsserver)

register_server(lspconfig.bashls)

register_server(lspconfig.vimls)
register_server(lspconfig.sumneko_lua, {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        enable = true,
        globals = {
          -- Neovim
          "vim",
          -- Busted
          "describe", "it", "before_each", "after_each"
        },
      },
      workspace = {
        library = vim.list_extend({
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        }, {}),
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
