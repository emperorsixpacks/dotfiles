local M = {}

M.loadPythonEnv = function()
    -- Get the virtual environment path
    local handle = io.popen("echo $VIRTUAL_ENV")
    local venv_path = handle:read("*a")
    handle:close()

    -- Trim whitespace
    venv_path = venv_path:gsub("%s+", "")

    -- Default to system Python if no virtual environment is detected
    if venv_path == "" then
        return nil
    end

    -- Construct the Python path inside the virtual environment
    local python_path = venv_path .. "/bin/python"

    -- Set Neovim's Python provider
    vim.g.python3_host_prog = python_path

    return python_path
end

return M

