-- Quick settings
local BuildError = cChatColor.Rose .. "Go further from spawn to build and destroy"
local SpamError = "Please avoid spamming"

local CooldownCommands = GetValue {
	"//cyl",
	"//ellipsoid",
	"//g",
	"//gen",
	"//generate",
	"//hcyl",
	"//hpyramid",
	"//hsphere",
	"//pyramid",
	"//replacenear",
	"//schematic",
	"//sphere",
	"/action",
	"/afk",
	"/bc",
	"/broadcast",
	"/bcast",
	"/clearchat",
	"/console",
	"/describe",
	"/jumpscare",
	"/me",
	"/msg",
	"/r",
	"/reload",
	"/restart",
	"/say",
	"/stop",
	"/tell",
	"/scare",
	"/setjail",
	"/setwarp",
	"/shout",
	"/tellraw",
	"/time",
	"/whisper",
}

function GetPlayerLookPos(Player)
	local World = Player:GetWorld()
	local Tracer = cTracer(World)
	local EyePos = Vector3f(Player:GetEyePosition().x, Player:GetEyePosition().y, Player:GetEyePosition().z)
	local EyeVector = Vector3f(Player:GetLookVector().x, Player:GetLookVector().y, Player:GetLookVector().z)
	Tracer:Trace(EyePos , EyeVector, 100)
	return Tracer.BlockHitPosition
end

function IsInSpawn(X, Y, Z, WorldName)
	local World = cRoot:Get():GetWorld(WorldName)
	local SpawnArea = cBoundingBox(Vector3d(World:GetSpawnX() - 22, -999999999, World:GetSpawnZ() - 22), Vector3d(World:GetSpawnX() + 21, 999999999, World:GetSpawnZ() + 21))
	local PlayerLocation = Vector3d(X, Y, Z)

	if SpawnArea:IsInside(PlayerLocation) then
		return true
	end
end

function IsInSpawnExplosion(X, Y, Z, WorldName)
	local World = cRoot:Get():GetWorld(WorldName)
	local SpawnArea = cBoundingBox(Vector3d(World:GetSpawnX() - 28, -999999999, World:GetSpawnZ() - 28), Vector3d(World:GetSpawnX() + 27, 999999999, World:GetSpawnZ() + 27))
	local PlayerLocation = Vector3d(X, Y, Z)

	if SpawnArea:IsInside(PlayerLocation) then
		return true
	end
end

