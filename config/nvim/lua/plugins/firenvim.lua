local blacklistedSites = {
	-- [[.*twitch\.tv.*]],
	[[ https?://mail.google.com/ ]],
	[[ https?://mail.discord.com/ ]],
	-- [[.*discord\.com.*]],
	-- [[*twitter\.com.*]],
	-- [[*koyu\.space.*]],
}

local localSettings = {
	[".*"] = {
		cmdline = "neovim",
		content = "text",
		priority = 0,
		selector = "textarea",
		takeover = "always",
	},
}

local globalSettings = {
	alt = "all",
}
for _, site in pairs(blacklistedSites) do
	localSettings[site] = { takeover = "never", priority = 1 }
end

vim.g.firenvim_config = {
	localSettings = localSettings,
	globalSettings = globalSettings,
}

vim.cmd([[
au BufEnter github.com_*.txt set filetype=markdown
au BufEnter reddit.com_*.txt set filetype=markdown
]])
