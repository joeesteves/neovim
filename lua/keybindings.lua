local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<C-x>", "<CMD>bd<CR>")
map("n", "<C-t>", "<CMD>tabnew<CR>")

-- FORMAT

map("n", "<leader>f", "<CMD>lua vim.lsp.buf.format()<CR>")
--
-- Copy path of current buffer to clipboard
map("n", "<C-K><C-F>", '<CMD>let @+ = expand("%")<CR>')

-- " Move lines
map("n", "<A-j>", "<CMD>m .+1<CR>==")
map("n", "<A-k>", "<CMD>m .-2<CR>==")

-- nnoremap <A-j> :m .+1<CR>==
-- nnoremap <A-k> :m .-2<CR>==
-- inoremap <A-j> <Esc>:m .+1<CR>==gi
-- inoremap <A-k> <Esc>:m .-2<CR>==gi
-- vnoremap <A-j> :m '>+1<CR>gv=gv'
-- vnoremap <A-k> :m '<-2<CR>gv=gv'

-- Copilot
-- vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', { expr = true, silent = true })
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_no_tab_map = true
vim.keymap.set(
	"i",
	"<Plug>(vimrc:copilot-dummy-map)",
	'copilot#Accept("")',
	{ silent = true, expr = true, desc = "Copilot dummy accept" }
)
