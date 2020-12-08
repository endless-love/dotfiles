vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    'whiteinge/diffconflicts',
    cmd = { 'DiffConflicts', 'DiffConflictsWithHistory', 'DiffConflictsShowHistory' }
  }

  use {
    'rhysd/conflict-marker.vim'
  }

  use 'tpope/vim-unimpaired'

  use {'tomtom/tcomment_vim'}

  use {
    {'neovim/nvim-lspconfig', opt = true},
    {
      'nvim-lua/completion-nvim',
      opt = true,
      requires = {
        -- {'hrsh7th/vim-vsnip', opt = true},
        -- {'hrsh7th/vim-vsnip-integ', opt = true}
        {
          'norcalli/snippets.nvim',
          opt = true,
          -- commit = "f7f4e43",
        },
        {
          'steelsojka/completion-buffers',
          opt = true,
          after = {'completion-nvim'}
        },
      }
    },
    {'nvim-lua/lsp-status.nvim', opt = true},
    {'nvim-treesitter/nvim-treesitter', opt = true},
    {'nvim-treesitter/nvim-treesitter-textobjects', opt = true},
    {'nvim-treesitter/nvim-treesitter-refactor', opt = true},
    {'nvim-treesitter/playground', opt = true},
    {'romgrk/nvim-treesitter-context', opt = true},
  }

  use {
    'justinmk/vim-dirvish',
    { 'kristijanhusak/vim-dirvish-git', after = 'vim-dirvish' }
  }

  use {
    'dhruvasagar/vim-prosession',
    after = 'vim-obsession',
    requires = {{'tpope/vim-obsession', cmd = 'Prosession'}}
  }

  use {
    'tpope/vim-abolish',
    cmd = 'S',
  }

  use {
    'gruvbox-community/gruvbox',
    config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_invert_selection = 0
      vim.cmd[[set background=dark]]
      vim.cmd[[colorscheme gruvbox]]
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end
  }

  use {
    'nvim-lua/telescope.nvim',
     opt = true,
     requires = {
       {'nvim-lua/popup.nvim', opt = true},
       {'nvim-lua/plenary.nvim', opt = true},
     }
  }

  use {
    'mhinz/vim-signify',
    opt = true,
  }

  use {
    'buoto/gotests-vim',
    cmd = { 'GoTests', 'GoTestsAll' }
  }
end)

-- vim: ts=2 sts=2 sw=2 et
