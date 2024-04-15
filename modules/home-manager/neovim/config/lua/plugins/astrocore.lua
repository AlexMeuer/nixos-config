-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local runSpotify = function(args, title)
  require("plenary.job")
    :new({
      command = "spt",
      args = args,
      on_exit = function(j, return_val)
        require("astrocore").notify(
          table.concat(j.result(j), "\n"),
          return_val == 0 and vim.log.levels.INFO or vim.log.levels.ERROR,
          { title = title }
        )
      end,
    })
    :start()
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = true, -- sets vim.opt.wrap
        conceallevel = 2,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        blamer_enabled = true, -- enable git blamer
        blamer_show_in_visual_modes = true,
        blamer_show_in_insert_modes = true,
        blamer_relative_time = true, -- Shows commit date in relative format
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Find Projects" },
        ["<leader>ts"] = {
          -- Assumes that toggle term is available.
          function() require("astrocore").toggle_term_cmd "spt" end,
          desc = "ToggleTerm spotify",
        },
        ["<leader>tn"] = {
          -- Assumes that toggle term is available.
          function() require("astrocore").toggle_term_cmd "nap" end,
          desc = "ToggleTerm Nap",
        },
        ["<leader>m"] = { desc = " Music" },
        ["<leader>mo"] = {
          -- Assumes that toggle term is available.
          function() require("astrocore").toggle_term_cmd "spt" end,
          desc = "ToggleTerm spotify",
        },
        ["<leader>mt"] = {
          function() runSpotify({ "playback", "--toggle" }, "Playback Toggled") end,
          desc = "Toggle play/pause",
        },
        ["<leader>mn"] = {
          function() runSpotify({ "playback", "--next" }, "Next Track") end,
          desc = "Next song",
        },
        ["<leader>mp"] = {

          function() runSpotify({ "playback", "--previous" }, "Previous Track") end,
          desc = "Previous song",
        },
        ["<leader>ms"] = {

          function() runSpotify({ "playback", "--shuffle" }, "Shuffle") end,
          desc = "Toggle shuffle",
        },
        ["<leader>mi"] = {
          function() runSpotify({ "playback" }, "Info") end,
          desc = "Info (Now Playing)",
        },
        ["<leader>uo"] = {
          "<cmd>AerialToggle<cr>",
          desc = "Toggle Outline",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
