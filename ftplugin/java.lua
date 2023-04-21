local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
end

local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local configs_dir = jdtls_dir .. '/config_win'
local plugins_dir = jdtls_dir .. '/plugins'
local path_to_jar = plugins_dir .. '/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
local path_to_lombok = jdtls_dir .. '/lombok.jar'

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".idea", ".vs" }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. 'site/java/workspace-root' .. project_name
os.execute("mkdir" .. workspace_dir)

local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        'java', -- or '/path/to/java17_or_newer/bin/java'

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. path_to_lombok,
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', path_to_jar,
        '-configuration', configs_dir,
        '-data', workspace_dir,
    },
    settings = {
        java = {
            home = 'C:/Program Files/Java/jdk-17',
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "C:/Program Files/Java/jdk-17",
                    },
                    {
                        name = "JavaSE-11",
                        path = "C:/Program Files/Eclipse Adoptium/jdk-11.0.14.101-hotspot",
                    }
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = {},
    },
}

config['on_attach'] = function(client, bufnr)
    require 'keymaps'.map_java_keys(bufnr);
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
