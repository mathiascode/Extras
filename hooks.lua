-- Quick settings
local JoinTitle = cChatColor.LightGray .. "Welcome to Kaboom.pw!"
local JoinSubtitle = "Free OP • Anarchy"
local BuildError = cChatColor.Rose .. "Go further from spawn to build and destroy"
local SpamError = "Please avoid spamming"

function GetValue(list)
	local value = {}
	for k, v in ipairs(list) do
		value[v] = true
	end
	return value
end

local BlacklistedPickupIDs = GetValue {8, 9, 10, 11, 26, 34, 43, 51, 55, 59, 62, 63, 64, 68, 71, 74, 75, 83, 90, 92, 93, 94, 104, 105, 115, 117, 118, 119, 124, 127, 132, 140, 141, 142, 144, 149, 150, 176, 177, 178, 193, 194, 195, 196, 197, 207, 209, 212}

local CooldownCommands = GetValue {
	"//chunk",
	"//cyl",
	"//drain",
	"//ellipsoid",
	"//expand",
	"//fill",
	"//fillr",
	"//g",
	"//gen",
	"//generate",
	"//green",
	"//hcyl",
	"//hpyramid",
	"//hsphere",
	"//pyramid",
	"//replacenear",
	"//schem",
	"//schematic",
	"//snow",
	"//sphere",
	"//stack",
	"//thaw",
	"/action",
	"/afk",
	"/bc",
	"/broadcast",
	"/bcast",
	"/clearchat",
	"/console",
	"/describe",
	"/end",
	"/flatlands",
	"/green",
	"/jumpscare",
	"/kill",
	"/me",
	"/msg",
	"/nether",
	"/overworld",
	"/portal",
	"/pumpkins",
	"/r",
	"/reload",
	"/restart",
	"/say",
	"/snow",
	"/stop",
	"/suicide",
	"/tell",
	"/thaw",
	"/save-all",
	"/scare",
	"/setjail",
	"/setwarp",
	"/shout",
	"/tellraw",
	"/time",
	"/whisper",
	"/world",
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
	local SpawnArea = cBoundingBox(Vector3d(World:GetSpawnX() - 41, -1000, World:GetSpawnZ() - 41), Vector3d(World:GetSpawnX() + 40, 1000, World:GetSpawnZ() + 40))
	local PlayerLocation = Vector3d(X, Y, Z)

	if SpawnArea:IsInside(PlayerLocation) then
		return true
	end
end

function OnChat(Player, Message)
	if CanMessage[Player:GetUUID()] == 0 then
		Player:SendMessageFailure(SpamError)
		return true
	else
		CanMessage[Player:GetUUID()] = 0
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
		if CanMessage[Player:GetUUID()] == 0 and CooldownCommands[CommandSplit[1]] then
			Player:SendMessageFailure(SpamError)
			return true
		else
			CanMessage[Player:GetUUID()] = 0
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

		if CommandSplit[1] == "//drain" or CommandSplit[1] == "//ex" or CommandSplit[1] == "//expand" or CommandSplit[1] == "//ext" or CommandSplit[1] == "//extinguish" or CommandSplit[1] == "//green" or CommandSplit[1] == "//replacenear" or CommandSplit[1] == "//stack" or CommandSplit[1] == "//thaw" or CommandSplit[1] == "/ex" or CommandSplit[1] == "/green" or CommandSplit[1] == "/pumpkins" or CommandSplit[1] == "/replacenear" or CommandSplit[1] == "/thaw" or CommandSplit[1] == "/snow" then
			if tonumber(CommandSplit[2]) then
				if tonumber(CommandSplit[2]) > 25 or tonumber(CommandSplit[2]) < -25 then
					Player:SendMessageFailure("Please reduce the radius to 25 or below")
					return true
				end
			end
		end

		if CommandSplit[1] == "//fill" or CommandSplit[1] == "//fillr" or CommandSplit[1] == "//sphere" or CommandSplit[1] == "//hsphere" or CommandSplit[1] == "//cyl" or CommandSplit[1] == "//hcyl" or CommandSplit[1] == "//pyramid" or CommandSplit[1] == "//hpyramid" then
			local Radius = StringSplit(CommandSplit[3], ",")
			for i = 1, 3 do
				if tonumber(Radius[i]) then
					if tonumber(Radius[i]) < -25 then
						Player:SendMessageFailure("Please reduce the radius to 25 or below")
						return true
					end
				end
			end
			if StringToItem(CommandSplit[2], Item) then
				if Item.m_ItemType < 0 or Item.m_ItemType > 255 then
					Player:SendMessage(cChatColor.LightPurple .. "Unknown block type: '" .. CommandSplit[2] .. "'.")
					return true
				end
			end
		end

		if CommandSplit[1] == "//re" or CommandSplit[1] == "//rep" or CommandSplit[1] == "//replace" then
			if StringToItem(CommandSplit[2], Item) then
				if Item.m_ItemType < 0 or Item.m_ItemType > 255 then
					Player:SendMessage(cChatColor.Rose .. "Unknown src block type: '" .. CommandSplit[2] .. "'.")
					return true
				end
			end
			if StringToItem(CommandSplit[3], Item) then
				if Item.m_ItemType < 0 or Item.m_ItemType > 255 then
					Player:SendMessage(cChatColor.Rose .. "Unknown dst block type: '" .. CommandSplit[3] .. "'.")
					return true
				end
			end
		end

		if CommandSplit[1] == "//replacenear" or CommandSplit[1] == "/replacenear" then
			if StringToItem(CommandSplit[3], Item) then
				if Item.m_ItemType < 0 or Item.m_ItemType > 255 then
					Player:SendMessage(cChatColor.Rose .. "Unknown src block type: '" .. CommandSplit[3] .. "'.")
					return true
				end
			end
			if StringToItem(CommandSplit[4], Item) then
				if Item.m_ItemType < 0 or Item.m_ItemType > 255 then
					Player:SendMessage(cChatColor.Rose .. "Unknown dst block type: '" .. CommandSplit[4] .. "'.")
					return true
				end
			end
		end

		if CommandSplit[1] == "//set" and StringToItem(CommandSplit[2], Item) then
			if Item.m_ItemType < 0 or Item.m_ItemType > 255 then
				Player:SendMessage(cChatColor.Rose .. "Unknown dst block type: '" .. CommandSplit[2] .. "'.")
				return true
			end
		end
	end
end

function OnExploding(World, ExplosionSize, CanCauseFire, X, Y, Z, Source, SourceData)
	ExplosionCount = ExplosionCount + 1
	if IsInSpawn(X, Y, Z, World:GetName()) or ExplosionCount > 50 then
		return true
	end
end

function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, Status, BlockType, BlockMeta)
	if IsInSpawn(BlockX, BlockY, BlockZ, Player:GetWorld():GetName()) then
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
	-- Secret in the hub ;)
	if Player:GetWorld():GetName() == "flatlands" and BlockX == 0 and BlockY == 11 and BlockZ == 2 then
		Player:GetWorld():BroadcastParticleEffect("heart", 0, 12, 2, 2, 1, 0.5, 0, 40)
	end
