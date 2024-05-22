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
-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

local java_filetypes = { "java" }

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {

      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
        opts = {},
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
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          ensure_installed = {
            "java",
            "python",
          },
        },
      },
      {
        "mfussenegger/nvim-jdtls",
        dependencies = { "folke/which-key.nvim" },
        ft = java_filetypes,
        opts = function()
          return {
            -- How to find the root dir for a given filename. The default comes from
            -- lspconfig which provides a function specifically for java projects.
            root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

            -- How to find the project name for a given root dir.
            project_name = function(root_dir)
              return root_dir and vim.fs.basename(root_dir)
            end,

            -- Where are the config and workspace dirs for a project?
            jdtls_config_dir = function(project_name)
              return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
            end,
            jdtls_workspace_dir = function(project_name)
              return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
            end,

            -- How to run jdtls. This can be overridden to a full java command-line
            -- if the Python wrapper script doesn't suffice.
            cmd = { vim.fn.exepath("jdtls") },
            full_cmd = function(opts)
              local fname = vim.api.nvim_buf_get_name(0)
              local root_dir = opts.root_dir(fname)
              local project_name = opts.project_name(root_dir)
              local cmd = vim.deepcopy(opts.cmd)
              if project_name then
                vim.list_extend(cmd, {
                  "-configuration",
                  opts.jdtls_config_dir(project_name),
                  "-data",
                  opts.jdtls_workspace_dir(project_name),
                })
              end
              return cmd
            end,

            -- These depend on nvim-dap, but can additionally be disabled by setting false here.
            dap = { hotcodereplace = "auto", config_overrides = {} },
            dap_main = {},
            test = true,
            settings = {
              java = {
                inlayHints = {
                  parameterNames = {
                    enabled = "all",
                  },
                },
              },
            },
          }
        end,
        config = function(_, opts)
          -- Find the extra bundles that should be passed on the jdtls command-line
          -- if nvim-dap is enabled with java debug/test.
          local mason_registry = require("mason-registry")
          local bundles = {} ---@type string[]
          if opts.dap and mason_registry.is_installed("java-debug-adapter") then
            local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
            local java_dbg_path = java_dbg_pkg:get_install_path()
            local jar_patterns = {
              java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
            }
            -- java-test also depends on java-debug-adapter.
            if opts.test and mason_registry.is_installed("java-test") then
              local java_test_pkg = mason_registry.get_package("java-test")
              local java_test_path = java_test_pkg:get_install_path()
              vim.list_extend(jar_patterns, {
                java_test_path .. "/extension/server/*.jar",
              })
            end
            for _, jar_pattern in ipairs(jar_patterns) do
              for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
                table.insert(bundles, bundle)
              end
            end
          end

          local function attach_jdtls()
            local fname = vim.api.nvim_buf_get_name(0)

            -- Configuration can be augmented and overridden by opts.jdtls
            local config = extend_or_override({
              cmd = opts.full_cmd(opts),
              root_dir = opts.root_dir(fname),
              init_options = {
                bundles = bundles,
              },
              settings = opts.settings,
              -- enable CMP capabilities
              capabilities = require("cmp_nvim_lsp").default_capabilities() or nil,
            }, opts.jdtls)

            -- Existing server will be reused if the root_dir matches.
            require("jdtls").start_or_attach(config)
            -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
          end

          -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
          -- depending on filetype, so this autocmd doesn't run for the first file.
          -- For that, we call directly below.
          vim.api.nvim_create_autocmd("FileType", {
            pattern = java_filetypes,
            callback = attach_jdtls,
          })

          -- Setup keymap and dap after the lsp is fully attached.
          -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
          -- https://neovim.io/doc/user/lsp.html#LspAttach
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "jdtls" then
                local wk = require("which-key")
                wk.register({
                  ["<leader>cx"] = { name = "+extract" },
                  ["<leader>cxv"] = { require("jdtls").extract_variable_all, "Extract Variable" },
                  ["<leader>cxc"] = { require("jdtls").extract_constant, "Extract Constant" },
                  ["gs"] = { require("jdtls").super_implementation, "Goto Super" },
                  ["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
                  ["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
                }, { mode = "n", buffer = args.buf })
                wk.register({
                  ["<leader>c"] = { name = "+code" },
                  ["<leader>cx"] = { name = "+extract" },
                  ["<leader>cxm"] = {
                    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                    "Extract Method",
                  },
                  ["<leader>cxv"] = {
                    [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                    "Extract Variable",
                  },
                  ["<leader>cxc"] = {
                    [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                    "Extract Constant",
                  },
                }, { mode = "v", buffer = args.buf })

                if opts.dap and mason_registry.is_installed("java-debug-adapter") then
                  -- custom init for Java debugger
                  require("jdtls").setup_dap(opts.dap)
                  require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)

                  -- Java Test require Java debugger to work
                  if opts.test and mason_registry.is_installed("java-test") then
                    -- custom keymaps for Java test runner (not yet compatible with neotest)
                    wk.register({
                      ["<leader>t"] = { name = "+test" },
                      ["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
                      ["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
                      ["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
                    }, { mode = "n", buffer = args.buf })
                  end
                end

                -- User can set additional keymaps in opts.on_attach
                if opts.on_attach then
                  opts.on_attach(args)
                end
              end
            end,
          })

          -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
          attach_jdtls()
        end,
      }
    },

    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

    config = function()
      local dap = {
            Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint          = " ",
            BreakpointCondition = " ",
            BreakpointRejected  = { " ", "DiagnosticError" },
            LogPoint            = ".>",
          },

          vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

     --Dotnet Config (C#)
      dap.adapters.coreclr = {
        type = 'executable',
        command = 'C:/Users/Cedric/netcoredbg-win64/netcoredbg',
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

      --LLDB config (C/C++)
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = 'C:/Users/Cedric/codelldb-x86_64-windows/extension/adapter/codelldb',
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
    end,
  },
}
