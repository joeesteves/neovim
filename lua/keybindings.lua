local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<C-x>", "<CMD>tabc<CR>")
map("n", "<C-t>", "<CMD>tabnew<CR>")

-- FORMAT

map("n", "<leader>f", "<CMD>lua vim.lsp.buf.format()<CR>")
