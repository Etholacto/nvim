-- default components
local bufferlist      = require('ide.components.bufferlist')
local explorer        = require('ide.components.explorer')
local outline         = require('ide.components.outline')
local callhierarchy   = require('ide.components.callhierarchy')
local timeline        = require('ide.components.timeline')
local terminal        = require('ide.components.terminal')
local terminalbrowser = require('ide.components.terminal.terminalbrowser')
local changes         = require('ide.components.changes')
local commits         = require('ide.components.commits')
local branches        = require('ide.components.branches')
local bookmarks       = require('ide.components.bookmarks')

require('ide').setup({
    -- The global icon set to use.
    -- values: "nerd", "codicon", "default"
    icon_set = "default",
    -- Set the log level for nvim-ide's log. Log can be accessed with
    -- 'Workspace OpenLog'. Values are 'debug', 'warn', 'info', 'error'
    log_level = "info",
    -- Component specific configurations and default config overrides.
    components = {
        Explorer = {
            show_file_permissions = false,
            edit_on_create = true,
            disable_keymaps = false,
            keymaps = {
                edit = "<CR>",
                edit_split = "s",
                edit_vsplit = "v",
                edit_tab = "t",
                hide = "<C-[>",
                close = "X",
                new_file = "n",
                delete_file = "D",
                new_dir = "d",
                rename_file = "r",
                move_file = "m",
                copy_file = "p",
                select_file = "<Space>",
                deselect_file = "<Space><Space>",
                change_dir = "cd",
                up_dir = "..",
                file_details = "i",
                toggle_exec_perm = "*",
                maximize = "+",
                minimize = "-"
            }
        },
        TerminalBrowser = {
            default_height = 5,
            disable_keymaps = false,
            keymaps = {
                new = "n",
                jump = "<CR>",
                hide = "<C-[>",
                delete = "D",
                rename = "r",
                maximize = "+",
                minimize = "-"
            }
        },
        Changes = {
            default_height = 20,
        },
        Commits = {
            default_height = 5,
            disable_keymaps = false,
            keymaps = {
                expand = "zo",
                collapse = "zc",
                collapse_all = "zM",
                checkout = "c",
                diff = "<CR>",
                diff_split = "s",
                diff_vsplit = "v",
                diff_tab = "t",
                refresh = "r",
                hide = "<C-[>",
                close = "X",
                details = "d",
                maximize = "+",
                minimize = "-"
            }
        },
        Branches = {
            default_height = 5,
        },
        global_keymaps = {
            -- example, change all Component's hide keymap to "h"
            -- hide = h
        },
        -- example, prefer "x" for hide only for Explorer component.
        -- Explorer = {
        --     keymaps = {
        --         hide = "x",
        --     }
        -- }
    },
    -- default panel groups to display on left and right.
    panels = {
        left = "explorer",
        right = "git"
    },
    -- panels defined by groups of components, user is free to redefine the defaults
    -- and/or add additional.
    panel_groups = {
        explorer = { explorer.Name, terminalbrowser.Name },
        terminal = { terminal.Name, },
        git = { changes.Name, commits.Name, branches.Name }
    },
    -- workspaces config
    workspaces = {
        -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
        auto_open = 'none',
    },
    -- default panel sizes for the different positions
    panel_sizes = {
        left = 30,
        right = 30,
        bottom = 15
    }
})
