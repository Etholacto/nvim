return {
  "mfussenegger/nvim-dap",
  ft = 'java',
  config = function()
    local dap = require('dap')
    local jdtls_dir = _G.packagePath .. '/jdtls'
    local path_to_jar = jdtls_dir ..
        '/plugins/org.eclipse.equinox.launcher.win32.win32.x86_64_1.2.900.v20240213-1244.jar'
    local path_to_config = jdtls_dir .. '/config_win'

    dap.adapters.java = {
      type = 'executable',
      command = 'java',
      args = {
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_to_jar,
        '-configuration', path_to_config,
        '-data', 'C:/Users/Cedric/.workspace/java'
      },
    }

    dap.configurations.java = {
      type = 'java',
      name = 'Debug (Attach) - Remote',
      hostName = "127.0.0.1",
      port = 5005,
    }
  end
}
