-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
require("lazy").setup({
	"EdenEast/nightfox.nvim",

	-----------------------
	-- Utilities plugins --
	-----------------------
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"AndrewRadev/switch.vim",

	{
		"numToStr/Comment.nvim",
		lazy = false,
	},

	{
		"tpope/vim-surround",
		event = "BufRead",
		dependencies = {
			{
				"tpope/vim-repeat",
			},
		},
	},

	"romainl/vim-qf",

	---------------------------------
	-- Navigation and Fuzzy Search --
	---------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		event = "CursorHold",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugins.nvim-tree")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		event = "CursorHold",
		config = function()
			require("plugins.telescope_config")
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"alvarosevilla95/luatab.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("luatab").setup({
				-- remove anoying buffer numbers (2) file_name.ex
				windowCount = function()
					return ""
				end,
			})
		end,
	},

	-- Add info to status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"vim.g.git_branch",
						{ "diagnostics", symbols = { error = "E", warn = "W", info = "I", hint = "H" } },
					},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = {},
				},
			})
		end,
	},

	-----------------------------------
	-- Treesitter: Better Highlights --
	-----------------------------------

	"pbrisbin/vim-syntax-shakespeare",
	{
		{
			"nvim-treesitter/nvim-treesitter",
			event = { "BufReadPre", "BufNewFile" },
			-- event = "CursorHold",
			build = ":TSUpdate",
			config = function()
				require("plugins.treesitter")
			end,
		},
		"nvim-treesitter/nvim-treesitter-refactor",
	},

	----------------------
	-- Language plugins --
	----------------------

	"kchmck/vim-coffee-script",
	"tpope/vim-rails",
	"slim-template/vim-slim",
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-------------------------
	-- Shade --
	-- dim unactive buffers
	-------------------------
	{
		"jghauser/shade.nvim",
		config = function()
			require("shade").setup({
				overlay_opacity = 50,
				opacity_step = 1,
				keys = {
					brightness_up = "<C-Up>",
					brightness_down = "<C-Down>",
					toggle = "<Leader>s",
				},
			})
		end,
	},
	----------------------
	-- Git plugins --
	----------------------
	"tpope/vim-fugitive",
	{
		"tpope/vim-fugitive",
		config = function()
			vim.api.nvim_create_user_command("G", "Gtabedit :", {})
		end,
	},

	"joeesteves/vim-github-link",
	-----------------------------------
	-- LSP, Completions and Snippets --
	-----------------------------------

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.lsp.servers")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		config = function()
			require("plugins.lsp.null-ls")
		end,
	},
	{
		{ import = "plugins/nvim-cmp" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-buffer" },
	},
})

vim.cmd([[colorscheme nightfox]])

local function branch_name()
	local branch = vim.fn.system("git branch --show-current | cut -c1-7 | tr -d '\n' ")

	if branch ~= "" then
		return branch
	else
		return ""
	end
end

vim.g.git_branch = branch_name()
