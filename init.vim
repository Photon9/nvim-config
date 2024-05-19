syntax on
set ruler
set number
set relativenumber
"set t_Co=16
set termguicolors
set showmatch
set ts=4
set sts=4
set sw=4
set autoindent
set smartindent
set smarttab
set expandtab
set background=light


call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')

Plug 'bfrg/vim-cpp-modern'

Plug 'christoomey/vim-tmux-navigator'

Plug 'ekalinin/Dockerfile.vim'

Plug 'feline-nvim/feline.nvim' 
Plug 'folke/which-key.nvim'

Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'L3MON4D3/LuaSnip'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lifepillar/vim-colortemplate'

Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-lint'
Plug 'mhartington/formatter.nvim'

Plug 'neovim/nvim-lsp' 
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neo4j-contrib/cypher-vim-syntax'

Plug 'rafamadriz/friendly-snippets'
Plug 'rcarriga/nvim-dap-ui'

Plug 'saadparwaiz1/cmp_luasnip'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'shmup/vim-sql-syntax'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

"Plug 'wookayin/semshi', { 'do': ':UpdateRemotePlugins' }
"Plug 'jiangmiao/auto-pairs'
"Plug 'jsborjesson/vim-uppercase-sql'
"Plug 'creativenull/efmls-configs-nvim', { 'tag': 'v0.1.3' } " tag is optional
"Plug 'raphamorim/vim-rio', { 'as': 'rio' }
"Plug 'jose-elias-alvarez/null-ls.nvim'

call plug#end()

"colorscheme zengarden
colorscheme brogrammer
"colorscheme rio
"colorscheme solarized8
"
autocmd BufNewFile,BufRead *.cypher setfiletype cypher
autocmd BufNewFile,BufRead *.cyp setfiletype cypher
autocmd BufNewFile,BufRead *.cql setfiletype cypher
source $XDG_CONFIG_HOME/nvim/plugged/cypher-vim-syntax/syntax/cypher.vim


vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>

lua <<EOF
-- treesitter
  require('nvim-treesitter.configs').setup {ensure_installed = all, sync_install = all, auto_install = all, highlight = {enable = true,},}

-- dapui
  require("dapui").setup()
  require("dapui").open()
  require("dapui").close()
  require("dapui").toggle()
  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
  require("dapui").float_element(<element ID>, <optional settings>)
  require("dapui").eval(<expression>)
    

-- mason
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {"pylsp"}
    })
  
-- feline
    require('feline').setup()

-- nvim-lint
    require('lint').linters_by_ft = {
      python = {'pylint',}
    }
  

--  Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }

  vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


EOF

