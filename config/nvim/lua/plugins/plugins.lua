return {

  --------------------------------------------------
  -- 🎨 THEME: Catppuccin
  --------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        notify = true,
        mini = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  --------------------------------------------------
  -- 🌐 LSP (TS, Tailwind, Python, ESLint)
  --------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {},
        tailwindcss = {},
        pyright = {},
        eslint = {},
      },
    },
  },

  --------------------------------------------------
  -- ✨ FORMATTER (Prettier + Black)
  --------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },

  --------------------------------------------------
  -- 🎯 AUTOCOMPLETE
  --------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      table.insert(opts.sources, { name = "emoji" })

      opts.experimental = {
        ghost_text = true,
      }

      return opts
    end,
  },
  -- Iine error
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- or "🔥", "→", etc.
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
  --------------------------------------------------
  -- 🌬️ Tailwind color preview
  --------------------------------------------------
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup()
    end,
  },

  --------------------------------------------------
  -- 🌲 Treesitter
  --------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "bash",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "markdown",
        "python",
      },
    },
  },

  --------------------------------------------------
  -- 🔍 Telescope
  --------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
    },
  },

  --------------------------------------------------
  -- 🧰 Mason (auto install tools)
  --------------------------------------------------
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "typescript-language-server",
        "tailwindcss-language-server",
        "pyright",
        "eslint-lsp",

        -- formatters
        "prettier",
        "black",

        -- misc
        "stylua",
        "shfmt",
        "shellcheck",
        "flake8",
      },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        mode = "background", -- or "foreground"
      },
    },
  },
  --------------------------------------------------
  -- 😎 Lualine
  --------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}

      table.insert(opts.sections.lualine_x, {
        function()
          return "🚀"
        end,
      })
    end,
  },

  --------------------------------------------------
  -- 🧑‍💻 LazyGit
  --------------------------------------------------
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  --------------------------------------------------
  -- 🐞 Debugging (DAP)
  --------------------------------------------------
  {
    "mfussenegger/nvim-dap",
  },

  {
    "karb94/neoscroll.nvim",
    opts = {},
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },

  {
    "nvim-mini/mini.animate",
    opts = {
      cursor = { enable = false },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-vscode-js").setup({
        adapters = { "pwa-node", "pwa-chrome" },
      })
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("python")
    end,
  },
}
