require("etholacto")

for _, filename in ipairs(vim.fn.globpath(vim.fn.stdpath('config')..'/config/', '*.lua', true, true)) do
  dofile(filename)
end
