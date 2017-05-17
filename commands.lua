-- Quick settings
local Rules = "Do whatever you want! ;)"

-- General
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
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

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
		local Message = table.concat(Split, " " , 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

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
		Player:GetEquippedItem().m_Enchantments:AddFromString("0=1000;1=1000;2=1000;3=1000;4=1000;5=1000;6=1000;7=1000;8=1000;16=1000;17=1000;18=1000;19=1000;20=1000;21=1000;32=1000;33=1000;34=1000;35=1000;48=1000;49=1000;50=1000;51=1000;61=1000;62=1000;70=1000;")
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
		if not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 3), FoodLevel) then
			Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 3) .. "\" not found")
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
	elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 2), Jumpscare) then
		Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 2) ..  "\" not found")
	end
	return true
end

function HandleKitCommand(Split, Player)
	local GiveKit = function(OtherPlayer)
		local function Info()
			OtherPlayer:SendMessageInfo("You have received kit \"" .. Split[2] .. "\"")
			if Split[3] ~= nil and Split[3] ~= "*" and Split[3] ~= "**" then
				Player:SendMessageSuccess("Successfully gave kit \"" .. Split[2] .. "\" to player \"" .. OtherPlayer:GetName() .. "\"")
			end
		end
		if Split[2] == "fireworks" then
			Item = cItem()
			Item.m_ItemType = E_ITEM_FIREWORK_ROCKET
			Item.m_ItemCount = 1
			Item.m_FireworkItem.m_HasTrail = true
			Item.m_FireworkItem.m_Colours = "11111"
			OtherPlayer:GetInventory():AddItem(Item)
			OtherPlayer:SendMessage(Item.m_CustomName)
			Info()
		elseif Split[2] == "griefer" then
			for i=1,5 do
				OtherPlayer:GetInventory():AddItem(cItem(E_BLOCK_TNT, 64, 0, "", "§rKABOOM"))
			end
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_FLINT_AND_STEEL, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_LAVA_BUCKET, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_HELMET, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_CHESTPLATE, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_LEGGINGS, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_BOOTS, 1, 0))
			Info()
		elseif Split[2] == "op" then
			local Enchantments = "0=1000;1=1000;2=1000;3=1000;4=1000;5=1000;6=1000;7=1000;8=1000;16=1000;17=1000;18=1000;19=1000;20=1000;21=1000;32=1000;33=1000;34=1000;35=1000;48=1000;49=1000;50=1000;51=1000;61=1000;62=1000;70=1000;"
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_SWORD, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_BOW, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_PICKAXE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_AXE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_SHOVEL, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_HOE, 1, 0, Enchantments))
			for i=1,2 do
				OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_ARROW, 64, 0))
			end
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_GOLDEN_APPLE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_HELMET, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_CHESTPLATE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_LEGGINGS, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_BOOTS, 1, 0, Enchantments))
			Info()
		elseif Split[2] == "weapons" then
			OtherPlayer:GetInventory():AddItem(cItem(E_BLOCK_ANVIL, 1, 0, "", "§8Anvil Dropper"))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_BLAZE_ROD, 1, 0, "", "§6Nuker"))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_STICK, 1, 0, "", "§fLightning Stick"))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_IRON_HORSE_ARMOR, 1, 0, "", "§7Sniper"))
			Info()
		else
			Player:SendMessageFailure("Invalid kit")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <name> [player]")
		Player:SendMessageInfo("Available kits: griefer, op, weapons")
	elseif Split[3] == nil then
		GiveKit(Player)
	elseif Player:HasPermission("extras.kit.other") then
		if Split[3] == "*" or Split[3] == "**" then
			cRoot:Get():ForEachPlayer(GiveKit)
			Player:SendMessageSuccess("Successfully gave kit \"" .. Split[2] .. "\" to every player")
		elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 3), GiveKit) then
			Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 3) .. "\" not found")
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
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat("* " .. PlayerName .. " " .. cChatColor.White .. Message)
	end
	return true
