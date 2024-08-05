-- Vim command remaps
vim.g.mapleader = ";"

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.fillchars = { eob = " " }
vim.opt.scrolloff = 10
vim.opt.timeoutlen = 500
vim.opt.updatetime = 100
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.g.netrw_banner = 0

vim.api.nvim_command("command! Q quitall")
vim.keymap.set("i", ";;", "<Esc>$a;", { noremap = true, silent = true })

-- Window navigation
for _, dir in ipairs({ "h", "j", "k", "l" }) do
    vim.keymap.set("n", ("m%s"):format(dir), function()
        vim.cmd("wincmd " .. dir)
    end)
end

-- Copy highlighted selection to clipboard
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Quick save
vim.keymap.set("n", "<leader>s", function()
    vim.cmd("silent write")
    vim.cmd("silent lua vim.lsp.buf.format()")
    vim.cmd.write()
    vim.diagnostic.show(nil, 0)
end, { noremap = true, silent = true })

-- Visual mode bracket surround
-- I need this because the autoclose.nvim plugin is only for insert mode
-- It can sometimes be a little buggy, but that's what formatters are for
local surrounders = {
    ["{"] = "}",
    ["("] = ")",
    ["["] = "]",
    ["'"] = "'",
    ['"'] = '"',
    ["`"] = "`",
    ["<"] = ">",
}

for open, close in pairs(surrounders) do
    vim.keymap.set("v", open, "c" .. open .. close .. "<Esc>hp", { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("TextYankPost", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 50,
        })
    end,
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("n", "<S-m>", vim.cmd.Man, { noremap = true, silent = true })

vim.keymap.set("n", "<Esc>", vim.cmd.noh, { noremap = true, silent = true })

vim.keymap.set("n", "<S-CR>", "o<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Record", function()
    vim.api.nvim_command("silent normal! qa")
end, {})

vim.api.nvim_create_user_command("StopRecord", function()
    vim.api.nvim_command("silent normal! q")
end, {})

vim.api.nvim_create_user_command("Preview", function()
    vim.api.nvim_command("silent !open " .. vim.fn.expand("%:p"))
end, {})

-- Create a user command to open the selected text as a URL
vim.api.nvim_create_user_command("URL", function(opts)
    _ = opts


    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end

    local url = table.concat(lines, '\n')

    -- Open the URL using vim.ui.open
    -- print("Opening " .. url)
    local _, err = vim.ui.open(url)

    if err ~= nil then
        vim.api.nvim_err_writeln(err)
    end
end, { range = true })
