-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Auto Pairs Insert or delete brackets, parens, quotes in pair.
  use 'jiangmiao/auto-pairs'

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Markdown preview
  use {
      'iamcco/markdown-preview.nvim', 
      opt = true,
      ft = {'markdown'},
      run = 'cd app && yarn install', 
      cmd = 'MarkdownPreview'
  }

  -- An automatic table creator & formatter allowing one to create neat tables as you type.
  use {'dhruvasagar/vim-table-mode', run = ':TableModeToggle'}

  use 'mzlogin/vim-markdown-toc'

  -- You can specify multiple plugins in a single call
  use {
      'tjdevries/colorbuddy.vim', 
      {'nvim-treesitter/nvim-treesitter', opt = false, run = ':TSUpdate'}
  }

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}

  -- nerdtree
  use 'scrooloose/nerdtree'
  use 'jistr/vim-nerdtree-tabs'
  use 'Xuyuanp/nerdtree-git-plugin'

  -- fzf (need install the_silver_searcher
  use 'junegunn/fzf.vim'

  -- indentline
  use 'Yggdroot/indentLine'

  -- snips
  --use 'SirVer/ultisnips'
  --use 'honza/vim-snippets'

  -- (<leader>c<spacd>; <leader>c$)
  use 'scrooloose/nerdcommenter'

  -- 代码折叠(zo zO zc zC)
  use 'tmhedberg/SimpylFold'

  -- vim-go
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
  -- 检索
  use 'easymotion/vim-easymotion'
  -- 多重选取
  use 'mg979/vim-visual-multi'
  use 'mhinz/vim-startify'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  -- 求和插件（列求和：<leader><leader>?s）
  use 'sk1418/HowMuch'

  use 'gcmt/wildfire.vim'
  use 'tpope/vim-surround'

  -- neovim lsp
  use 'neovim/nvim-lspconfig'
  use {'hrsh7th/nvim-compe',
        requires = {
            {'hrsh7th/vim-vsnip', opt = true }, 
            {'hrsh7th/vim-vsnip-integ', opt = true }
        }
}
  use 'kabouzeid/nvim-lspinstall'

  -- translator
  use 'voldikss/vim-translator'

end)

