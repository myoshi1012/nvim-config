local ok, mason = pcall(require, 'mason')
local ok2, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not ok or not ok2 then
  return
end

mason.setup {}
mason_lspconfig.setup {
  ensure_installed = {
    'jsonls',
    'sumneko_lua',
    'tsserver',
    'tailwindcss'
  }
}
