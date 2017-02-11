-- Quick settings
local Rules = "Do whatever you want! ;)"

-- General
function None() end

function HandleActionBarBroadcastCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():ForEachPlayer(
			function(OtherPlayer)
				OtherPlayer:SendAboveActionBarMessage(Message)
			end
		)
	end
	return true
end

function HandleBroadcastCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random) :gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat(cChatColor.Red .. "[BROADCAST] " .. cChatColor.Rose .. Message)
	end
	return true
end

function HandleClearChatCommand(Split, Player)
	for i=1,100 do
		cRoot:Get():BroadcastChat("")
	end
	cRoot:Get():BroadcastChatSuccess("The chat has been cleared")
	return true
end

function HandleCommandBlockCommand(Split, Player)
	local SetCommand = function(CommandBlock)
		local ChangeCommand = tolua.cast(CommandBlock, "cCommandBlockEntity")
		CommandBlock:SetCommand(table.concat(Split, " ", 3))
	end

	local GetOutput = function(CommandBlock)
		local ChangeCommand = tolua.cast(CommandBlock, "cCommandBlockEntity")
		Output = CommandBlock:GetLastOutput()
	end

	local LookPos = GetPlayerLookPos(Player)

	if Split[2] == "set" then
		if not Player:GetWorld():DoWithBlockEntityAt(LookPos.x, LookPos.y, LookPos.z, SetCommand) then
			Player:SendMessageInfo("You have to look at a command block to set its command")
		else
			Player:SendMessageSuccess("Successfully set command for command block. Activate it with redstone, and type \"/commandblock result\" while looking at the command block to see its result")
		end
	elseif Split[2] == "result" then
		if not Player:GetWorld():DoWithBlockEntityAt(LookPos.x, LookPos.y, LookPos.z, GetOutput) then
			Player:SendMessageInfo("You have to look at a command block to get its result")
		else
			Player:SendMessage(cChatColor.Bold .. "The result of the command block:")
			Player:SendMessage(Output)
		end
	else
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <set|result> [command ...]")
	end
	return true
end

function HandleConsoleCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local Message = table.concat(Split, " " , 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose) :gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random) :gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat(cChatColor.Gray .. "[CONSOLE] " .. cChatColor.White .. Message)
	end
	return true
end

function HandleDeopCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player>")
	else
		local PlayerName = Split[2]

		cRoot:Get():ForEachPlayer(
			function(OtherPlayer)
				local PlayerUUID
				if OtherPlayer:GetName() == PlayerName then
					PlayerUUID = OtherPlayer:GetUUID()
				elseif cRoot:Get():GetServer():ShouldAuthenticate() then
					PlayerUUID = cMojangAPI:GetUUIDFromPlayerName(PlayerName)
				else
					PlayerUUID = cClientHandle:GenerateOfflineUUID(PlayerName)
				end

				cRankManager:SetPlayerRank(PlayerUUID, PlayerName, "deop")

				if OtherPlayer:GetName() == PlayerName then
					OtherPlayer:LoadRank()
					OtherPlayer:SendMessageInfo("Your OP status has been removed")
				end
			end
		)

		if cRoot:Get():GetServer():ShouldAuthenticate() and cMojangAPI:GetUUIDFromPlayerName(PlayerName) == "" then
			Player:SendMessageFailure("Player \"" .. PlayerName .. "\" not found")
		else
			Player:SendMessageSuccess("Successfully removed OP status from player \"" .. PlayerName .. "\"")
		end
	end
	return true
end

function HandleDestroyentitiesCommand(Split, Player)
	cRoot:Get():QueueExecuteConsoleCommand("destroyentities")
	Player:SendMessageSuccess("Successfully destroyed all entities in every world")
	return true
end

