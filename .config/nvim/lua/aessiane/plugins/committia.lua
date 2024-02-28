-- Plugin: committia.vim
local WAITING_MESSAGE = "Generating commit message..."

local splitText = function(text)
	local lines = {}
	for s in text:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end
	return lines
end

local insert_lines_at_beginning = function(lines)
	-- Check if the first line is our waiting message
	if vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == WAITING_MESSAGE then
		-- Remove the waiting message
		vim.api.nvim_buf_set_lines(0, 0, 1, false, {})
	end

	vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

local insert_generated_commit_information = function(obj)
	vim.schedule(function()
		local lines = {}
		if obj.code ~= 0 then
			lines = { "Error running AI to generate commit message, please write your own commit message" }
		elseif obj == nil or obj.stdout == nil then
			lines = { "No output from AI, please write your own commit message" }
		else
			lines = splitText(obj.stdout)

			-- Add an empty line between the short description and the body
			table.insert(lines, 2, "")
		end

		insert_lines_at_beginning(lines)
	end)
end

vim.g.committia_hooks = {
	edit_open = function(info)
		-- If no commit message, generate one
		if info.vcs == 'git' and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == '' then
			insert_lines_at_beginning({ WAITING_MESSAGE })
			-- Read the contents of the diff buffer
			local diff_bufnr = info.diff_bufnr
			local diff_buffer_content = vim.api.nvim_buf_get_lines(diff_bufnr, 0,
				vim.api.nvim_buf_line_count(diff_bufnr),
				false)

			-- Run the shell companion to generate the commit message
			local command = vim.system({ 'poetry', 'run', 'ai', 'git' },
				{ text = true, cwd = '/Users/aessiane/1.Projects/shell-companion/shell-companion/', stdin = true },
				insert_generated_commit_information)
			command:write(diff_buffer_content)
			command:write(nil)
		end
	end
}

--end
