local lsp = require("lspconfig")
local U = require("plugins.lsp.utils")

---Common perf related flags for all the LSP servers
local flags = {
	allow_incremental_sync = true,
	debounce_text_changes = 200,
}

---Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
	---Disable formatting for servers (Handled by null-ls)
	---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	---Disable |lsp-semantic_tokens| (conflicting with TS highlights)
	client.server_capabilities.semanticTokensProvider = nil

	---LSP Mappings
	U.mappings(buf)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
vim.diagnostic.config({
	virtual_text = {
		source = "always",
	},
	float = {
		source = "always",
	},
})

-- Elixir
lsp.elixirls.setup({
	-- Unix
	cmd = { "/home/joe/.elixir-ls/language_server.sh" },
	flags = flags,
	capabilities = capabilities,
	on_attach = on_attach,
})

-- TypeScript
lsp.tsserver.setup({
	flags = flags,
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Rust
lsp.rust_analyzer.setup({
	flags = flags,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {},
	},
})

-- Haskell
lsp.hls.setup({
	flags = flags,
	capabilities = capabilities,
	on_attach = on_attach,
})
--
-- Solargraph
lsp.solargraph.setup({
	flags = flags,
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Lua
lsp.lua_ls.setup({
	flags = flags,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			completion = {
				enable = true,
				showWord = "Disable",
				-- keywordSnippet = 'Disable',
			},
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = { os.getenv("VIMRUNTIME") },
				-- Don't show suggestions for third party libs
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
