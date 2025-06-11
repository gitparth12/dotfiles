-- Constants
MODIFIERS = { "cmd" } -- Modifiers used for app shortcuts

-- App configuration
APPS = {
	{ shortcut = "1", name = "Ghostty" },
	{ shortcut = "2", name = "Zen" },
	{ shortcut = "3", name = "Visual Studio Code" },
	{ shortcut = "4", name = "Logseq" },
	{ shortcut = "5", name = "Zotero" },
	{ shortcut = "6", name = "Mail" },
	{ shortcut = "7", name = "Slack" },
	{ shortcut = "8", name = "Spotify" },
}

-- Bind application shortcuts
for _, app in ipairs(APPS) do
	hs.hotkey.bind(MODIFIERS, app.shortcut, function()
		hs.application.launchOrFocus(app.name)
	end)
end
