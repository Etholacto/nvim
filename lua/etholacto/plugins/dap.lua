---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
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

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

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

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason.nvim",
      "mfussenegger/nvim-dap"
    },
    cmd = { "DapInstall", "DapUninstall" },
    config = function()
      local masonDAP = require('mason-nvim-dap')

      masonDAP.setup({
        automatic_installation = true,
        ensure_installed = {
          "debugpy",
          "java-debug-adapter",
          "java-test",
          "codelldb",
          "netcoredbg",
        },
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
}