end

function OnPlayerJoined(Player)
	Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(JoinTitle))
	Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(JoinSubtitle)))
	Player:GetClientHandle():SendTitleTimes(10, 160, 5)
end

function OnPlayerMoving(Player, OldPosition, NewPosition)
	-- Shows messages about different worlds in the hub, and creates portals
	local X = Player:GetWorld():GetSpawnX()
	local Y = Player:GetWorld():GetSpawnY()
	local Z = Player:GetWorld():GetSpawnZ()
	local World = Player:GetWorld():GetName()

	-- Message coordinates
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

	-- Portal coordinates
	local HubToEnd = cBoundingBox(Vector3d(X - 20, Y, Z - 4), Vector3d(X - 13, Y + 5, Z + 4))
	local HubToNether = cBoundingBox(Vector3d(X + 13, Y, Z - 4), Vector3d(X + 20, Y + 5, Z + 4))
	local HubToOverworld = cBoundingBox(Vector3d(X - 4, Y, Z - 20), Vector3d(X + 4, Y + 5, Z - 13))
	local OverworldToHub = cBoundingBox(Vector3d(X - 1, Y, Z + 5), Vector3d(X + 1, Y + 4, Z + 6))
	local NetherToHub = cBoundingBox(Vector3d(X - 6, Y, Z - 1), Vector3d(X - 5, Y + 4, Z + 1))

	if World == "flatlands" then
		if not HubWorld:IsInside(NewPosition) and not HubFlatlands:IsInside(NewPosition) and not HubOverworld:IsInside(NewPosition) and not HubNether:IsInside(NewPosition) and not HubEnd:IsInside(NewPosition) and not FlatlandsWelcome:IsInside(NewPosition) and not HubToEnd:IsInside(NewPosition) and not HubToNether:IsInside(NewPosition) and not HubToOverworld:IsInside(NewPosition) then
			IsInside[Player:GetUUID()] = nil
		elseif HubWorld:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 1 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart("Walk into a dimension portal to get started")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 1
		elseif HubFlatlands:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 2 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.LightGreen .. cChatColor.Bold .. "Flatlands")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 2
		elseif HubOverworld:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 3 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.LightGreen .. cChatColor.Bold .. "Overworld")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 3
		elseif HubNether:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 4 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.Rose .. cChatColor.Bold .. "Nether")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 4
		elseif HubEnd:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 5 then	
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.Bold .. "The End")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 5
		elseif FlatlandsWelcome:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 6 then					
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.White .. "Welcome to the " ..cChatColor.LightGreen .. cChatColor.Bold ..  "Flatlands")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 6
		elseif HubToEnd:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 7 then
			Player:SetPitch(0)
			Player:SetYaw(90)
			Player:MoveToWorld("end")
			IsInside[Player:GetUUID()] = 7
		elseif HubToNether:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 8 then
			Player:SetPitch(0)
			Player:SetYaw(-90)
			Player:MoveToWorld("nether")
			IsInside[Player:GetUUID()] = 8
		elseif HubToOverworld:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 9 then
			Player:SetPitch(0)
			Player:SetYaw(180)
			Player:MoveToWorld("overworld")
			IsInside[Player:GetUUID()] = 9
		end
	elseif World == "overworld" then
		if not OverworldWelcome:IsInside(NewPosition) and not OverworldHub:IsInside(NewPosition) and not OverworldToHub:IsInside(NewPosition) then
			IsInside[Player:GetUUID()] = nil
		elseif OverworldWelcome:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 10 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.White.. "Welcome to the " .. cChatColor.LightGreen .. cChatColor.Bold .. "Overworld")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 10
		elseif OverworldHub:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 11 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.White.. "Back to the Hub")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 11
		elseif OverworldToHub:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 12 then
			Player:SetPitch(0)
			Player:SetYaw(0)
			Player:MoveToWorld("flatlands")
			IsInside[Player:GetUUID()] = 12
		end
	elseif World == "nether" then
		if not NetherWelcome:IsInside(NewPosition) and not NetherHub:IsInside(NewPosition) and not NetherToHub:IsInside(NewPosition) then
			IsInside[Player:GetUUID()] = nil
		elseif NetherWelcome:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 13 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.White.. "Welcome to the " .. cChatColor.Rose .. cChatColor.Bold .. "Nether")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 13
		elseif NetherHub:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 14 then
			Player:GetClientHandle():SendSetTitle((cCompositeChat()))
			Player:GetClientHandle():SendSetSubTitle((cCompositeChat():AddTextPart(cChatColor.White.. "Back to the Hub")))
			Player:GetClientHandle():SendTitleTimes(10, 100, 5)
			IsInside[Player:GetUUID()] = 14
		elseif NetherToHub:IsInside(NewPosition) and IsInside[Player:GetUUID()] ~= 15 then
			Player:SetPitch(0)
			Player:SetYaw(0)
			Player:MoveToWorld("flatlands")
			IsInside[Player:GetUUID()] = 15
		end
	end
