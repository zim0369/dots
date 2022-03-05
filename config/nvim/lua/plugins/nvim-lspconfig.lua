-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig").rust_analyzer.setup({
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
	capabilities = capabilities,
})
require("lspconfig")["pyright"].setup({
	capabilities = capabilities,
})
require("lspconfig")["ccls"].setup({
	capabilities = capabilities,
})
require("lspconfig")["hls"].setup({
	capabilities = capabilities,
})
require("lspconfig")["sumneko_lua"].setup({
	capabilities = capabilities,
})
require("lspconfig")["bashls"].setup({
	capabilities = capabilities,
})
require("lspconfig")["eslint"].setup({
	capabilities = capabilities,
})

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "hls", "ccls", "sumneko_lua", "bashls", "eslint", "pyright" }

for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		-- on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		},
	})
end
