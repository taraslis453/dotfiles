-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Utils
  "moll/vim-bbye",
  "folke/which-key.nvim",
  {
    "segeljakt/vim-silicon",
    cmd = "Silicon",
    config = function()
      vim.cmd([[
        let g:silicon={
          \   'theme':              'GitHub',
          \   'font':               'JetBrainsMono Nerd Font',
          \   'to-clipboard':       v:true,
        \ }]])
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.config.nvim-tree")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>f", desc = "Find files (fuzzy)" },
      { "<leader>g", desc = "Grep project" },
      { "<leader>r", desc = "Recent files" },
      { "<leader>v", desc = "Buffers" },
      { "<leader>t", desc = "Git status" },
      { "<leader>p", desc = "Projects" },
      { "gr", desc = "LSP references" },
    },
    cmd = { "FzfLua" },
    config = function()
      require("plugins.config.fzf")
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("plugins.config.todo-comments")
    end,
  },

  -- Editing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.config.autopairs")
    end,
  },
  "tpope/vim-repeat",
  "tpope/vim-abolish",
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Motion
  {
    "phaazon/hop.nvim",
    commit = "b93ed4cea9c7df625d04e41cb15370b5c43cb578",
    keys = {
      { "<space>s", ":HopChar2MW<cr>", mode = { "n", "v" }, desc = "Hop to characters" },
    },
    config = function()
      require("hop").setup()
    end,
  },

  -- UI
  {
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.config.lsp.dressing")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.config.lualine")
    end,
  },
  {
    -- Using maintained fork with updated APIs
    "coffebar/project.nvim",
    config = function()
      require("plugins.config.project")
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.config.alpha")
    end,
  },
  "kevinhwang91/nvim-bqf",
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-t>", desc = "Toggle terminal" },
      { "<C-a>", mode = { "n", "i", "t" }, desc = "Toggle all terminals" },
    },
    cmd = { "ToggleTerm", "ToggleTermToggleAll" },
    config = function()
      require("plugins.config.toggleterm")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("plugins.config.bufferline")
    end,
  },
  {
    "rmagatti/goto-preview",
    keys = {
      { "gpd", desc = "Goto preview definition" },
      { "gpt", desc = "Goto preview type definition" },
      { "gpi", desc = "Goto preview implementation" },
      { "gpr", desc = "Goto preview references" },
      { "gP", desc = "Close all preview windows" },
    },
    config = function()
      require("goto-preview").setup({
        default_mappings = true,
      })
    end,
  },

  -- Code reading / Colorschemes
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  "projekt0n/github-nvim-theme",
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background", -- 'background', 'foreground', 'virtual'
        enable_named_colors = true,
        enable_tailwind = true,
      })
    end,
  },
  "folke/tokyonight.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Use the main branch (master is deprecated)
    lazy = false,
    priority = 1000, -- Load before LSP to ensure highlighting autocmd is registered first
    build = ":TSUpdate",
    config = function()
      require("plugins.config.treesitter")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
  },
  -- NOTE: These plugins are temporarily disabled because they're not yet compatible
  -- with nvim-treesitter's main branch (they still use the deprecated nvim-treesitter.configs)
  -- Re-enable once they're updated or switch nvim-treesitter back to master branch
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   lazy = false,
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   lazy = false,
  --   opts = {
  --     enable = true,
  --     max_lines = 0,
  --     trim_scope = "outer",
  --   },
  -- },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false, -- Load immediately after treesitter
    config = function()
      require("hlargs").setup()
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure treesitter loads first
    config = function()
      require("plugins.config.lsp.init")
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "tamago324/nlsp-settings.nvim",
  {
    "hedyhli/outline.nvim",
    keys = {
      { "<space><space>", ":Outline<CR>", desc = "Toggle symbols outline" },
    },
    cmd = { "Outline", "OutlineOpen" },
    config = function()
      require("plugins.config.lsp.symbols-outline")
    end,
  },

  -- LSP UI
  "folke/trouble.nvim",
  "MunifTanjim/nui.nvim",
  "lukas-reineke/indent-blankline.nvim",
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.config.cmp")
    end,
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        filetypes = {
          ["*"] = true,
        },
        -- Ensure copilot LSP server is enabled for sidekick.nvim
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 10,
              inlineSuggestCount = 3,
            },
          },
        },
      })
    end,
  },
  {
    "folke/sidekick.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua", -- Copilot.lua manages the LSP server
    },
    init = function()
      -- Enable Copilot LSP for sidekick
      vim.lsp.enable("copilot_ls")
    end,
    opts = {
      nes = {
        enabled = true,
        debounce = 200,
      },
      cli = {
        watch = true,
        mux = {
          backend = "tmux",
          enabled = true, -- Enable for persistent AI sessions
          create = "terminal", -- Create in Neovim terminal (not tmux window/split)
        },
        win = {
          layout = "right",
        },
      },
    },
    keys = {
      {
        "<Tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        mode = "n",
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle({ name = "cursor", focus = true }) end,
        desc = "Sidekick Toggle Cursor Agent",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.config.gitsigns")
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>do", ":DiffviewOpen<cr>", desc = "Diffview open" },
      { "<leader>dc", ":DiffviewClose<cr>", desc = "Diffview close" },
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("plugins.config.diffview")
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      { "<leader>wt", desc = "List/switch worktrees" },
      { "<leader>wT", desc = "Create new worktree" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("git-worktree").setup()
      
      -- List/switch worktrees
      vim.keymap.set("n", "<leader>wt", function()
        local fzf = require("fzf-lua")
        local worktree = require("git-worktree")
        local Job = require("plenary.job")
        
        -- Get worktree list
        local results = {}
        Job:new({
          command = "git",
          args = { "worktree", "list" },
          on_exit = function(j, return_val)
            if return_val == 0 then
              results = j:result()
            end
          end,
        }):sync()
        
        fzf.fzf_exec(results, {
          prompt = "Git Worktrees> ",
          actions = {
            ["default"] = function(selected)
              if selected and selected[1] then
                local path = selected[1]:match("^(%S+)")
                if path then
                  worktree.switch_worktree(path)
                end
              end
            end
          }
        })
      end, { desc = "List/switch worktrees" })
      
      -- Create new worktree
      vim.keymap.set("n", "<leader>wT", function()
        -- Create centered floating window for input
        local function input_in_center(prompt, callback)
          local buf = vim.api.nvim_create_buf(false, true)
          local width = 60
          local height = 1
          local row = math.floor((vim.o.lines - height) / 2)
          local col = math.floor((vim.o.columns - width) / 2)
          
          local win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal',
            border = 'rounded',
            title = prompt,
            title_pos = 'center',
          })
          
          vim.cmd('startinsert')
          
          vim.keymap.set('i', '<CR>', function()
            local input = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1] or ""
            vim.api.nvim_win_close(win, true)
            callback(input)
          end, { buffer = buf })
          
          vim.keymap.set('i', '<Esc>', function()
            vim.api.nvim_win_close(win, true)
            callback(nil)
          end, { buffer = buf })
        end
        
        input_in_center("Branch name: ", function(branch)
          if branch and branch ~= "" then
            input_in_center("Worktree path: ", function(path)
              if path and path ~= "" then
                require("git-worktree").create_worktree(branch, path)
              end
            end)
          end
        end)
      end, { desc = "Create new worktree" })
    end,
  },
}, {
  -- lazy.nvim options
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})

-- Load colorscheme
require("plugins.config.colorscheme")