end

function OnServerPing(ClientHandle, ServerDescription, OnlinePlayers, MaxPlayers)
	local ServerDescription = ServerDescription:gsub("	", "\n")
	local MaxPlayers = OnlinePlayers + 1
	return false, ServerDescription, OnlinePlayers, MaxPlayers
end

function OnSpawningEntity(World, Entity)
	if Entity:IsMob() then
		MobCount = MobCount + 1
		if MobCount > 15 then
			return true
		end
	end

	if Entity:IsPickup() then
		if not Entity:IsPlayerCreated() or BlacklistedPickupIDs[Entity:GetItem().m_ItemType] then
			return true
		end
	end

	if Entity:IsTNT() then
		TNTCount = TNTCount + 1
		if TNTCount > 30 then
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
		TNTCount = 0
		cRoot:Get():ForEachPlayer(
			function(Player)
				CanMessage[Player:GetUUID()] = nil
			end
		)

		-- Overwrite spawn by using schematic
		Area:Write(cRoot:Get():GetWorld("flatlands"), -24, 0, -24)

		-- If the server is stuck, this file won't update. An OS-side script checks when the file was last modified, and restarts the server if too much time has passed since the last modification.
		os.remove("update")
		file = io.open("update", "a")
		file:close()
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
function WorldEditCallback(AffectedAreaCuboid, Player, World, Operation)
	local ProtectedCuboid = cCuboid(World:GetSpawnX() - 41, -1000, World:GetSpawnZ() - 41, World:GetSpawnX() + 40, 1000, World:GetSpawnZ() + 40)

	if ProtectedCuboid:DoesIntersect(AffectedAreaCuboid) then
		Player:SendAboveActionBarMessage(BuildError)
		return true
	end
end
