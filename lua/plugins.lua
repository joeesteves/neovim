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

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }


  use {
    "tpope/vim-rails",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- disable autocmd set filetype=eruby.yaml
      vim.api.nvim_create_autocmd(
        { 'BufNewFile', 'BufReadPost' },
        {
          pattern = { '*.yml' },
          callback = function()
            vim.bo.filetype = 'yaml'
          end

        }
      )
    end
  }


  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
end)