function HandleEnchantAllCommand(Split, Player)
	if Player:GetEquippedItem():IsEmpty() then
		Player:SendMessageFailure("Please hold an item in your hand to enchant it")
	else
		local ItemEnchant = Player:GetEquippedItem().m_Enchantments
		ItemEnchant:SetLevel(0, 1000)
		ItemEnchant:SetLevel(1, 1000)
		ItemEnchant:SetLevel(2, 1000)
		ItemEnchant:SetLevel(3, 1000)
		ItemEnchant:SetLevel(4, 1000)
		ItemEnchant:SetLevel(5, 1000)
		ItemEnchant:SetLevel(6, 1000)
		ItemEnchant:SetLevel(7, 1000)
		ItemEnchant:SetLevel(8, 1000)
		ItemEnchant:SetLevel(16, 1000)
		ItemEnchant:SetLevel(17, 1000)
		ItemEnchant:SetLevel(18, 1000)
		ItemEnchant:SetLevel(19, 1000)
		ItemEnchant:SetLevel(20, 1000)
		ItemEnchant:SetLevel(21, 1000)
		ItemEnchant:SetLevel(32, 1000)
		ItemEnchant:SetLevel(33, 1000)
		ItemEnchant:SetLevel(34, 1000)
		ItemEnchant:SetLevel(35, 1000)
		ItemEnchant:SetLevel(48, 1000)
		ItemEnchant:SetLevel(49, 1000)
		ItemEnchant:SetLevel(50, 1000)
		ItemEnchant:SetLevel(51, 1000)
		ItemEnchant:SetLevel(61, 1000)
		ItemEnchant:SetLevel(62, 1000)
		ItemEnchant:SetLevel(70, 1000)
		Player:GetInventory():SetHotbarSlot(Player:GetInventory():GetEquippedSlotNum(), Player:GetEquippedItem())
		Player:SendMessageSuccess("You have all those enchantments now. ;)")
	end
	return true
end

function HandleFoodLevelCommand(Split, Player)
	local FoodLevel = function(OtherPlayer)
		OtherPlayer:SetFoodLevel(tonumber(Split[2]))
		OtherPlayer:SetFoodSaturationLevel(5)
		OtherPlayer:SetFoodExhaustionLevel(0)
		OtherPlayer:SendMessageInfo("Your food level has been set to " .. Player:GetFoodLevel())
		if Split[3] ~= nil and Split[3] ~= "*" and Split[3] ~= "**" then
			Player:SendMessageSuccess("Successfully set food level of player \"" .. OtherPlayer:GetName() .. "\" to " .. OtherPlayer:GetFoodLevel())
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <level> [player]")
	elseif Split[3] == nil then
		FoodLevel(Player)
	elseif Split[3] == "*" or Split[3] == "**" then
		cRoot:Get():ForEachPlayer(FoodLevel)
		Player:SendMessageSuccess("Successfully set food level of every player to " .. tonumber(Split[2]))
	elseif Player:HasPermission("extras.foodlevel.other") then
		if not cRoot:Get():FindAndDoWithPlayer(Split[3], FoodLevel) then
			Player:SendMessageFailure("Player \"" .. Split[3] .. "\" not found")
		end
	end
	return true
end

function HandleJumpscareCommand(Split, Player)
	local Jumpscare = function(OtherPlayer)
		local X = OtherPlayer:GetPosX()
		local Y = OtherPlayer:GetPosY()
		local Z = OtherPlayer:GetPosZ()
		OtherPlayer:GetWorld():BroadcastParticleEffect("mobappearance", X, Y, Z, 0, 0, 0, 1, 4)
		for i=1,10 do
			if OtherPlayer:GetClientHandle():GetProtocolVersion() <= 47 then
				OtherPlayer:GetClientHandle():SendSoundEffect("mob.endermen.scream", X, Y, Z, 1, 0)
			else
				OtherPlayer:GetClientHandle():SendSoundEffect("entity.endermen.scream", X, Y, Z, 1, 0)
			end
		end
		if not Split[2] == "*" or not Split[2] == "**" then
			Player:SendMessageSuccess("Successfully created jumpscare for player \"" .. OtherPlayer:GetName() .. "\"")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: ".. Split[1] .." <player>")
	elseif Split[2] == "*" or Split[2] == "**" then
		cRoot:Get():ForEachPlayer(Jumpscare)
		Player:SendMessageSuccess("Successfully created jumpscare for every player")
	elseif not cRoot:Get():FindAndDoWithPlayer(Split[2], Jumpscare) then
		Player:SendMessageFailure("Player \"" .. Split[2] ..  "\" not found")
	end
	return true
