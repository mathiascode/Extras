function GetValue(list)
	local value = {}
	for k, v in ipairs(list) do
		value[v] = true
	end
	return value
end

BlacklistedPickupIDs = GetValue {8, 9, 10, 11, 26, 34, 43, 51, 55, 59, 62, 63, 64, 68, 71, 74, 75, 83, 90, 92, 93, 94, 104, 105, 115, 117, 118, 119, 124, 127, 132, 140, 141, 142, 144, 149, 150, 176, 177, 178, 193, 194, 195, 196, 197, 207, 209, 212}

CooldownCommands = GetValue {
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
	"//set",
	"//snow",
	"//sphere",
	"//stack",
	"//thaw",
	"/green",
	"/jumpscare",
	"/lightning",
	"/portal",
	"/pumpkins",
	"/snow",
	"/thaw",
	"/scare",
	"/setjail",
	"/setwarp",
	"/smite",
	"/strike",
	"/thor",
	"/world",
}

function GetPlayerLookPos(Player)
	local World = Player:GetWorld()
	local Start = Player:GetEyePosition()
	local End = Start + Player:GetLookVector() * 150
	local Callbacks =
	{
		OnNextBlock = function(BlockX, BlockY, BlockZ, BlockType)
			if BlockType ~= E_BLOCK_AIR then
				HitCoords = {x = BlockX, y = BlockY, z = BlockZ}
				return true
			end
		end
	}
	cLineBlockTracer:Trace(World, Callbacks, Start.x, Start.y, Start.z, End.x, End.y, End.z)
	return HitCoords
end

function MoveToWorldCommand(Player, WorldName)
	local World = cRoot:Get():GetWorld(WorldName)
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == WorldName then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
		Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5), false, true)
	end
	Player:SendMessageSuccess("Successfully moved to the " .. WorldName:gsub("^%l", string.upper))
end

function MoveToWorldPortal(Player, World)
	local World = cRoot:Get():GetWorld(World)
	Player:SetPitch(0)
	Player:SetYaw(0)
	Player:MoveToWorld(World:GetName())
	HasTeleported[Player:GetUUID()] = true
end

function SetCommandBlockCommand(Player, Input)
	if Input == "c" then
		CommandBlockActive[Player:GetUUID()] = nil
	else
		if not CommandBlockActive[Player:GetUUID()].World:DoWithCommandBlockAt(CommandBlockActive[Player:GetUUID()].X, CommandBlockActive[Player:GetUUID()].Y, CommandBlockActive[Player:GetUUID()].Z,
			function(CommandBlock)
				CommandBlock:SetCommand(Input)
			end
		) then
			Player:SendMessageFailure("The selected command block doesn't exist anymore")
		else
			Player:SendMessageInfo("The command block command was set to \"" .. Input .. "\"")
		end
		CommandBlockActive[Player:GetUUID()] = nil
	end
end

function ShowTitle(Player, Title)
	Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(""))
	Player:GetClientHandle():SendSetSubTitle(cCompositeChat():AddTextPart(Title))
	Player:GetClientHandle():SendTitleTimes(10, 100, 5)
	TitleShown[Player:GetUUID()] = true
end
