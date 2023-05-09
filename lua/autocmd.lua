-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_user_command("DM", "Git difftool -y main", {})
vim.api.nvim_create_user_command("Dm", "Git difftool -y main % | execute 'windo set wrap'", {})
