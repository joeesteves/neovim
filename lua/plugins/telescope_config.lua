local actions = require("telescope.actions")
local lactions = require("telescope.actions.layout")
local finders = require("telescope.builtin")

require("telescope").setup({
	defaults = {
		prompt_prefix = " ❯ ",
		initial_mode = "insert",
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
		mappings = {
			i = {
				["<ESC>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
				["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<C-h>"] = lactions.toggle_preview,
				["<C-t>"] = actions.select_tab,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
		},
	},
})

local Telescope = setmetatable({}, {
	__index = function(_, k)
		if vim.bo.filetype == "NvimTree" then
			vim.cmd.wincmd("l")
		end
		return finders[k]
	end,
})

-- Ctrl-p = fuzzy finder
vim.keymap.set("n", "<C-P>", function()
	local ok = pcall(Telescope.find_files, { show_untracked = true })
	if not ok then
		Telescope.find_files()
	end
end)

-- Get :help at the speed of light
vim.keymap.set("n", "<leader>H", Telescope.help_tags)

-- Fuzzy find active buffers
vim.keymap.set("n", "'b", Telescope.buffers)

-- Search for string
vim.keymap.set("n", "'r", Telescope.live_grep)
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- Fuzzy find changed files in git
vim.keymap.set("n", "'c", Telescope.git_status)

-- Search for string
vim.keymap.set("n", "'s", Telescope.lsp_document_symbols)
