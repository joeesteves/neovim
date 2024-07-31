-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:

require("lazy").setup({
	"EdenEast/nightfox.nvim",

	-----------------------
	-- Utilities plugins --
	-----------------------
	"github/copilot.vim",
	"mattn/emmet-vim",
	{ import = "plugins/nvim-autopairs" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Prev todo comment" })
		end,
	},

	"AndrewRadev/switch.vim",
	{
		"TobinPalmer/pastify.nvim",
		cmd = { "Pastify", "PastifyAfter" },
		config = function()
			require("pastify").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
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
		"nvim-tree/nvim-web-devicons",
		config = function()
			local devicons = require("nvim-web-devicons")

			-- Get the icon settings for .env
			local icon, color, cterm_color = devicons.get_icon_colors(".env")

			-- Set the same icon for .env.prod
			devicons.set_icon({
				[".env.production"] = {
					icon = icon,
					color = color,
					cterm_color = cterm_color,
					name = "EnvProd",
				},
			})
		end,
	},
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
	{ import = "plugins/treesitter" },
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
	-- {
	-- 	"jghauser/shade.nvim",
	-- 	opts =
	-- 		{
	-- 			overlay_opacity = 50,
	-- 			opacity_step = 1,
	-- 			keys = {
	-- 				brightness_up = "<C-Up>",
	-- 				brightness_down = "<C-Down>",
	-- 				toggle = "<Leader>s",
	-- 			},
	-- 		}
	-- 	,
	-- },
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
		import = "plugins/lspsaga",
	},
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
