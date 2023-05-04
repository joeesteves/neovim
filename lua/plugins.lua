-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
  ---------------------
  -- Package Manager --
  ---------------------
  use 'wbthomason/packer.nvim'

  ----------------------
  -- Required plugins --
  ----------------------
  use('nvim-lua/plenary.nvim')

  ----------------------
  -- Theme plugins --
  ----------------------
  use 'EdenEast/nightfox.nvim'
  vim.cmd[[colorscheme nightfox]]

  ---------------------------------
  -- Navigation and Fuzzy Search --
  ---------------------------------
   use({
     'nvim-tree/nvim-tree.lua',
     event = 'CursorHold',
     requires = {
       'nvim-tree/nvim-web-devicons', -- optional
     },
     config = function()
        require('plugins.nvim-tree')
     end,
  })

  use({
      {
          'nvim-telescope/telescope.nvim',
          event = 'CursorHold',
          config = function()
              require('plugins.telescope')
          end,
      },
      {
          'nvim-telescope/telescope-fzf-native.nvim',
          after = 'telescope.nvim',
          run = 'make',
          config = function()
              require('telescope').load_extension('fzf')
          end,
      }
  })

  -- Add info to status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        require('lualine').setup()
    end
  }

  -----------------------
  -- Utilities plugins --
  -----------------------
  use 'AndrewRadev/switch.vim'
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  use({
      'tpope/vim-surround',
      event = 'BufRead',
      requires = {
          {
              'tpope/vim-repeat',
              event = 'BufRead',
          },
      },
  })
  
  -----------------------------------
  -- Treesitter: Better Highlights --
  -----------------------------------
  --
  use {{
    'nvim-treesitter/nvim-treesitter',
    event = 'CursorHold',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' }
  }

  ----------------------
  -- Language plugins --
  ----------------------
  
  -- use {
  --   "tpope/vim-rails",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     -- disable autocmd set filetype=eruby.yaml
  --     vim.api.nvim_create_autocmd(
  --       { 'BufNewFile', 'BufReadPost' },
  --       {
  --         pattern = { '*.yml' },
  --         callback = function()
  --           vim.bo.filetype = 'yaml'
  --         end
  --
  --       }
  --     )
  --   end
  -- }

  use("slim-template/vim-slim")

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  ----------------------
  -- Git plugins --
  ----------------------
  --use tpope/vim-fugitive
  use { 
    'tpope/vim-fugitive', 
     config = function()
        vim.api.nvim_create_user_command('G', 'Gtabedit :', {})
     end
  }
        -----------------------------------
        -- LSP, Completions and Snippets --
        -----------------------------------

        use({
            {
                'hrsh7th/nvim-cmp',
                event = 'InsertEnter',
                config = function()
                    require('plugins.lsp.nvim-cmp')
                end,
                requires = {
                    {
                        'L3MON4D3/LuaSnip',
                        event = 'InsertEnter',
                        config = function()
                            require('plugins.lsp.luasnip')
                        end,
                        requires = {
                            {
                                'rafamadriz/friendly-snippets',
                                event = 'CursorHold',
                            },
                        },
                    },
                },
            },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        })
end)
