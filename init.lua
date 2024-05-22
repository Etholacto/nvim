require("etholacto.core")
require("etholacto.lazy")
vim.api.nvim_exec('language en_UK', true)
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            require('persistence').load()
        end, 25) -- Delay in milliseconds
    end
})
