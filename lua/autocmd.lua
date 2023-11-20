-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_user_command("DM", "Git difftool -y main", {})
vim.api.nvim_create_user_command("Dm", "Git difftool -y main % | execute 'windo set wrap'", {})

-- QuickFix

-- dd to remove entry
vim.api.nvim_create_user_command("Dd", "Reject", {})

-- navigation
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf" },
	command = [[map <C-j> :cn<CR>]],
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf" },
	command = [[map <C-k> :cp<CR>]],
})

-- -- Mix Format
-- --
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "elixir" },
	command = [[map <leader>f :!mix format %<CR><ESC>]],
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	pattern = { "*.ex", "*.exs" },
-- 	command = [[!mix format %]],
-- })

vim.api.nvim_create_autocmd("BufRead", {
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx",
		})
	end,
})
