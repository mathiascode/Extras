CanMessage = {}
NickList = {}
IsInside = {}
ExplosionCount = 0
GlobalTime = 0
MobCount = 0
TNTCount = 0

function Initialize(Plugin)
	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(g_PluginInfo.Version)

	cPluginManager:AddHook(cPluginManager.HOOK_CHAT, OnChat)
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

	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")
	RegisterPluginInfoCommands()

	LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function OnPluginsLoaded()
	cPluginManager:CallPlugin("WorldEdit", "AddHook", "OnAreaChanging", "Extras", "WorldEditCallback")
	Area = cBlockArea()
        Area:LoadFromSchematicFile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/spawn.schematic")
end

function OnDisable()
	LOG("Disabled " .. cPluginManager:GetCurrentPlugin():GetName() .. "!")
end
