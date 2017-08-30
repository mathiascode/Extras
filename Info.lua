g_PluginInfo =
{
	Name = "Extras",
	Version = "3",
	Date = "2017-08-30",
	SourceLocation = "https://github.com/mathiascode/Extras",
	Description = [[Plugin for Cuberite that adds extra functionality to the Kaboom.pw server.]],

	Commands =
	{
		["/actionbarbroadcast"] =
		{
			Alias = { "/abc", "/abcast", "/actionbarbc", "/actionbarbcast", },
			Handler = HandleActionBarBroadcastCommand,
			Permission = "extras.actionbarbroadcast",
			HelpString = "Broadcasts an action bar message"
		},
		["/clearchat"] =
		{
			Handler = HandleClearChatCommand,
			Permission = "extras.clearchat",
			HelpString = "Clears messages from the chat"
		},
		["/clearinventory"] =
		{
			Alias = { "/ci", "/clean", "/clearinvent", },
			Handler = HandleClearinventoryCommand,
			Permission = "extras.clearinventory",
			HelpString = "Clears the inventory of a player"
		},
		["/console"] =
		{
			Handler = HandleConsoleCommand,
			Permission = "extras.console",
			HelpString = "Broadcasts a message as the console"
		},
		["/day"] =
		{
			Handler = HandleDayCommand,
			Permission = "extras.day",
			HelpString = "Sets the time to day"
		},
		["/destroyentities"] =
		{
			Handler = HandleDestroyentitiesCommand,
			Permission = "extras.destroyentities",
			HelpString = "Destroys all entities in all worlds"
		},
		["/enchantall"] =
		{
			Handler = HandleEnchantAllCommand,
			Permission = "extras.enchantall",
			HelpString = "Adds every enchantment to a held item"
		},
		["/enchantment"] =
		{
			Handler = HandleEnchantmentCommand,
			Permission = "extras.enchantment",
			HelpString = "Adds an enchantment to a specified player's held item"
		},
		["/end"] =
		{
			Handler = HandleEndCommand,
			Permission = "extras.end",
			HelpString = "Moves your player to the End"
		},
		["/flatlands"] =
		{
			Handler = HandleFlatlandsCommand,
			Permission = "extras.flatlands",
			HelpString = "Moves your player to the Flatlands"
		},
		["/foodlevel"] =
		{
			Handler = HandleFoodLevelCommand,
			Permission = "extras.foodlevel",
			HelpString = "Sets the food level to the given value"
		},
		["/hub"] =
		{
			Alias = "/lobby",
			Handler = HandleHubCommand,
			Permission = "extras.hub",
			HelpString = "Moves your player to the Hub"
		},
		["/ienchantment"] =
		{
			Handler = HandleIenchantmentCommand,
			Permission = "extras.ienchantment",
			HelpString = "Adds an enchantment to an item"
		},
		["/importschematic"] =
		{
			Handler = HandleImportSchematicCommand,
			Permission = "extras.importschematic",
			HelpString = "Imports a schematic file to the server"
		},
		["/jumpscare"] =
		{
			Alias = "/scare",
			Handler = HandleJumpscareCommand,
			Permission = "extras.jumpscare",
			HelpString = "Scares a player"
		},
		["/killall"] =
		{
			Alias = "/mobkill",
			Handler = HandleKillallCommand,
			Permission = "extras.killall",
			HelpString = "Removes entities in your world"
		},
		["/kit"] =
		{
			Alias = "/kits",
			Handler = HandleKitCommand,
			Permission = "extras.kit",
			HelpString = "Spawns a predefined kit"
		},
		["/m"] =
		{
			Alias = "/t",
			Handler = HandleMessageCommand,
			Permission = "extras.m",
			HelpString = "Sends a private message to a player"
		},
		["/me"] =
		{
			Alias = { "/action", "/describe", },
			Handler = HandleMeCommand,
			Permission = "extras.me",
			HelpString = "Broadcasts what you are doing"
		},
		["/mem"] =
		{
			Alias = "/memory",
			Handler = HandleMemoryCommand,
			Permission = "extras.mem",
			HelpString = "Shows the memory usage of the server"
		},
		["/nether"] =
		{
			Handler = HandleNetherCommand,
			Permission = "extras.nether",
			HelpString = "Moves your player to the Nether"
		},
		["/nickname"] =
		{
			Alias = "/nick",
			Handler = HandleNickCommand,
			Permission = "extras.nickname",
			HelpString = "Changes your nickname on the server",
		},
		["/night"] =
		{
			Handler = HandleNightCommand,
			Permission = "extras.night",
			HelpString = "Sets the time to night"
		},
		["/overworld"] =
		{
			Handler = HandleOverworldCommand,
			Permission = "extras.overworld",
			HelpString = "Moves your player to the Overworld"
		},
		["/pumpkin"] =
		{
			Handler = HandlePumpkinCommand,
			Permission = "extras.pumpkin",
			HelpString = "Places a pumpkin on a player's head"
		},
		["/reply"] =
		{
			Handler = HandleReplyCommand,
			Permission = "extras.reply",
			HelpString = "Replies to the latest private message you recieved"
		},
		["/restart"] =
		{
			Handler = HandleRestartCommand,
			Permission = "extras.restart",
			HelpString = "Restarts the server"
		},
		["/rules"] =
		{
			Handler = HandleRulesCommand,
			Permission = "extras.rules",
			HelpString = "Shows the server's rules"
		},
		["/spidey"] =
		{
			Handler = HandleSpideyCommand,
			Permission = "extras.spidey",
			HelpString = "Shoots a line of web blocks until it hits a block"
		},
		["/starve"] =
		{
			Handler = HandleStarveCommand,
			Permission = "extras.starve",
			HelpString = "Sets your food level to zero"
		},
		["/suicide"] =
		{
			Alias = "/kill",
			Handler = HandleSuicideCommand,
			Permission = "extras.suicide",
			HelpString = "Ends your life"
		},
		["/tele"] =
		{
			Alias = { "/tp2p", "/teleport", "/tpo", },
			Handler = HandleTeleCommand,
			Permission = "extras.teleport",
			HelpString = "Teleports you to another player"
		},
		["/tellraw"] =
		{
			Handler = HandleTellrawCommand,
			Permission = "extras.tellraw",
			HelpString = "Broadcasts raw text to the server"
		},
                ["/title"] =
                {
			Handler = HandleTitleCommand,
			Permission = "extras.title",
			HelpString = "Broadcasts a title to the server"
		},
		["/tpohere"] =
		{
			Handler = HandleTpohereCommand,
			Permission = "extras.tpohere",
			HelpString = "Teleports a player to you"
		},
		["/tppos"] =
		{
			Handler = HandleTpposCommand,
			Permission = "extras.tppos",
			HelpString = "Teleports you directly to the specified coordinates"
		},
		["/unloadchunks"] =
		{
			Handler = HandleUnloadchunksCommand,
			Permission = "extras.unloadchunks",
			HelpString = "Unloads all unused chunks"
		},
		["/username"] =
		{
			Handler = HandleUsernameCommand,
			Permission = "extras.username",
			HelpString = "Changes your username on the server"
		},
		["/vote"] =
		{
			Handler = HandleVoteCommand,
			Permission = "extras.vote",
			HelpString = "Shows vote links for the server"
		},
		["/who"] =
		{
			Alias = { "/playerlist", "/online", "/plist", },
			Handler = HandleWhoCommand,
			Permission = "extras.who",
			HelpString = "Shows a list of connected players"
		},
		["/world"] =
		{
			Handler = HandleWorldCommand,
			Permission = "extras.world",
			HelpString = "Moves your player to a different world"
		},
	},
	Permissions =
	{
		["extras.foodlevel.other"] =
		{
			Description = "Allows a player to change the food level of another player",
		},

		["extras.kit.other"] =
		{
			Description = "Allows a player to give another player a kit",
		},

		["extras.starve.other"] =
		{
			Description = "Allows a player to make another player starve",
		},
	},
}
