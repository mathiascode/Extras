CanMessage = {}
NickList = {}
TitleShown = {}
HasTeleported = {}
CommandBlockActive = {}
HideOutput = {}
ExplosionCount = 0
GlobalTime = 0

function Initialize(Plugin)
	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(g_PluginInfo.Version)

	cPluginManager:AddHook(cPluginManager.HOOK_CHAT, OnChat)
	cPluginManager:AddHook(cPluginManager.HOOK_ENTITY_CHANGING_WORLD, OnEntityChangingWorld)
	cPluginManager:AddHook(cPluginManager.HOOK_EXECUTE_COMMAND, OnExecuteCommand)
	cPluginManager:AddHook(cPluginManager.HOOK_EXPLODING, OnExploding)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_JOINED, OnPlayerJoined)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_PLACING_BLOCK, OnPlayerPlacingBlock)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK, OnPlayerRightClick)
	cPluginManager:AddHook(cPluginManager.HOOK_PLUGINS_LOADED, OnPluginsLoaded)
	cPluginManager:AddHook(cPluginManager.HOOK_SERVER_PING, OnServerPing)
	cPluginManager:AddHook(cPluginManager.HOOK_SPAWNING_ENTITY, OnSpawningEntity)
	cPluginManager:AddHook(cPluginManager.HOOK_TICK, OnTick)
	cPluginManager:AddHook(cPluginManager.HOOK_UPDATING_SIGN, OnUpdatingSign)

	-- Load areas
	TitleEnd = cCuboid(Vector3i(-21.5, 63, 6.5), Vector3i(-11.5, 63 + 22, 22.5))
	TitleFlatlands = cCuboid(Vector3i(12.5, 63, 6.5), Vector3i(22.5, 63 + 22, 22.5))
	TitleNether = cCuboid(Vector3i(-10.5, 63, 6.5), Vector3i(-0.5, 63 + 22, 22.5))
	TitleOverworld = cCuboid(Vector3i(1.5, 63, 6.5), Vector3i(11.5, 63 + 22, 22.5))

	PortalEnd = cCuboid(Vector3i(-19.5, 63, 21.5), Vector3i(-13.5, 63 + 9, 23.5))
	PortalFlatlands = cCuboid(Vector3i(13.5, 63, 21.5), Vector3i(19.5, 63 + 9, 23.5))
	PortalNether = cCuboid(Vector3i(-8.5, 63, 21.5), Vector3i(-2.5, 63 + 9, 23.5))
	PortalOverworld = cCuboid(Vector3i(2.5, 63, 21.5), Vector3i(8.5, 63 + 9, 23.5))

	-- Load hub schematic
	Area = cBlockArea()
        Area:LoadFromSchematicFile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/spawn.schematic")

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