end

function HandleMemoryCommand( Split, Player )
	Player:SendMessageInfo("Current RAM usage: " .. math.floor(cRoot:GetPhysicalRAMUsage() / 1024 + 0.5) .. " MB")
	Player:SendMessageInfo("Current swap usage: " .. math.floor(cRoot:GetVirtualRAMUsage() / 1024 + 0.5) .. " MB")
	Player:SendMessageInfo("Total memory usage: " .. math.floor(cRoot:GetPhysicalRAMUsage() / 1024 + cRoot:GetVirtualRAMUsage() / 1024 + 0.5) .. " MB")
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
	elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 2), Pumpkin) then
		Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 2) .. "\" not found")
	end
	return true
end

function HandleRestartCommand( Split, Player )
	cRoot:Get():BroadcastChat(cChatColor.Red .. "[WARNING] " .. cChatColor.White .. "Server is restarting!")
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
		elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 2), Starve) then
			Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 2) .. "\" not found")
		end
	end
	return true
end

function HandleSuicideCommand(Split, Player)
	Player:TakeDamage(dtInVoid, nil, 1000, 1000, 0)
	return true
end

function HandleSummonCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <entityname> [x] [y] [z]")
	else
		local X = Player:GetPosX()
		local Y = Player:GetPosY()
		local Z = Player:GetPosZ()
		local World = Player:GetWorld()

		local Minecarts =
		{
			["minecart"] = E_ITEM_MINECART,
			["chest_minecart"] = E_ITEM_CHEST_MINECART,
			["furnace_minecart"] = E_ITEM_FURNACE_MINECART,
			["hopper_minecart"] = E_ITEM_MINECART_WITH_HOPPER,
			["tnt_minecart"] = E_ITEM_MINECART_WITH_TNT,

			-- 1.10 and below
			["MinecartChest"] = E_ITEM_CHEST_MINECART,
			["MinecartFurnace"] = E_ITEM_FURNACE_MINECART,
			["MinecartHopper"] = E_ITEM_MINECART_WITH_HOPPER,
			["MinecartRideable"] = E_ITEM_MINECART,
			["MinecartTNT"] = E_ITEM_MINECART_WITH_TNT
		}

		local Mobs = 
		{
			["bat"] = mtBat,
			["blaze"] = mtBlaze,
			["cave_spider"] = mtCaveSpider,
			["chicken"] = mtChicken,
			["cow"] = mtCow,
			["creeper"] = mtCreeper,
			["ender_dragon"] = mtEnderDragon,
			["enderman"] = mtEnderman,
			["ghast"] = mtGhast,
			["giant"] = mtGiant,
			["guardian"] = mtGuardian,
			["horse"] = mtHorse,
			["iron_golem"] = mtIronGolem,
			["magma_cube"] = mtMagmaCube,
			["mooshroom"] = mtMooshroom,
			["ocelot"] = mtOcelot,
			["pig"] = mtPig,
			["rabbit"] = mtRabbit,
			["sheep"] = mtSheep,
			["silverfish"] = mtSilverfish,
			["skeleton"] = mtSkeleton,
			["slime"] = mtSlime,
			["snowman"] = mtSnowGolem,
			["spider"] = mtSpider,
			["squid"] = mtSquid,
			["villager"] = mtVillager,
			["witch"] = mtWitch,
			["wither"] = mtWither,
			["wolf"] = mtWolf,
			["zombie"] = mtZombie,
			["zombie_pigman"] = mtZombiePigman,

			-- 1.10 and below
			["Bat"] = mtBat,
			["Blaze"] = mtBlaze,
			["CaveSpider"] = mtCaveSpider,
			["Chicken"] = mtChicken,
			["Cow"] = mtCow,
			["Creeper"] = mtCreeper,
			["EnderDragon"] = mtEnderDragon,
			["Enderman"] = mtEnderman,
			["Ghast"] = mtGhast,
			["Giant"] = mtGiant,
			["Guardian"] = mtGuardian,
			["Horse"] = mtHorse,
			["LavaSlime"] = mtMagmaCube,
			["MushroomCow"] = mtMooshroom,
			["Ozelot"] = mtOcelot,
			["Pig"] = mtPig,
			["Rabbit"] = mtRabbit,
			["Sheep"] = mtSheep,
			["Silverfish"] = mtSilverfish,
			["Skeleton"] = mtSkeleton,
			["Slime"] = mtSlime,
			["SnowMan"] = mtSnowGolem,
			["Spider"] = mtSpider,
			["Squid"] = mtSquid,
			["Villager"] = mtVillager,
			["VillagerGolem"] = mtIronGolem,
			["Witch"] = mtWitch,
			["Wither"] = mtWither,
			["Wolf"] = mtWolf,
			["Zombie"] = mtZombie,
			["PigZombie"] = mtZombiePigman
		}

		local Projectiles =
		{
			["arrow"] = cProjectileEntity.pkArrow,
			["egg"] = cProjectileEntity.pkEgg,
			["ender_pearl"] = cProjectileEntity.pkEnderPearl,
			["fireworks_rocket"] = cProjectileEntity.pkFirework,
			["fishing_float"] = cProjectileEntity.pkFishingFloat,
			["fireball"] = cProjectileEntity.pkGhastFireball,
			["potion"] = cProjectileEntity.pkSplashPotion,
			["small_fireball"] = cProjectileEntity.pkFireCharge,
			["snowball"] = cProjectileEntity.pkSnowball,
			["wither_skull"] = cProjectileEntity.pkWitherSkull,
			["xp_bottle"] = cProjectileEntity.pkExpBottle,

			-- 1.10 and below
			["Arrow"] = cProjectileEntity.pkArrow,
			["Fireball"] = cProjectileEntity.pkGhastFireball,
			["FireworksRocketEntity"] = cProjectileEntity.pkFirework,
			["FishingFloat"] = cProjectileEntity.pkFishingFloat,
			["SmallFireball"] = cProjectileEntity.pkFireCharge,
			["Snowball"] = cProjectileEntity.pkSnowball,
			["ThrownEgg"] = cProjectileEntity.pkEgg,
			["ThrownEnderpearl"] = cProjectileEntity.pkEnderPearl,
			["ThrownExpBottle"] = cProjectileEntity.pkExpBottle,
			["ThrownPotion"] = cProjectileEntity.pkSplashPotion,
			["WitherSkull"] = cProjectileEntity.pkWitherSkull
		}

		if Split[3] ~= nil then
			X = tonumber(Split[3])
			local RelativeX = loadstring(Split[3]:gsub("~", "return " .. Player:GetPosX() .. "+0"))
			if RelativeX then
				X = select(2, pcall(setfenv(RelativeX, {})))
			end
		end

		if Split[4] ~= nil then
			Y = tonumber(Split[4])
			local RelativeY = loadstring(Split[4]:gsub("~", "return " .. Player:GetPosY() .. "+0"))
			if RelativeY then
				Y = select(2, pcall(setfenv(RelativeY, {})))
			end
		end

		if Split[5] ~= nil then
			Z = tonumber(Split[5])
			local RelativeZ = loadstring(Split[5]:gsub("~", "return " .. Player:GetPosZ() .. "+0"))
			if RelativeZ then
				Z = select(2, pcall(setfenv(RelativeZ, {})))
			end
		end

		if X == nil then
			Player:SendMessageFailure("\"" .. Split[3] .. "\" is not a valid number")
			return true
		end

		if Y == nil then
			Player:SendMessageFailure("\"" .. Split[4] .. "\" is not a valid number")
			return true
		end

		if Z == nil then
			Player:SendMessageFailure("\"" .. Split[5] .. "\" is not a valid number")
			return true
		end

		local function Success()
			Player:SendMessageSuccess("Successfully summoned entity at [X:" .. math.floor(X) .. " Y:" .. math.floor(Y) .. " Z:" .. math.floor(Z) .. "]")
		end

		if Split[2] == "boat" or Split[2] == "Boat" then
			World:SpawnBoat(X, Y, Z)
			Success()
		elseif Split[2] == "falling_block" or Split[2] == "FallingSand" then
			World:SpawnFallingBlock(X, Y, Z, 12, 0)
			Success()
		elseif Split[2] == "lightning_bolt" or Split[2] == "LightningBolt" then
			World:CastThunderbolt(X, Y, Z)
			Success()
		elseif Minecarts[Split[2]] then
			World:SpawnMinecart(X, Y, Z, Minecarts[Split[2]])
			Success()
		elseif Mobs[Split[2]] then
			World:SpawnMob(X, Y, Z, Mobs[Split[2]])
			Success()
		elseif Projectiles[Split[2]] then
			World:CreateProjectile(X, Y, Z, Projectiles[Split[2]], Player, Player:GetEquippedItem(), Player:GetLookVector() * 20)
			Success()
		elseif Split[2] == "tnt" or Split[2] == "PrimedTnt" then
			World:SpawnPrimedTNT(X, Y, Z)
			Success()
		elseif Split[2] == "xp_orb" or Split[2] == "XPOrb" then
			World:SpawnExperienceOrb(X, Y, Z, 1)
			Success()
		else
			Player:SendMessageFailure("Unknown entity '" .. Split[2] .. "'")
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

function HandleTitleCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <text ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(Message))
		Player:GetClientHandle():SendTitleTimes(10, 160, 5)
	end
	return true
end

function HandleUnloadchunksCommand(Split, Player)
	cRoot:Get():SaveAllChunks()
	cRoot:Get():ForEachWorld(
		function(World)
			World:QueueUnloadUnusedChunks()
		end
	)
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
	Player:SendMessageInfo("Feel free to vote for the server to help it grow")
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[1] " ..cChatColor.LightGreen .. "TopG.org", "https://topg.org/Minecraft/in-414108"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[2] " ..cChatColor.LightGreen .. "MinecraftServers.org", "http://minecraftservers.org/vote/153833"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[3] " ..cChatColor.LightGreen .. "Minecraft Multiplayer", "http://minecraft-mp.com/server/155223/vote/"))
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

function HandleTpohereCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tphere " .. table.concat(Split, " ", 2))
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
	else
		Player:MoveToWorld("end")
	end
	Player:SendMessageSuccess("Successfully moved to the End")
	return true
end

function HandleFlatlandsCommand(Split, Player)
	local World = cRoot:Get():GetWorld("flatlands")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "flatlands" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ() + 14)
	else
		Player:MoveToWorld(World, true, Vector3d(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ() + 14))
	end
	Player:SendMessageSuccess("Successfully moved to the Flatlands")
	return true
end

function HandleHubCommand(Split, Player)
	local World = cRoot:Get():GetWorld("flatlands")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "flatlands" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
		Player:MoveToWorld("flatlands")
	end
	Player:SendMessageSuccess("Successfully moved to the Hub")
	return true
end

function HandleNetherCommand(Split, Player)
	local World = cRoot:Get():GetWorld("nether")
	Player:SetPitch(0)
	Player:SetYaw(-90)
	if Player:GetWorld():GetName() == "nether" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
		Player:MoveToWorld("nether")
	end
	Player:SendMessageSuccess("Successfully moved to the Nether")
	return true
end

function HandleOverworldCommand(Split, Player)
	local World = cRoot:Get():GetWorld("overworld")
	Player:SetPitch(0)
	Player:SetYaw(180)
	if Player:GetWorld():GetName() == "overworld" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
		Player:MoveToWorld("overworld")
	end
	Player:SendMessageSuccess("Successfully moved to the Overworld")
	return true
end		-- 1.10 and below