end

function HandleKitCommand(Split, Player)
	local Kit = function(OtherPlayer)
		if Split[2] == "weapons" then
			local Item = cItem(E_ITEM_BLAZE_ROD)
			Item.m_CustomName = "§rNuker"
			Item.m_Lore = "§cBOOM!"
			OtherPlayer:GetInventory():AddItem(Item)

			local Item = cItem(E_ITEM_STICK)
			Item.m_CustomName = "§rLightning Stick"
			Item.m_Lore = "§eSmite those fools!"
			OtherPlayer:GetInventory():AddItem(Item)

			local Item = cItem(E_ITEM_DIAMOND_HORSE_ARMOR)
			Item.m_CustomName = "§rSniper"
			Item.m_Lore = "§rSneaky!"
			OtherPlayer:GetInventory():AddItem(Item)
			OtherPlayer:SendMessageInfo("You have received kit \"" .. Split[2] .. "\"")
			if Split[3] ~= nil and Split[3] ~= "*" and Split[3] ~= "**" then
				Player:SendMessageSuccess("Successfully gave kit \"" .. Split[2] .. "\" to player \"" .. OtherPlayer:GetName() .. "\"")
			end
		else
			Player:SendMessageFailure("Invalid kit")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <name> [player]")
		Player:SendMessageInfo("Available kits: weapons")
	elseif Split[3] == nil then
		Kit(Player)
	elseif Player:HasPermission("extras.kit.other") then
		if Split[3] == "*" or Split[3] == "**" then
			cRoot:Get():ForEachPlayer(Kit)
			Player:SendMessageSuccess("Successfully gave kit \"" .. Split[2] .. "\" to every player")
		elseif not cRoot:Get():FindAndDoWithPlayer(Split[3], Kit) then
			Player:SendMessageFailure("Player \"" .. Split[3] .. "\" not found")
		end
	end
	return true
end

function HandleMeCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local PlayerName
		if NickList[Player:GetUUID()] == nil then
			PlayerName = Player:GetName()
		else
			PlayerName = NickList[Player:GetUUID()]
		end
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random) :gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat("* " .. PlayerName .. " " .. cChatColor.White .. Message)
	end
	return true
end

function HandleMemoryCommand( Split, Player )
	Player:SendMessageInfo("Current RAM usage: " .. cRoot:GetPhysicalRAMUsage() / 1024 .. " MB")
	Player:SendMessageInfo("Current swap usage: " .. cRoot:GetVirtualRAMUsage() / 1024 .. " MB")
	Player:SendMessageInfo("Total memory usage: " .. cRoot:GetPhysicalRAMUsage() / 1024 + cRoot:GetVirtualRAMUsage() / 1024 .. " MB")
	Player:SendMessageInfo("Current loaded chunks: " .. cRoot:Get():GetTotalChunkCount())
	return true
end

function HandleNickCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <nickname ...>")
		return true
	elseif Split[2] == "off" then
		Player:SendMessageInfo("You no longer have a nickname")
		NickList[Player:GetUUID()] = nil
	else
		NickList[Player:GetUUID()] = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		Player:SendMessageSuccess("Successfully set your nickname to " .. NickList[Player:GetUUID()])
	end
	return true
end

function HandleOpCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player>")
	else
		local PlayerName = Split[2]

		cRoot:Get():ForEachPlayer(
			function(OtherPlayer)
				local PlayerUUID
				if OtherPlayer:GetName() == PlayerName then
					PlayerUUID = OtherPlayer:GetUUID()
				elseif cRoot:Get():GetServer():ShouldAuthenticate() then
					PlayerUUID = cMojangAPI:GetUUIDFromPlayerName(PlayerName)
				else
					PlayerUUID = cClientHandle:GenerateOfflineUUID(PlayerName)
				end

				cRankManager:RemovePlayerRank(PlayerUUID)

				if OtherPlayer:GetName() == PlayerName then
					OtherPlayer:LoadRank()
					OtherPlayer:SendMessageInfo("You have received OP status")
				end
			end
		)

		if cRoot:Get():GetServer():ShouldAuthenticate() and cMojangAPI:GetUUIDFromPlayerName(PlayerName) == "" then
			Player:SendMessageFailure("Player \"" .. PlayerName .. "\" not found")
		else
			Player:SendMessageSuccess("Successfully given OP status to player \"" .. PlayerName .. "\"")
		end
	end
	return true
end

function HandlePumpkinCommand(Split, Player)
	local Pumpkin = function(OtherPlayer)
		OtherPlayer:GetInventory():SetArmorSlot(0, cItem(E_BLOCK_PUMPKIN))
		if Split[2] ~= nil and Split[2] ~= "*" and Split[2] ~= "**" then
			Player:SendMessageSuccess("Player \"" .. OtherPlayer:GetName() .. "\" is now a pumpkin")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player>")
	elseif Split[2] == "*" or Split[2] == "**" then
		cRoot:Get():ForEachPlayer(Pumpkin)
		Player:SendMessageSuccess("Everyone is now a pumpkin")
	elseif not cRoot:Get():FindAndDoWithPlayer(Split[2], Pumpkin) then
		Player:SendMessageFailure("Player \"" .. Split[2] .. "\" not found")
	end
	return true
end

function HandleReloadCommand(Split, Player)
	cRoot:Get():BroadcastChat(cChatColor.Rose .. "Server is reloading plugins...")
	return true
end

function HandleRestartCommand( Split, Player )
	cRoot:Get():BroadcastChat(cChatColor.Rose .. "Please wait a few seconds. Server is restarting...")
	return true
end

function HandleRulesCommand(Split, Player)
	Player:SendMessageInfo(Rules)
	return true
end

function HandleSpideyCommand(Split, Player)
	local World = Player:GetWorld()
	local WorldName = Player:GetWorld():GetName()
	local X = Player:GetPosX()
	local Y = Player:GetPosY()
	local Z = Player:GetPosZ()
	local Callbacks = {
		OnNextBlock = function(BlockX, BlockY, BlockZ, BlockType, BlockMeta)
			if BlockType ~= E_BLOCK_AIR or IsInSpawn(BlockX, BlockY, BlockZ, WorldName) then
				return true
			end
			World:SetBlock(BlockX, BlockY, BlockZ, E_BLOCK_COBWEB, 0)
		end
	}
	local EyePos = Player:GetEyePosition()
	local LookVector = Player:GetLookVector()
	LookVector:Normalize()
	local Start = EyePos + LookVector + LookVector
	local End = EyePos + LookVector * 50
	cLineBlockTracer.Trace(World, Callbacks, Start.x, Start.y, Start.z, End.x, End.y, End.z)
	return true
end

function HandleStarveCommand(Split, Player)
	local Starve = function(OtherPlayer)
		OtherPlayer:SetFoodLevel(0)
		OtherPlayer:SendMessageSuccess("You are now starving")
		if Split[2] ~= nil and Split[2] ~= "*" and Split[2] ~= "**" then
			Player:SendMessageSuccess("Player \"" .. OtherPlayer:GetName() .. "\" is now starving")
		end
	end
	if Split[2] == nil then
		Starve(Player)
	elseif Player:HasPermission("extras.starve.other") then
		if Split[2] == "*" or Split[2] == "**" then
			cRoot:Get():ForEachPlayer(Starve)
			Player:SendMessageSuccess("Every player is now starving")
		elseif not cRoot:Get():FindAndDoWithPlayer(Split[2], Starve) then
			Player:SendMessageFailure("Player \"" .. Split[2] .. "\" not found")
		end
	end
	return true