function OnChat(Player, Message)
	if CanMessage[Player:GetUUID()] == false then
		Player:SendMessageFailure(SpamError)
		return true
	else
		CanMessage[Player:GetUUID()] = false
	end

	if NickList[Player:GetUUID()] == nil then
		PlayerName = Player:GetName()
	else
		PlayerName = NickList[Player:GetUUID()]
	end

	local Rank = cRankManager:GetPlayerRankName(Player:GetUUID())
	local FinalMessage = Message:gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random) :gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

	if Rank == "" or Rank == "op" then
		cRoot:Get():BroadcastChat(cChatColor.Red..cChatColor.Bold.. "[" ..cChatColor.Rose..cChatColor.Bold.. "OP" ..cChatColor.Red..cChatColor.Bold.."] " ..cChatColor.Rose .. PlayerName .. cChatColor.Red..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "deop" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "DEOP" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "founder" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "FOUNDER" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "owner" then
		cRoot:Get():BroadcastChat(cChatColor.Blue..cChatColor.Bold.. "[" ..cChatColor.LightBlue..cChatColor.Bold.. "OWNER" ..cChatColor.Blue..cChatColor.Bold.. "] " ..cChatColor.LightBlue .. PlayerName .. cChatColor.Blue..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "admin" then
		cRoot:Get():BroadcastChat(cChatColor.Gold..cChatColor.Bold.. "[" ..cChatColor.Yellow..cChatColor.Bold.. "ADMIN" ..cChatColor.Gold..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Gold..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "moderator" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "MODERATOR" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "hacker" then
		cRoot:Get():BroadcastChat(cChatColor.Blue..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "H" ..cChatColor.LightBlue..cChatColor.Bold.. "A" ..cChatColor.Rose..cChatColor.Bold.. "C" ..cChatColor.LightPurple..cChatColor.Bold.. "K" ..cChatColor.Yellow..cChatColor.Bold.. "E" ..cChatColor.LightGreen..cChatColor.Bold.. "R" ..cChatColor.Blue..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Blue..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "vip" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "VIP" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "helper" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "HELPER" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "builder" then
		cRoot:Get():BroadcastChat(cChatColor.Gold..cChatColor.Bold.. "[" ..cChatColor.Yellow..cChatColor.Bold.. "BUILDER" ..cChatColor.Gold..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Gold..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "manager" then
		cRoot:Get():BroadcastChat(cChatColor.Blue..cChatColor.Bold.. "[" ..cChatColor.LightBlue..cChatColor.Bold.. "MANAGER" ..cChatColor.Blue..cChatColor.Bold.. "] " ..cChatColor.LightBlue .. PlayerName .. cChatColor.Blue..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "troll" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "T" ..cChatColor.White..cChatColor.Bold.. "R" ..cChatColor.LightGray..cChatColor.Bold.. "O" ..cChatColor.White..cChatColor.Bold.. "L" ..cChatColor.LightGray..cChatColor.Bold.. "L" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "griefer" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "GRIEFER" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "noob" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "NOOB" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.Rose .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "developer" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "DEVELOPER" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "trusted" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "TRUSTED" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "supporter" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "SUPPORTER" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "worldeditor" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "WORLDEDITOR" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "legend" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "L" ..cChatColor.Yellow..cChatColor.Bold.. "E" ..cChatColor.LightPurple..cChatColor.Bold.. "G" ..cChatColor.Yellow..cChatColor.Bold.. "E" ..cChatColor.LightPurple..cChatColor.Bold.. "N" ..cChatColor.Yellow..cChatColor.Bold.. "D" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "master" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "MASTER" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "donator" then
		cRoot:Get():BroadcastChat(cChatColor.Gold..cChatColor.Bold.. "[" ..cChatColor.Yellow..cChatColor.Bold.. "DONATOR" ..cChatColor.Gold..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Gold..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "pyromaniac" then
		cRoot:Get():BroadcastChat(cChatColor.Red..cChatColor.Bold.. "[" ..cChatColor.Rose..cChatColor.Bold.. "PYRO" ..cChatColor.Red..cChatColor.Bold.. "] " ..cChatColor.Rose .. PlayerName .. cChatColor.Red..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "youtuber" then
		cRoot:Get():BroadcastChat(cChatColor.Red..cChatColor.Bold.. "[" ..cChatColor.Rose..cChatColor.Bold.. "YOUTUBER" ..cChatColor.Red..cChatColor.Bold.. "] " ..cChatColor.Rose .. PlayerName .. cChatColor.Red..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "mojang" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightBlue..cChatColor.Bold.. "M" ..cChatColor.Rose..cChatColor.Bold.. "O" ..cChatColor.LightPurple..cChatColor.Bold.. "J" ..cChatColor.Yellow..cChatColor.Bold.. "A" ..cChatColor.LightGreen..cChatColor.Bold.. "N" ..cChatColor.LightBlue..cChatColor.Bold.. "G" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "hero" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "HERO" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "bot" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "BOT" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	elseif Rank == "co-owner" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "CO-OWNER" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. FinalMessage)
	end
	return true
end

function OnExecuteCommand(Player, CommandSplit, EntireCommand)
	if Player then
		-- Checks if the player is spamming the specified commands
		if CanMessage[Player:GetUUID()] == false and CooldownCommands[CommandSplit[1]] then
			Player:SendMessageFailure(SpamError)
			return true
		else
			CanMessage[Player:GetUUID()] = false
		end

		if CommandSplit[1] == "/ban" or CommandSplit[1] == "/kick" or CommandSplit[1] == "/nuke" or CommandSplit[1] == "/regen" then
			Player:SendMessageInfo("Unknown command: \"" .. CommandSplit[1] .. "\"")
			return true
		end

		-- Speed limits
		if CommandSplit[1] == "/speed" and tonumber(CommandSplit[3]) and tonumber(CommandSplit[3]) > 1000 then
			if CommandSplit[4] ~= nil then
				cPluginManager:Get():ExecuteCommand(Player, CommandSplit[1] .. " " .. CommandSplit[2] .. " 1000 " .. CommandSplit[4])
			else
				cPluginManager:Get():ExecuteCommand(Player, CommandSplit[1] .. " " .. CommandSplit[2] .. " 1000")
			end
			return true
		end

		-- Handles WorldEdit radius limits and invalid blocks
		local Item = cItem()

		if CommandSplit[1] == "//drain" or CommandSplit[1] == "//ex" or CommandSplit[1] == "//extinguish" or CommandSplit[1] == "//green" or CommandSplit[1] == "//replacenear" or CommandSplit[1] == "/ex" or CommandSplit[1] == "/thaw" or CommandSplit[1] == "/snow" then
			if tonumber(CommandSplit[2]) and tonumber(CommandSplit[2]) > 50 then
				Player:SendMessageFailure("Please reduce the radius to 50 or below")
				return true
			end
		end

		if CommandSplit[1] == "//sphere" or CommandSplit[1] == "//hsphere" or CommandSplit[1] == "//cyl" or CommandSplit[1] == "//hcyl" or CommandSplit[1] == "//pyramid" or CommandSplit[1] == "//hpyramid" then
			local Radius = StringSplit(CommandSplit[3], ",")
			for i = 1, 3 do
				if tonumber(Radius[I]) and tonumber(Radius[i]) > 50 then
					Player:SendMessageFailure("Please reduce the radius to 50 or below")
					return true
				end
			end
			if StringToItem(CommandSplit[2], Item) and Item.m_ItemType == 46 or StringToItem(CommandSplit[2], Item) and Item.m_ItemType > 255 then
				Player:SendMessage(cChatColor.LightPurple .. "Unknown block type: '" .. CommandSplit[2] .. "'.")
				return true
			end
		end

		if CommandSplit[1] == "//replacenear" and StringToItem(CommandSplit[3], Item) then
			if Item.m_ItemType == 46 or Item.m_ItemType > 255 then
				Player:SendMessage(cChatColor.Rose .. "Unknown src block type: '" .. CommandSplit[2] .. "'.")
				return true
			end
		end

		if CommandSplit[1] == "//replacenear" and StringToItem(CommandSplit[4], Item) then
			if Item.m_ItemType == 46 or Item.m_ItemType > 255 then
				Player:SendMessage(cChatColor.Rose .. "Unknown dst block type: '" .. CommandSplit[2] .. "'.")
				return true
			end
		end

		if CommandSplit[1] == "//set" and StringToItem(CommandSplit[2], Item) then
			if Item.m_ItemType == 46 or Item.m_ItemType > 255 then
				Player:SendMessage(cChatColor.Rose .. "Unknown dst block type: '" .. CommandSplit[2] .. "'.")
				return true
			end
		end
	end
end

function OnExploding(World, ExplosionSize, CanCauseFire, X, Y, Z, Source, SourceData)
	ExplosionCount = ExplosionCount + 1
	if IsInSpawnExplosion(X, Y, Z, World:GetName()) or ExplosionCount > 15 then
		return true
	end
end

function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, Status, BlockType, BlockMeta)
	if IsInSpawn(BlockX, BlockY, BlockZ, Player:GetWorld():GetName()) then
		-- Teleports player up if nuker is detected in spawn
		if CanBreak[Player:GetUUID()] == false then
			Player:TeleportToCoords(Player:GetPosX(), Player:GetPosY() + 8, Player:GetPosZ())
			Player:SetFlying(true)
		else
			CanBreak[Player:GetUUID()] = false
		end
		Player:SendAboveActionBarMessage(BuildError)
		return true
	end
end

function OnPlayerPlacingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	if IsInSpawn(BlockX, BlockY, BlockZ, Player:GetWorld():GetName()) then
		Player:SendAboveActionBarMessage(BuildError)
		return true
	end

	if Player:GetEquippedItem().m_ItemType == E_BLOCK_COMMAND_BLOCK then
		Player:SendMessageInfo("NOTE! Command blocks are partially broken. Use the \"/commandblock\" command to set the command of a command block, and get the output of the command block.")
	end
end

function OnPlayerRightClick(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ)
	if IsInSpawn(BlockX, BlockY, BlockZ, Player:GetWorld():GetName()) then
		if Player:GetWorld():GetBlock(BlockX, BlockY, BlockZ) == E_BLOCK_GRASS or Player:GetWorld():GetBlock(BlockX, BlockY, BlockZ) == E_BLOCK_DIRT or Player:GetEquippedItem().m_ItemType == E_ITEM_FLINT_AND_STEEL or Player:GetEquippedItem().m_ItemType == E_ITEM_FIRE_CHARGE then
			Player:SendAboveActionBarMessage(BuildError)
			return true
		end
	end

	-- Secret in the hub ;)
	if Player:GetWorld():GetName() == "hubflatlands" and BlockX == 0 and BlockY == 11 and BlockZ == 2 then
		Player:GetWorld():BroadcastParticleEffect("heart", 0, 12, 2, 2, 1, 0.5, 0, 40)
	end
end

function OnPlayerJoined(Player)
	cRoot:Get():BroadcastChat(cChatColor.Green.. "(+) " .. cChatColor.LightGreen .. Player:GetName())
	Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(cChatColor.LightGray .. "Welcome to Kaboom.pw!"))
	Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart("Do Anything • OP Commands")))
	Player:GetClientHandle():SendTitleTimes(10, 160, 5)
	return true
end

function OnPlayerDestroyed(Player)
	ParticlePlayers[Player:GetUUID()] = nil
	cRoot:Get():BroadcastChat(cChatColor.Red.. "(-) " .. cChatColor.Rose .. Player:GetName()) 
	return true
end

function OnServerPing(ClientHandle, ServerDescription, OnlinePlayers, MaxPlayers)
	local ServerDescription = "§8§lWelcome to Kaboom.pw!\n§fA server where you can do anything you want"
	local MaxPlayers = OnlinePlayers + 1
	return false, ServerDescription, OnlinePlayers, MaxPlayers
end

function OnSpawningEntity(World, Entity)
	World:ForEachEntity(
		function(Entity)
			if Entity:IsTNT() then
				TNTCount = TNTCount + 1
			end
		end
	)

	if Entity:IsMob() then
		MobCount = MobCount + 1
		if MobCount > 20 then
			return true
		end
	end

	if Entity:IsPickup() then
		return true
	end

	if Entity:IsTNT() and TNTCount > 8 then
		TNTCount = 0
		return true
	end

	if IsInSpawn(Entity:GetPosX(), Entity:GetPosY(), Entity:GetPosZ(), World:GetName()) then
		if Entity:GetEntityType() == cEntity.etMob and Entity:GetMobType() == mtSnowGolem or Entity:IsFallingBlock() or Entity:IsTNT() or Entity:IsItemFrame() or Entity:IsPainting() then
			return true
		end
	end
end

function OnTick(TimeDelta)
	if GlobalTime == 75 then
		-- Resets different checks
		ExplosionCount = 0
		GlobalTime = 0
		MobCount = 0
		cRoot:Get():ForEachPlayer(
			function(Player)
				CanMessage[Player:GetUUID()] = true
			end
		)

		-- Checks if server is stuck
		os.remove("update")
		file = io.open("update", "a")
		file:close()
	else
		GlobalTime = GlobalTime + 1
	end
end

function OnWorldTick(World, TimeDelta)
	World:ForEachPlayer(
		function(Player)
			-- Creates particles around the player
			if ParticlePlayers[Player:GetUUID()] == "note" then
				Player:GetWorld():BroadcastParticleEffect("note", Player:GetPosX(), Player:GetPosY(), Player:GetPosZ(), 0.5, 1, 0.5, math.random(1, 16), 10)
			elseif ParticlePlayers[Player:GetUUID()] ~= nil then
				Player:GetWorld():BroadcastParticleEffect(ParticlePlayers[Player:GetUUID()], Player:GetPosX(), Player:GetPosY(), Player:GetPosZ(), 0.5, 1, 0.5, 0, 10)
			end
			-- Checks if player is using nuker in spawn
			if NukerTime == 1 then
				BreakTime = 0
				CanBreak[Player:GetUUID()] = true
			else
				NukerTime = NukerTime + 1
			end
			-- Handles portals in spawn
			local X = World:GetSpawnX()
			local Y = World:GetSpawnY()
			local Z = World:GetSpawnZ()
			local Position = Player:GetPosition()
			local HubToEnd = cBoundingBox(Vector3d(X - 14, Y, Z - 3), Vector3d(X - 13, Y + 5, Z + 3))
			local HubToNether = cBoundingBox(Vector3d(X + 13, Y, Z - 3), Vector3d(X + 14, Y + 5, Z + 3))
			local HubToOverworld = cBoundingBox(Vector3d(X - 3, Y, Z - 14), Vector3d(X + 3, Y + 5, Z - 13))
			local OverworldToHub = cBoundingBox(Vector3d(X - 1, Y, Z + 5), Vector3d(X + 1, Y + 4, Z + 6))
			local NetherToHub = cBoundingBox(Vector3d(X - 6, Y, Z - 1), Vector3d(X - 5, Y + 4, Z + 1))
			if Player:GetWorld():GetName() == "hubflatlands" then
				if HubToEnd:IsInside(Position) then
					Player:SetPitch(0)
					Player:SetYaw(90)
					Player:MoveToWorld("end")
				end
				if HubToNether:IsInside(Position) then
					Player:SetPitch(0)
					Player:SetYaw(-90)
					Player:MoveToWorld("nether")
				end
				if HubToOverworld:IsInside(Position) then
					Player:SetPitch(0)
					Player:SetYaw(180)
					Player:MoveToWorld("overworld")
				end
			elseif Player:GetWorld():GetName() == "overworld" then
				if OverworldToHub:IsInside(Position) then
					Player:SetPitch(0)
					Player:SetYaw(0)
					Player:MoveToWorld("hubflatlands")
				end
			elseif Player:GetWorld():GetName() == "nether" then
				if NetherToHub:IsInside(Position) then
					Player:SetPitch(0)
					Player:SetYaw(0)
					Player:MoveToWorld("hubflatlands")
				end
			end
	
			-- Shows messages about different worlds in the hub
			local HubWorld = cBoundingBox(Vector3d(X - 5, Y, Z - 5), Vector3d(X + 6, Y + 17, Z + 6))
			local HubEnd = cBoundingBox(Vector3d(X - 12, Y, Z - 4), Vector3d(X - 5, Y + 17, Z + 5))
			local HubNether = cBoundingBox(Vector3d(X + 6, Y, Z - 4), Vector3d(X + 13, Y + 17, Z + 5))
			local HubOverworld = cBoundingBox(Vector3d(X - 4, Y, Z - 12), Vector3d(X + 5, Y + 17, Z - 5))
			local HubFlatlands = cBoundingBox(Vector3d(X - 4, Y, Z + 6), Vector3d(X + 5, Y + 17, Z + 14))
			local FlatlandsWelcome = cBoundingBox(Vector3d(X - 4, Y, Z + 14), Vector3d(X + 5, Y + 17, Z + 20))
			local OverworldWelcome = cBoundingBox(Vector3d(X - 7, Y, Z - 6), Vector3d(X + 6, Y + 25, Z + 1)) 
			local OverworldHub = cBoundingBox(Vector3d(X - 7, Y, Z + 1), Vector3d(X + 6, Y + 25, Z + 5))
			local NetherWelcome = cBoundingBox(Vector3d(X - 1, Y, Z - 7), Vector3d(X + 6, Y + 25, Z + 6))
			local NetherHub = cBoundingBox(Vector3d(X - 5, Y, Z - 7), Vector3d(X - 1, Y + 25, Z + 6))
			if Player:GetWorld():GetName() == "hubflatlands" then
				if HubWorld:IsInside(Position) then
					Player:SendAboveActionBarMessage("Walk into a dimension portal to get started")
				end
				if HubFlatlands:IsInside(Position) then
					Player:SendAboveActionBarMessage(cChatColor.LightGreen .. cChatColor.Bold .. "Flatlands")
				end
				if HubOverworld:IsInside(Position) then
					Player:SendAboveActionBarMessage(cChatColor.LightGreen .. cChatColor.Bold .. "Overworld")
				end
				if HubNether:IsInside(Position) then
					Player:SendAboveActionBarMessage(cChatColor.Rose .. cChatColor.Bold .. "Nether")
				end
				if HubEnd:IsInside(Position) then	
					Player:SendAboveActionBarMessage(cChatColor.Bold .. "The End")
				end			
				if FlatlandsWelcome:IsInside(Position) then					
					Player:SendAboveActionBarMessage(cChatColor.White .. "Welcome to the " ..cChatColor.LightGreen .. cChatColor.Bold ..  "Flatlands")
				end
			elseif Player:GetWorld():GetName() == "overworld" then
				if OverworldWelcome:IsInside(Position) then
				Player:SendAboveActionBarMessage(cChatColor.Gray.. "Welcome to the " .. cChatColor.Green .. cChatColor.Bold .. "Overworld")
				end
				if OverworldHub:IsInside(Position) then
					Player:SendAboveActionBarMessage(cChatColor.Gray.. "Back to the Hub")
				end
			elseif Player:GetWorld():GetName() == "nether" then
				if NetherWelcome:IsInside(Position) then
					Player:SendAboveActionBarMessage(cChatColor.White.. "Welcome to the " .. cChatColor.Red .. cChatColor.Bold .. "Nether")
				end
				if NetherHub:IsInside(Position) then
					Player:SendAboveActionBarMessage(cChatColor.White.. "Back to the Hub")
				end
			end
		end
	)
end

-- Prevents players from using WorldEdit in spawn
function WorldEditCallback(AffectedAreaCuboid, Player, World, Operation)
	local ProtectedCuboid = cCuboid(World:GetSpawnX() - 22, -999999999, World:GetSpawnZ() - 22, World:GetSpawnX() + 21, 999999999, World:GetSpawnZ() + 21)

	if ProtectedCuboid:DoesIntersect(AffectedAreaCuboid) then
		Player:SendAboveActionBarMessage(BuildError)
		return true
	end
end
