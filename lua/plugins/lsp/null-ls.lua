local nls = require("null-ls")
local U = require("plugins.lsp.utils")

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
	sources = {
		----------------
		-- FORMATTING --
		----------------
		fmt.trim_whitespace.with({
			filetypes = { "text", "zsh", "toml", "make", "conf", "tmux" },
		}),
		-- NOTE:
		-- 1. both needs to be enabled to so prettier can apply eslint fixes
		-- 2. prettierd should come first to prevent occassional race condition
		fmt.deno_fmt.with({
			filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
		}),
		fmt.prettierd,
		-- fmt.rubyfmt,
		fmt.rubocop,
		fmt.sqlformat,
		fmt.mix,
		fmt.rustfmt,
		fmt.stylua,
		fmt.gofmt,
		fmt.zigfmt,
		fmt.eslint,
		fmt.shfmt.with({
			extra_args = { "-i", 4, "-ci", "-sr" },
		}),
    --
		-----------------
		-- DIAGNOSTICS --
		-----------------
		dgn.eslint,
		-- dgn.shellcheck,
		dgn.luacheck.with({
			extra_args = { "--globals", "vim", "--std", "luajit" },
		}),
		------------------
		-- CODE ACTIONS --
		------------------
		cda.eslint,
		cda.shellcheck,
	},
	on_attach = function(client, bufnr)
		U.fmt_on_save(client, bufnr)
		U.mappings(bufnr)
	end,
})
