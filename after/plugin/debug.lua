local dap = require("dap")

Nnoremap("<leader>dc", function()
    require("dapui").open()
    dap.continue()
end)

Nnoremap("<C-Y>", dap.step_back)
Nnoremap("<C-M>", dap.step_out)

Nnoremap("<C-E>", dap.step_into)
Nnoremap("<C-N>", dap.step_over)
Nnoremap("<C-U>", dap.continue)

Nnoremap("<leader>dr", dap.restart)

Nnoremap("<leader>ds", function()
    dap.close()
    require("dapui").close()
end)

Nnoremap("<leader>du", function()
    require("dapui").toggle()
end)

Nnoremap("<leader>dd", dap.toggle_breakpoint)
Nnoremap("<leader>dt", function()
    vim.ui.input("Breakpoint condition: ", dap.toggle_breakpoint)
end)
Nnoremap("<leader>da", dap.clear_breakpoints)

dap.adapters.ghc = {
    type = "executable",
    command = "haskell-debug-adapter",
    -- args = { "debug" },
}

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "OpenDebugAD7",
}

-- Execute codelldb --port 13000
dap.adapters.codelldb = {
    id = "codelldb",
    type = "server",
    host = "127.0.0.1",
    port = 13000,
    executable = {
        command = "codelldb",
        args = { "--port", "13000" },
    },
}

local function get_cpp_program(type)
    local typeflag = "-ggdb "
    if type == "codelldb" then
        typeflag = "--debug "
    end
    local flags = "-Wall -Wextra -fdiagnostics-color=never -Wno-sign-compare -std=c++20 "
        .. typeflag
        .. vim.fn.expand("%:p")
        .. " -o "
        .. vim.fn.expand("%:p:r")
    local j = require("plenary.job"):new({
        command = "g++",
        args = vim.split(flags, " "),
        on_stderr = function(_, data)
            require("notify")("Compilation failed: \n" .. data)
        end,
        on_stdout = function(_, data)
            require("notify")("Compilation failed: \n" .. data)
        end,
    })
    local _, code = j:sync()
    if code ~= 0 then
        return nil
    else
        return vim.fn.expand("%:p:r")
    end
end

dap.configurations.cpp = {
    {
        name = "Launch file (cppdbg)",
        type = "cppdbg",
        request = "launch",
        program = function()
            return get_cpp_program()
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
    },
    {
        name = "Launch file (codelldb)",
        type = "codelldb",
        request = "launch",
        program = function()
            return get_cpp_program("codelldb")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
        terminal = "integrated",
    },
}

dap.configurations.haskell = {
    {
        type = "ghc",
        request = "launch",
        name = "haskell(stack)",
        workspace = "${workspaceFolder}",
        startup = "${workspaceFolder}/app/Main.hs",
        startupFunc = "", -- defaults to 'main' if not set
        startupArgs = "",
        stopOnEntry = false,
        mainArgs = "",
        ghciEnv = vim.empty_dict(),
        ghciPrompt = "λ: ",
        ghciInitialPrompt = "ghci> ",
        ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
        forceInspect = false,
        logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
        logLevel = "Warning",
    },
    {
        type = "ghc",
        request = "launch",
        name = "haskell(cabal)",
        internalConsoleOptions = "openOnSessionStart",
        workspace = "${workspaceFolder}",
        startup = "${workspaceFolder}/app/Main.hs",
        startupFunc = "",
        startupArgs = "",
        stopOnEntry = false,
        mainArgs = "",
        ghciPrompt = "H>>= ",
        ghciInitialPrompt = "> ",
        ghciCmd = "cabal repl -w ghci-dap --repl-no-load --builddir=${workspaceFolder}/.vscode/dist-cabal-repl",
        ghciEnv = {},
        logFile = "${workspaceFolder}/.vscode/phoityne.log",
        logLevel = "WARNING",
        forceInspect = false,
    },
}
