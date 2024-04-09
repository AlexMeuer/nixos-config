return {
  -- Colorscheme(s)
  { "sainnhe/gruvbox-material" },
  { "sainnhe/everforest" },

  -- Must-have: fuzzy jumper
  { "rlane/pounce.nvim",       keys = { { "f", "<cmd>Pounce<cr>", desc = "Pounce" } } },

  -- Navigate aruound kitty and nvim with same pane bindings
  -- Additional kitty setup required. https://github.com/knubie/vim-kitty-navigator
  {
    "knubie/vim-kitty-navigator",
    event = "VeryLazy",
  },

  -- See and select registers
  { "gennaro-tedesco/nvim-peekup", event = "VeryLazy" },

  {
    "folke/twilight.nvim",
    keys = { { "<leader>uz", "<cmd>Twilight<cr>", desc = "Twilight (code dimming)" } },
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>uZ", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" } },
  },
  { "anuvyklack/middleclass" },
  { "anuvyklack/animation.nvim" },
  {
    "anuvyklack/windows.nvim",
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
    keys = {
      { "<C-w>t", "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle autowidth" },
      { "<C-w>z", "<cmd>WindowsMaximize<cr>",        desc = "Maximize" },
    },
  },

  -- Markdown previewer
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- {
  --   "pwntester/octo.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   event = "BufRead",
  --   config = function()
  --     require("octo").setup {
  --       enable_builtin = true,
  --     }
  --   end,
  -- },
  {
    -- Need to run ":MasonInstall sonarlint-language-server" to install the server for this.
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    event = { "BufEnter *.ts", "BufEnter *.js", "BufEnter *.tsx", "BufEnter *.py" },
    config = function()
      require("sonarlint").setup {
        server = {
          cmd = {
            "sonarlint-language-server",
            -- Ensure that sonarlint-language-server uses stdio channel
            "-stdio",
            "-analyzers",
            -- paths to the analyzers you need, using those for python and java in this example
            vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarpython.jar",
            vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarjs.jar",
          },
        },
        filetypes = {
          "python",
          "javascript",
          "typescript",
          "typescriptreact",
        },
      }
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Optional.
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/repos/alexmeuer/notes",
        },
      },
      daily_notes = {
        folder = "Dailies/",
        template = "_templates/Daily template.md",
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        ["gf"] = {
          action = function() return require("obsidian").util.gf_passthrough() end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      templates = {
        subdir = "_templates",
      },
    },
  },
}
