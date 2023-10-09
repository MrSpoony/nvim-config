local dap = require("dap")

Nnoremap("<leader>dc", function()
	require("dapui").open()
	dap.continue()
end)

Nnoremap("<C-Y>", dap.step_back)
Nnoremap("<C-M>", dap.step_out)

Nnoremap("<C-E>", dap.step_into)
Nnoremap("<C-N>", dap.step_over)

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