end

function HandleStopCommand(Split, Player)
	cRoot:Get():BroadcastChat(cChatColor.Rose .. "Please wait a few seconds. Server is shutting down...")
	return true
end

function HandleSuicideCommand(Split, Player)
	Player:TakeDamage(dtInVoid, nil, 1000, 1000, 0)
	return true
end

-- TODO: improve summon
function HandleSummonCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <entity> [x] [y] [z]")
	else
		local PosX = Player:GetPosX()
		local PosY = Player:GetPosY()
		local PosZ = Player:GetPosZ()
		local World = Player:GetWorld()
		local EntityPosX = Split[3]
		local EntityPosY = Split[4]
		local EntityPosZ = Split[5]
		local EntityPosX = tonumber(EntityPosX)
		local EntityPosY = tonumber(EntityPosY)
		local EntityPosZ = tonumber(EntityPosZ)
		local MobID = Split[2]:gsub("EnderDragon", 63)
				:gsub("WitherBoss", 64)
				:gsub("Bat", 65)
				:gsub("Blaze", 61)
				:gsub("CaveSpider", 59)
				:gsub("Chicken", 93)
				:gsub("Cow", 92)
				:gsub("Creeper", 50)
				:gsub("Enderman", 58)
				:gsub("Ghast", 56)
				:gsub("Giant", 53)
				:gsub("Guardian", 68)
				:gsub("Horse", 100)
				:gsub("VillagerGolem", 99)
				:gsub("LavaSlime", 62)
				:gsub("MushroomCow", 96)
				:gsub("Ozelot", 98)
				:gsub("Pig", 90)
				:gsub("Rabbit", 101)
				:gsub("Sheep", 91)
				:gsub("Silverfish", 60)
				:gsub("Skeleton", 51)
				:gsub("Slime", 55)
				:gsub("SnowMan", 97)
				:gsub("Spider", 52)
				:gsub("Squid", 94)
				:gsub("Villager", 120)
				:gsub("Witch", 66)
				:gsub("Wolf", 95)
				:gsub("Zombie", 54)
				:gsub("PigZombie", 57)
		local ProjectileID = Split[2]:gsub("Arrow", 60)
				:gsub("ThrownEgg", 62)
				:gsub("ThrownEnderpearl", 65)
				:gsub("ThrownExpBottle", 75)
				:gsub("SmallFireball", 64)
				:gsub("FireworksRocketEntity", 76)
				:gsub("FishingFloat", 90)
				:gsub("Fireball", 63)
				:gsub("Snowball", 61)
				:gsub("ThrownPotion", 73)
				:gsub("WitherSkull", 66)
		local MinecartID = Split[2]:gsub("MinecartRideable", 328)
				:gsub("MinecartChest", 342)
				:gsub("MinecartFurnace", 343)
				:gsub("MinecartTNT", 407)
				:gsub("MinecartHopper", 408)

		if tonumber(MobID) or tonumber(MinecartID) or tonumber(ProjectileID) or Split[2] == "Boat" or Split[2] == "XPOrb" or Split[2] == "PrimedTnt" or Split[2] == "FallingSand" or Split[2] == "LightningBolt" then
			if Split[5] == nil then
				if Split[2] == "Boat" then
					World:SpawnBoat(PosX, PosY, PosZ)
				elseif Split[2] == "XPOrb" then
					World:SpawnExperienceOrb(PosX, PosY, PosZ, 1)
				elseif Split[2] == "PrimedTnt" then
					World:SpawnPrimedTNT(PosX, PosY, PosZ)
				elseif Split[2] == "FallingSand" then
					World:SpawnFallingBlock(PosX, PosY, PosZ, 12, 0)
				elseif Split[2] == "LightningBolt" then
					World:CastThunderbolt(PosX, PosY, PosZ)
				elseif tonumber(ProjectileID) then
					World:CreateProjectile(PosX, PosY, PosZ, ProjectileID, Player, Player:GetEquippedItem(), Player:GetLookVector() * 20)
				elseif tonumber(MinecartID) then
					World:SpawnMinecart(PosX, PosY, PosZ, MinecartID)
				else
					World:SpawnMob(PosX, PosY, PosZ, MobID)
				end
				Player:SendMessageSuccess("Successfully spawned entity \"" .. Split[2] .. "\"")
			else
				if EntityPosX ~= nil and EntityPosY ~= nil and EntityPosZ ~= nil then
					if Split[2] == "Boat" then
						World:SpawnBoat(EntityPosX, EntityPosY, EntityPosZ)
					elseif Split[2] == "XPOrb" then
						World:SpawnExperienceOrb(EntityPosX, EntityPosY, EntityPosZ, 1)
					elseif Split[2] == "PrimedTnt" then
						World:SpawnPrimedTNT(EntityPosX, EntityPosY, EntityPosZ)
					elseif Split[2] == "FallingSand" then
						World:SpawnFallingBlock(EntityPosX, EntityPosY, EntityPosZ, 12, 0)
					elseif Split[2] == "LightningBolt" then
						World:CastThunderbolt(EntityPosX, EntityPosY, EntityPosZ)
					elseif tonumber(ProjectileID) then
						World:CreateProjectile(EntityPosX, EntityPosY, EntityPosZ, ProjectileID, Player, Player:GetEquippedItem(), Player:GetLookVector() * 20)
					elseif tonumber(MinecartID) then
						World:SpawnMinecart(EntityPosX, EntityPosY, EntityPosZ, MinecartID)
					else
						World:SpawnMob(EntityPosX, EntityPosY, EntityPosZ, MobID)
					end
					Player:SendMessageSuccess("Successfully spawned entity \"" .. Split[2] .. "\" at coordinates X:" .. Split[3] .. ", Y:" .. Split[4] .. ", Z:" .. Split[5])
				else
					Player:SendMessageFailure("Invalid coordinates")
				end
			end
		else
			Player:SendMessageFailure("Unknown entity type \"" .. Split[2] .. "\"")
		end
	end
	return true
