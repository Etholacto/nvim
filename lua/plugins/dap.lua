return {
  {
    "mfussenegger/nvim-dap-ui",
    event = 'VeryLazy',

    dependencies = {
      -- https://github.com/mfussenegger/nvim-dap
      'mfussenegger/nvim-dap',
      -- https://github.com/theHamsta/nvim-dap-virtual-text
      'theHamsta/nvim-dap-virtual-text',   -- inline variable text while debugging
      -- https://github.com/nvim-telescope/telescope-dap.nvim
      'nvim-telescope/telescope-dap.nvim', -- telescope integration with dap
      --https://github.com/nvim-neotest/nvim-nio
      "nvim-neotest/nvim-nio"              --library for nvim dap ui
    },

    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F1>",       function() require("dap").continue() end,          desc = "Continue" },
      { "<F2>",       function() require("dap").step_into() end,         desc = "Step Into" },
      { "<F3>",       function() require("dap").step_over() end,         desc = "Step Over" },
      { "<F4>",       function() require("dap").step_out() end,          desc = "Step Out" },
      { "<F5>",       function() require("dap").step_back() end,         desc = "Step Back" },
      { "<leader>dc", function() require("dap").run_to_cursor() end,     desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,             desc = "Go to Line (No Execute)" },
      { "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle({}) end,        desc = "Dap UI" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "Widgets" },
    },

    opts = {
      controls = {
        element = "repl",
        enabled = false,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.50
            },
            {
              id = "stacks",
              size = 0.30
            },
            {
              id = "watches",
              size = 0.10
            },
            {
              id = "breakpoints",
              size = 0.10
            }
          },
          size = 40,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        }
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    },

    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end


      local dapIcons = {
        DapStopped            = { text = "󰁕", texthl = "Success", linehl = "DapStoppedLine" },
        DapBreakpoint         = { text = "", texthl = "Error", linehl = '' },
        DapBreakpointRejected = { text = "", texthl = "Warning", linehl = '' },
        DapLogPoint           = { text = "📝", texthl = "Hint", linehl = '' },
      }

      for name, sign in pairs(dapIcons) do
        vim.fn.sign_define(name, {
          text = sign.text,
          texthl = sign.texthl,
          linehl = sign.linehl
        })
      end

      local netcoredbgPath = packagePath .. '/netcoredbg/netcoredbg/netcoredbg'
      --Dotnet Config (C#)
      dap.adapters.coreclr = {
        type = 'executable',
        command = netcoredbgPath,
        args = { '--interpreter=vscode' }
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }

      local codelldbPath = packagePath .. '/codelldb/extension/adapter/codelldb'
      --LLDB config (C/C++/Rust)
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = codelldbPath,
          args = { "--port", "${port}" },
          -- On windows you may have to uncomment this:
          detached = false,
        }
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- Add dap configurations based on your language/adapter settings
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      dap.configurations.java = {
        {
          name = "Debug Launch (2GB)",
          type = 'java',
          request = 'launch',
          vmArgs = "" ..
              "-Xmx2g "
        },
        {
          name = "Debug Attach (8000)",
          type = 'java',
          request = 'attach',
          hostName = "127.0.0.1",
          port = 8000,
        },
        {
          name = "Debug Attach (5005)",
          type = 'java',
          request = 'attach',
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end,
  },
  {
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    opts = {
      -- Display debug text as a comment
      commented = true,
      -- Customize virtual text
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
    }
  },
  --   {
  --     "jay-babu/mason-nvim-dap.nvim",
  --     dependencies = {
  --       "mason.nvim",
  --       "mfussenegger/nvim-dap"
  --     },
  --     cmd = { "DapInstall", "DapUninstall" },
  --     config = function()
  --       local masonDAP = require('mason-nvim-dap')
  --
  --       masonDAP.setup({
  --         automatic_installation = true,
  --         ensure_installed = {
  --           "debugpy",
  --           "java-debug-adapter",
  --           "java-test",
  --           "codelldb",
  --           "netcoredbg",
  --         },
  --       })
  --     end,
  --   },
  {
    --    - https://github.com/theHamsta/nvim-dap-virtual-text
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    opts = {
      -- Display debug text as a comment
      commented = true,
      -- Customize virtual text
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
    }
  },
}
