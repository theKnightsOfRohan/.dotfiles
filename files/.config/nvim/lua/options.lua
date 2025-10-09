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
vim.opt.signcolumn = "yes:1"
vim.opt.completeopt:append('fuzzy')
vim.o.winborder = "rounded"
vim.g.netrw_banner = 0

vim.keymap.set("i", ";;", "<Esc>$a;", { noremap = true, silent = true })
vim.keymap.set("n", ";;", ";", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>re", ":<Up><CR>", { noremap = true, silent = true })

-- Copy highlighted selection to clipboard
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Quick save
vim.keymap.set("n", "<leader>s", function()
    vim.lsp.buf.format()
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
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

vim.keymap.set("v", "J", ":m+1<CR>gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m-2<CR>gv", { noremap = true, silent = true })

vim.keymap.set("n", "M", vim.cmd.Man, { noremap = true, silent = true })

vim.keymap.set("n", "<Esc>", vim.cmd.noh, { noremap = true, silent = true })

vim.keymap.set("n", "<S-CR>", "o<Esc>", { noremap = true, silent = true })

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
        error(err)
    end
end, { range = true })

-- Define the command
vim.api.nvim_create_user_command('MD2PDF', function()
    -- Get the full path of the current buffer
    local full_path = vim.fn.expand('%:p')

    -- Print the full path
    print("Converting " .. full_path .. "...")

    assert(vim.bo.filetype == "markdown", "Cannot convert a non-markdown file to a PDF")

    vim.system({ "md2pdf", full_path }, nil, function(_)
        print("Conversion completed!")
    end);
end, {})

vim.keymap.set("n", "<leader>md", vim.cmd.MD2PDF, { silent = false });

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "md", "markdown" },
    callback = function()
        vim.schedule(function()
            vim.keymap.set("v", "<leader>b", "c**<Esc>pa**<Esc>", { buffer = true })
            vim.keymap.set("v", "<leader>i", "c*<Esc>pa*<Esc>", { buffer = true })
        end)
    end
})

vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    once = true,
    callback = function()
        print("Netrw moved cursor")
    end
})

vim.api.nvim_create_user_command("Debug", function(opts)
    local lang = opts.fargs[1]
    local source_cmd = 'horizontal terminal voltron view command "source list -a \\$pc -c 30" -E -F'
    if lang ~= nil then
        source_cmd = source_cmd .. " --lexer " .. lang
    end

    require("here-term").toggle_terminal()
    vim.cmd(source_cmd)
    vim.cmd([[
        wincmd j
        resize 10
        startinsert
    ]])
end, { nargs = "?" })

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd("startinsert")
    end
})

vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        vim.api.nvim_feedkeys("q", "t", true)
    end
})

vim.keymap.set("n", "<leader>g", function()
    vim.cmd([[
        terminal lazygit
        startinsert
    ]])
end)

vim.api.nvim_create_user_command("Pyrun", function(_)
    local filepath = vim.fn.expand("%:p")
    vim.cmd("!python3 " .. filepath)
end, { nargs = 0 })