end

function HandleTellrawCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <text ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat(Message)
	end
	return true
end

function HandleUnloadchunksCommand(Split, Player)
	cRoot:Get():SaveAllChunks()
	local UnloadChunks = function(World)
		World:QueueUnloadUnusedChunks()
	end
	cRoot:Get():ForEachWorld(UnloadChunks)
	Player:SendMessageSuccess("Successfully unloaded unused chunks")
	return true
end

function HandleUsernameCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <username ...>")
	elseif Split[2] == "off" then
		Player:SetCustomName(Player:GetClientHandle():GetUsername())
		Player:SetName(Player:GetClientHandle():GetUsername())
		Player:SendMessageSuccess("Successfully restored your original username \"" .. Player:GetClientHandle():GetUsername() .. "\"")
	else
		local Username = table.concat(Split," ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)
	
		Player:SetCustomName(Username)
		Player:SetName(Username)
		Player:SendMessageSuccess("Successfully set your username to \"" .. Player:GetName() .. "\"")
	end
	return true
end

function HandleVoteCommand(Split, Player)
	Player:SendMessageInfo("Feel free to vote for the server by clicking on the links below")
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[1] " ..cChatColor.LightGreen .. "MinecraftServers.org", "http://minecraftservers.org/vote/153833"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[2] " ..cChatColor.LightGreen .. "TopG.org", "https://topg.org/Minecraft/in-414108"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[3] " ..cChatColor.LightGreen .. "Mine Servers", "https://mineservers.com/server/DLwZBVyt/vote"))
Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[4] " ..cChatColor.LightGreen .. "Minecraft Servers List", "http://www.minecraft-servers-list.org/index.php?a=in&u=flameserver"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[5] " ..cChatColor.LightGreen .. "MC Index", "http://www.minecraft-index.com/54824-flame-ga-8211-free-op-server/vote"))
	return true 
end

-- Shortcuts
function HandleAdventureCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 2 " .. table.concat(Split, " ", 2))
	return true
end

function HandleClearinventoryCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/clear " .. table.concat(Split, " ", 2))
	return true
end

function HandleCreativeCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 1 " .. table.concat(Split, " ", 2))
	return true
end

function HandleDayCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/time set day")
	return true
end

function HandleEnchantmentCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player> <enchantment ID> [level]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/enchant " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleIenchantmentCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <enchantment ID> [level]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/ienchant " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleKillallCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <type>")
		Player:SendMessageInfo("Acceptable types: monster, mob, itemframe, exporb, endercrystal, fallingblock, floater, minecart, entity, boat, pickup, tnt, painting, projectile")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/rem " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleMessageCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player> <message ...>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tell " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleNightCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/time set night")
	return true
end

function HandleReplyCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/r " .. table.concat(Split, " ", 2))
	end
	return true 
end

function HandleSpectatorCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 3 " .. table.concat(Split, " ", 2))
	return true
end

function HandleSurvivalCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 0 " .. table.concat(Split, " ", 2))
	return true
end

function HandleTeleCommand(Split, Player)
	if Split[2] == nil or #Split > 4 then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player> [-h]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tp " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleTpposCommand(Split, Player)
	if Split[2] == nil or #Split > 4 then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <x> <y> <z>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tp " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleWhoCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/list " .. table.concat(Split, " ", 2))
	return true 
end

function HandleWorldCommand(Split, Player)
	if #Split > 2 then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " [world]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/portal " .. table.concat(Split, " ", 2))
	end
	return true
end

-- Worlds
function HandleEndCommand(Split, Player)
	local World = cRoot:Get():GetWorld("end")
	Player:SetPitch(0)
	Player:SetYaw(90)
	if Player:GetWorld():GetName() == "end" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	end
	Player:MoveToWorld("end")
	Player:SendMessageSuccess("Successfully moved to the End")
	return true
end

function HandleFlatlandsCommand(Split, Player)
	local World = cRoot:Get():GetWorld("hubflatlands")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "hubflatlands" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ() + 14)
	end
	Player:MoveToWorld(cRoot:Get():GetWorld("hubflatlands"), true, Vector3d(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ() + 14))
	Player:SendMessageSuccess("Successfully moved to the Flatlands")
	return true
end

function HandleHubCommand(Split, Player)
	local World = cRoot:Get():GetWorld("hubflatlands")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "hubflatlands" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	end
	Player:MoveToWorld("hubflatlands")
	Player:SendMessageSuccess("Successfully moved to the Hub")
	return true
end

function HandleNetherCommand(Split, Player)
	local World = cRoot:Get():GetWorld("nether")
	Player:SetPitch(0)
	Player:SetYaw(-90)
	if Player:GetWorld():GetName() == "nether" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	end
	Player:MoveToWorld("nether")
	Player:SendMessageSuccess("Successfully moved to the Nether")
	return true
end

function HandleOverworldCommand(Split, Player)
	local World = cRoot:Get():GetWorld("overworld")
	Player:SetPitch(0)
	Player:SetYaw(180)
	if Player:GetWorld():GetName() == "overworld" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	end
	Player:MoveToWorld("overworld")
	Player:SendMessageSuccess("Successfully moved to the Overworld")
	return true
end
