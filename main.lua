CanMessage = {}
NickList = {}
TitleShown = {}
HasTeleported = {}
CommandBlockActive = {}
HideOutput = {}
ExplosionCount = 0
GlobalTime = 0
--PingTime = 0

function Initialize(Plugin)
	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(g_PluginInfo.Version)

	cPluginManager:AddHook(cPluginManager.HOOK_CHAT, OnChat)
	cPluginManager:AddHook(cPluginManager.HOOK_ENTITY_CHANGING_WORLD, OnEntityChangingWorld)
	cPluginManager:AddHook(cPluginManager.HOOK_ENTITY_TELEPORT, OnEntityTeleport)
	cPluginManager:AddHook(cPluginManager.HOOK_EXECUTE_COMMAND, OnExecuteCommand)
	cPluginManager:AddHook(cPluginManager.HOOK_EXPLODING, OnExploding)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_JOINED, OnPlayerJoined)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK, OnPlayerRightClick)
	cPluginManager:AddHook(cPluginManager.HOOK_PLUGINS_LOADED, OnPluginsLoaded)
	cPluginManager:AddHook(cPluginManager.HOOK_SERVER_PING, OnServerPing)
	cPluginManager:AddHook(cPluginManager.HOOK_SPAWNING_ENTITY, OnSpawningEntity)
	cPluginManager:AddHook(cPluginManager.HOOK_TICK, OnTick)
	cPluginManager:AddHook(cPluginManager.HOOK_UPDATING_SIGN, OnUpdatingSign)

	-- Write config
	local Config = cIniFile()
	Config:ReadFile(Plugin:GetLocalFolder() .. "/config.ini")

	if Config:GetNumKeyComments("Join Titles") == 0 then
		Config:AddKeyComment("Join Titles", "Text that shows up in the center of a player's screen when joining")
	end
	JoinTitlesActive = Config:GetValueSetB("Join Titles", "Enable", true)
	TitleText = Config:GetValueSet("Join Titles", "TitleText", "Welcome to Kaboom.pw!")
	TitleColor = Config:GetValueSet("Join Titles", "TitleColor", "LightGray")
	SubtitleText = Config:GetValueSet("Join Titles", "SubtitleText", "Free OP • Anarchy • Creative")
	SubtitleColor = Config:GetValueSet("Join Titles", "SubtitleColor", "White")

	if Config:GetNumKeyComments("OP On Join") == 0 then
		Config:AddKeyComment("OP On Join", "Enables or disables auto-OP of players on join, if a rank with the name \"op\" exists")
	end
	OPMode = Config:GetValueSetB("OP On Join", "Enable", false)

	if Config:GetNumKeyComments("Commands") == 0 then
		Config:AddKeyComment("Commands", "Whether or not to disable commands that may be too abusive for OP players, such as /ban and /kick")
	end
        DisableHarmfulCommands = Config:GetValueSetB("Commands", "DisableHarmfulCommands", false)

	if Config:GetNumKeyComments("Anti-SPAM") == 0 then
                Config:AddKeyComment("Anti-SPAM", "Whether or not to limit the number of chat messages and commands a player can send in a short amount of time")
        end
	ChatAntiSpam = Config:GetValueSetB("Anti-SPAM", "EnableChatAntiSpam", true)
	CommandAntiSpam = Config:GetValueSetB("Anti-SPAM", "EnableCommandAntiSpam", true)

	if Config:GetNumKeyComments("WorldEdit") == 0 then
                Config:AddKeyComment("WorldEdit", "Additional options for WorldEdit, if WorldEdit is enabled")
        end
	WorldEditLimits = Config:GetValueSetB("WorldEdit", "LimitWorldEditRadius", true)

	Config:WriteFile(Plugin:GetLocalFolder() .. "/config.ini")

	-- Load areas
	TitleEnd = cCuboid(Vector3i(-21.5, 63, 6.5), Vector3i(-11.5, 63 + 22, 22.5))
	TitleFlatlands = cCuboid(Vector3i(12.5, 63, 6.5), Vector3i(22.5, 63 + 22, 22.5))
	TitleNether = cCuboid(Vector3i(-10.5, 63, 6.5), Vector3i(-0.5, 63 + 22, 22.5))
	TitleOverworld = cCuboid(Vector3i(1.5, 63, 6.5), Vector3i(11.5, 63 + 22, 22.5))

	PortalEnd = cCuboid(Vector3i(-19.5, 63, 22.5), Vector3i(-13.5, 63 + 9, 24.5))
	PortalFlatlands = cCuboid(Vector3i(14.5, 63, 22.5), Vector3i(20.5, 63 + 9, 24.5))
	PortalNether = cCuboid(Vector3i(-8.5, 63, 22.5), Vector3i(-2.5, 63 + 9, 24.5))
	PortalOverworld = cCuboid(Vector3i(3.5, 63, 22.5), Vector3i(9.5, 63 + 9, 24.5))

	-- Load hub schematic
	if cRoot:Get():GetWorld("hub") then
		SpawnArea = cBlockArea()
		SpawnArea:LoadFromSchematicFile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/spawn.schematic")
		SpawnArea:Write(cRoot:Get():GetWorld("hub"), SpawnArea:GetWEOffset().x, 62, SpawnArea:GetWEOffset().z, cBlockArea.baTypes + cBlockArea.baMetas)
	end

	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")
	RegisterPluginInfoCommands()

	LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function OnPluginsLoaded()
	cPluginManager:CallPlugin("WorldEdit", "AddHook", "OnAreaChanging", "Extras", "WorldEditCallback")
end

function OnDisable()
	LOG("Disabled " .. cPluginManager:GetCurrentPlugin():GetName() .. "!")
end
