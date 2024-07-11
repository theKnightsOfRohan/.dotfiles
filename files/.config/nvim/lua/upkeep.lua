return function()
    vim.cmd("Lazy! update")

    vim.cmd("Lazy! load all")

    vim.api.nvim_create_autocmd('User', {
        pattern = 'MasonUpdateAllComplete',
        callback = function()
            vim.cmd("Q")
        end,
    })

    vim.cmd("MasonUpdateAll")
end
