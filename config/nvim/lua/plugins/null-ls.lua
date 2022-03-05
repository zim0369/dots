require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.rustfmt,
		require("null-ls").builtins.diagnostics.pylint,
		require("null-ls").builtins.hover.dictionary,
		-- require("null-ls").builtins.completion.spell,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
