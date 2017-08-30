-- Quick settings
local JoinTitle = cChatColor.LightGray .. "Welcome to Kaboom.pw!"
local JoinSubtitle = "Free OP • Anarchy • Creative"

function OnChat(Player, Message)
	if CommandBlockActive[Player:GetUUID()] then
		if Message == "c" then
			CommandBlockActive[Player:GetUUID()] = nil
		else
			if not CommandBlockActive[Player:GetUUID()].World:DoWithCommandBlockAt(CommandBlockActive[Player:GetUUID()].X, CommandBlockActive[Player:GetUUID()].Y, CommandBlockActive[Player:GetUUID()].Z,
				function(CommandBlock)
					CommandBlock:SetCommand(Message)
				end
			) then
				Player:SendMessageFailure("The selected command block doesn't exist anymore")
			else
				Player:SendMessageInfo("The command block command was set to \"" .. Message .. "\"")
			end
			CommandBlockActive[Player:GetUUID()] = nil
		end
		return true
	end

	if NickList[Player:GetUUID()] == nil then
		PlayerName = Player:GetName()
	else
		PlayerName = NickList[Player:GetUUID()]
	end

	local Rank = cRankManager:GetPlayerRankName(Player:GetUUID())
	local Message = Message:gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random) :gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

	if Rank == "" or Rank == "op" then
		cRoot:Get():BroadcastChat(cChatColor.Red..cChatColor.Bold.. "[" ..cChatColor.Rose..cChatColor.Bold.. "OP" ..cChatColor.Red..cChatColor.Bold.."] " ..cChatColor.Rose .. PlayerName .. cChatColor.Red..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "deop" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "DEOP" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "founder" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "FOUNDER" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "owner" then
		cRoot:Get():BroadcastChat(cChatColor.Blue..cChatColor.Bold.. "[" ..cChatColor.LightBlue..cChatColor.Bold.. "OWNER" ..cChatColor.Blue..cChatColor.Bold.. "] " ..cChatColor.LightBlue .. PlayerName .. cChatColor.Blue..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "admin" then
		cRoot:Get():BroadcastChat(cChatColor.Gold..cChatColor.Bold.. "[" ..cChatColor.Yellow..cChatColor.Bold.. "ADMIN" ..cChatColor.Gold..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Gold..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "moderator" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "MODERATOR" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "hacker" then
		cRoot:Get():BroadcastChat(cChatColor.Blue..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "H" ..cChatColor.LightBlue..cChatColor.Bold.. "A" ..cChatColor.Rose..cChatColor.Bold.. "C" ..cChatColor.LightPurple..cChatColor.Bold.. "K" ..cChatColor.Yellow..cChatColor.Bold.. "E" ..cChatColor.LightGreen..cChatColor.Bold.. "R" ..cChatColor.Blue..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Blue..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "vip" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "VIP" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "helper" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "HELPER" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "builder" then
		cRoot:Get():BroadcastChat(cChatColor.Gold..cChatColor.Bold.. "[" ..cChatColor.Yellow..cChatColor.Bold.. "BUILDER" ..cChatColor.Gold..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Gold..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "manager" then
		cRoot:Get():BroadcastChat(cChatColor.Blue..cChatColor.Bold.. "[" ..cChatColor.LightBlue..cChatColor.Bold.. "MANAGER" ..cChatColor.Blue..cChatColor.Bold.. "] " ..cChatColor.LightBlue .. PlayerName .. cChatColor.Blue..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "troll" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "T" ..cChatColor.White..cChatColor.Bold.. "R" ..cChatColor.LightGray..cChatColor.Bold.. "O" ..cChatColor.White..cChatColor.Bold.. "L" ..cChatColor.LightGray..cChatColor.Bold.. "L" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "griefer" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "GRIEFER" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "noob" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "NOOB" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.Rose .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "developer" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "DEVELOPER" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "trusted" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "TRUSTED" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "supporter" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "SUPPORTER" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "worldeditor" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "WORLDEDITOR" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.LightPurple .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "legend" then
		cRoot:Get():BroadcastChat(cChatColor.Purple..cChatColor.Bold.. "[" ..cChatColor.LightPurple..cChatColor.Bold.. "L" ..cChatColor.Yellow..cChatColor.Bold.. "E" ..cChatColor.LightPurple..cChatColor.Bold.. "G" ..cChatColor.Yellow..cChatColor.Bold.. "E" ..cChatColor.LightPurple..cChatColor.Bold.. "N" ..cChatColor.Yellow..cChatColor.Bold.. "D" ..cChatColor.Purple..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Purple..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "master" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "MASTER" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "donator" then
		cRoot:Get():BroadcastChat(cChatColor.Gold..cChatColor.Bold.. "[" ..cChatColor.Yellow..cChatColor.Bold.. "DONATOR" ..cChatColor.Gold..cChatColor.Bold.. "] " ..cChatColor.Yellow .. PlayerName .. cChatColor.Gold..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "pyromaniac" then
		cRoot:Get():BroadcastChat(cChatColor.Red..cChatColor.Bold.. "[" ..cChatColor.Rose..cChatColor.Bold.. "PYRO" ..cChatColor.Red..cChatColor.Bold.. "] " ..cChatColor.Rose .. PlayerName .. cChatColor.Red..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "youtuber" then
		cRoot:Get():BroadcastChat(cChatColor.Red..cChatColor.Bold.. "[" ..cChatColor.Rose..cChatColor.Bold.. "YOUTUBER" ..cChatColor.Red..cChatColor.Bold.. "] " ..cChatColor.Rose .. PlayerName .. cChatColor.Red..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "mojang" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightBlue..cChatColor.Bold.. "M" ..cChatColor.Rose..cChatColor.Bold.. "O" ..cChatColor.LightPurple..cChatColor.Bold.. "J" ..cChatColor.Yellow..cChatColor.Bold.. "A" ..cChatColor.LightGreen..cChatColor.Bold.. "N" ..cChatColor.LightBlue..cChatColor.Bold.. "G" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "hero" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "HERO" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "bot" then
		cRoot:Get():BroadcastChat(cChatColor.Gray..cChatColor.Bold.. "[" ..cChatColor.LightGray..cChatColor.Bold.. "BOT" ..cChatColor.Gray..cChatColor.Bold.. "] " ..cChatColor.LightGray .. PlayerName .. cChatColor.Gray..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	elseif Rank == "co-owner" then
		cRoot:Get():BroadcastChat(cChatColor.Green..cChatColor.Bold.. "[" ..cChatColor.LightGreen..cChatColor.Bold.. "CO-OWNER" ..cChatColor.Green..cChatColor.Bold.. "] " ..cChatColor.LightGreen .. PlayerName .. cChatColor.Green..cChatColor.Bold.. " > " ..cChatColor.White.. Message)
	end
	return true, Message
end

function OnEntityChangingWorld(Entity, World)
	if Entity:IsPlayer() then
		local Dimension = World:GetDimension()
		if Dimension == dimEnd then
			Color = cChatColor.LightGray
		elseif Dimension == dimNether then
			Color = cChatColor.Rose
		else
			Color = cChatColor.LightGreen
		end
		if World:GetName() ~= "hub" and cRoot:Get():GetWorld("hub") then
			Entity:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(Color .. World:GetName():gsub("^%l", string.upper)))
			Entity:GetClientHandle():SendSetSubTitle(cCompositeChat():AddTextPart(cChatColor.White .. "Return to the hub by typing /hub in chat"))
			Entity:GetClientHandle():SendTitleTimes(10, 100, 5)
		end
	end
end

function OnExecuteCommand(Player, CommandSplit, EntireCommand)
	if Player then
		-- Checks if the player is spamming the specified commands
		if CanMessage[Player:GetUUID()] == false and CooldownCommands[CommandSplit[1]] then
			Player:SendMessageFailure("Please avoid spamming")
			return true, cPluginManager.crExecuted
		else
			CanMessage[Player:GetUUID()] = false
		end
		if CommandSplit[1] == "/regen" then
			return true, cPluginManager.crUnknownCommand
		end
		if CommandSplit[1] == "/bc" or CommandSplit[1] == "/bcast" or CommandSplit[1] == "/broadcast" then
			if CommandSplit[2] then
				local Message = table.concat(CommandSplit, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

				cRoot:Get():BroadcastChat(cChatColor.Red .. "[BROADCAST] " .. cChatColor.Rose .. Message)
				return true, cPluginManager.crExecuted
			end
		end
	end
end

function OnExploding(World, ExplosionSize, CanCauseFire, X, Y, Z, Source, SourceData)
	ExplosionCount = ExplosionCount + 1
	if World:GetName() == "hub" or ExplosionCount > 50 then
		return true
	end
end

function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
	if Player:GetWorld():GetName() == "hub" then
		return true
	end
end

function OnPlayerPlacingBlock(Player, BlockX, BlockY, BlockZ, BlockType, BlockMeta)
	if Player:GetWorld():GetName() == "hub" then
		return true
	end
end

function OnPlayerJoined(Player)
	local Rank = cRankManager:GetPlayerRankName(Player:GetUUID())
	if Rank == "" or Rank == "deop" then
		cRankManager:SetPlayerRank(Player:GetUUID(), Player:GetName(), "op")
		Player:LoadRank()
	end
	Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(JoinTitle))
	Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(JoinSubtitle)))
	Player:GetClientHandle():SendTitleTimes(10, 160, 5)
end

function OnPlayerMoving(Player, OldPosition, NewPosition)
	if Player:GetWorld():GetName() == "hub" then
		if not TitleShown[Player:GetUUID()] then
			if TitleEnd:IsInside(NewPosition) then
				ShowTitle(Player, cChatColor.LightGray .. cChatColor.Bold .. "End")
			elseif TitleFlatlands:IsInside(NewPosition) then
				ShowTitle(Player, cChatColor.LightGreen .. cChatColor.Bold .. "Flatlands")
			elseif TitleNether:IsInside(NewPosition) then
				ShowTitle(Player, cChatColor.Rose .. cChatColor.Bold .. "Nether")
			elseif TitleOverworld:IsInside(NewPosition) then
				ShowTitle(Player, cChatColor.LightGreen .. cChatColor.Bold .. "Overworld")
			elseif PortalEnd:IsInside(NewPosition) then
				MoveToWorld(Player, "end")
				return true
			elseif PortalFlatlands:IsInside(NewPosition) then
				MoveToWorld(Player, "flatlands")
				return true
			elseif PortalNether:IsInside(NewPosition) then
				MoveToWorld(Player, "nether")
				return true
			elseif PortalOverworld:IsInside(NewPosition) then
				MoveToWorld(Player, "overworld")
				return true
			end
		elseif not TitleEnd:IsInside(NewPosition) and not TitleFlatlands:IsInside(NewPosition) and not TitleNether:IsInside(NewPosition) and not TitleOverworld:IsInside(NewPosition) then
			TitleShown[Player:GetUUID()] = nil
		elseif not PortalEnd:IsInside(NewPosition) and not PortalFlatlands:IsInside(NewPosition) and not PortalNether:IsInside(NewPosition) and not PortalOverworld:IsInside(NewPosition) then
			HasTeleported[Player:GetUUID()] = nil
		end
	end
	local LookPos = GetPlayerLookPos(Player)
	if LookPos and not Player:GetWorld():DoWithCommandBlockAt(LookPos.x, LookPos.y, LookPos.z,
		function(CommandBlock)
			if HideOutput[Player:GetUUID()] == nil then
				if CommandBlock:GetCommand() ~= "" then
					Player:SendMessage("Command Block Command: " .. CommandBlock:GetCommand())
				end
				if CommandBlock:GetLastOutput() ~= "" then
					Player:SendMessage("Command Block Result: " .. CommandBlock:GetLastOutput())
				end
				HideOutput[Player:GetUUID()] = true
			end
		end
	) then
		HideOutput[Player:GetUUID()] = nil
	end
end

function OnPlayerRightClick(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ)
	if Player:GetWorld():GetBlock(BlockX, BlockY, BlockZ) == E_BLOCK_COMMAND_BLOCK then
		Player:SendMessageInfo("Type the command you want to use in the command block in chat (type \"c\" to cancel):")
		CommandBlockActive[Player:GetUUID()] = {World = Player:GetWorld(), X = BlockX, Y = BlockY, Z = BlockZ}
		return true
	end
end

function OnServerPing(ClientHandle, ServerDescription, OnlinePlayers, MaxPlayers)
	local ServerDescription = ServerDescription:gsub("	", "\n")
	local MaxPlayers = OnlinePlayers + 1
	return false, ServerDescription, OnlinePlayers, MaxPlayers
end

function OnSpawningEntity(World, Entity)
	if Entity:IsPickup() then
		if not Entity:IsPlayerCreated() or BlacklistedPickupIDs[Entity:GetItem().m_ItemType] then
			return true
		end
	end

	if World:GetName() == "hub" then
		if Entity:IsPainting() or Entity:IsFallingBlock() or Entity:IsItemFrame() then
			return true
		end
	end
end

function OnTick(TimeDelta)
	if GlobalTime == 75 then
		-- Resets different checks
		ExplosionCount = 0
		cRoot:Get():ForEachPlayer(
			function(Player)
				CanMessage[Player:GetUUID()] = nil
			end
		)

		-- If the server is stuck, this file won't update. An OS-side script checks when the file was last modified, and restarts the server if too much time has passed since the last modification.
		os.remove(".update")
		file = io.open(".update", "a")
		file:close()

		-- Overwrite spawn by using schematic
		Area:Write(cRoot:Get():GetWorld("hub"), Area:GetWEOffset().x, 62, Area:GetWEOffset().z, cBlockArea.baTypes + cBlockArea.baMetas)

		GlobalTime = 0
	else
		GlobalTime = GlobalTime + 1
	end
end

function OnUpdatingSign(World, BlockX, BlockY, BlockZ, Line1, Line2, Line3, Line4, Player)
	-- Limits the amount of characters on a sign, fixing an exploit where too much data in signs cause lag
	local Line1 = string.sub(Line1, 1, 45)
	local Line2 = string.sub(Line2, 1, 45)
	local Line3 = string.sub(Line3, 1, 45)
	local Line4 = string.sub(Line4, 1, 45)
	return false, Line1, Line2, Line3, Line4
end

-- Prevents players from using WorldEdit in spawn
function WorldEditCallback(WorldEditCuboid, Player, World, Operation)
	if World:GetName() == "hub" then
		return true
	end
	if Operation == "addleaves" or Operation == "cut" or Operation == "faces" or Operation == "fill" or Operation == "generate" or Operation == "leafdecay" or Operation == "mirror" or Operation == "paste" or Operation == "stack" or Operation == "vmirror" or Operation == "walls" then
		if WorldEditCuboid:DifX() > 400 or WorldEditCuboid:DifY() > 400 or WorldEditCuboid:DifZ() > 400 then
                        Player:SendMessageFailure("Your selection is too large")
                        return true
                end
	else
		if WorldEditCuboid:DifX() > 100 or WorldEditCuboid:DifY() > 100 or WorldEditCuboid:DifZ() > 100 then
			Player:SendMessageFailure("Your selection is too large")
			return true
		end
	end
end
