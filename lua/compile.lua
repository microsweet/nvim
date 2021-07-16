local M = {}
function M.CompileRunGcc()
    vim.cmd[[
        exec "w"
    ]]
    local filetype = vim.bo.filetype
    if (filetype == 'c')
    then
        vim.cmd[[
            exec "!g++ % -o %<"
            exec "!time ./%<"
        ]]
    elseif (filetype == 'cpp')
    then
        vim.cmd[[
            set splitbelow
            exec "!g++ -std=c++11 % -Wall -o %<"
            :sp
            :res -15
            :term ./%<
        ]]
    elseif (filetype == 'java')
    then
        vim.cmd[[
            exec "!javac %"
            exec "!time java %<"
        ]]
    elseif (filetype == 'sh')
    then
        vim.cmd[[
        :!time bash %
        ]]
    elseif (filetype == 'python')
    then
        vim.cmd[[
            set splitbelow
            "set splitright
            :sp
            :term python3 %
        ]]
    elseif (filetype == 'html')
    then
        vim.cmd[[exec "!chromium % &"]]
    elseif (filetype == 'markdown')
    then
        vim.cmd[[exec "MarkdownPreview"]]
    elseif (filetype == 'tex')
    then
        vim.cmd[[
            silent! exec "VimtexStop"
            silent! exec "VimtexCompile"
        ]]
    elseif (filetype == 'go')
    then
        vim.cmd[[
            set splitbelow
            :sp
            :term go run .
        ]]
    end
end

return M
