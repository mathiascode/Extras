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
	"//snow",
	"//sphere",
	"//stack",
	"//thaw",
	"/end",
	"/flatlands",
	"/green",
	"/jumpscare",
	"/kill",
	"/nether",
	"/overworld",
	"/portal",
	"/pumpkins",
	"/snow",
	"/suicide",
	"/thaw",
	"/scare",
	"/setjail",
	"/setwarp",
	"/world",
}

function GetPlayerLookPos(Player)
	local World = Player:GetWorld()
	local Start = Player:GetEyePosition()
	local End = Start + Player:GetLookVector() * 150
	local HitCoords = nil
	local Callbacks =
	{
		OnNextBlock = function(X, Y, Z, BlockType)
			if BlockType ~= E_BLOCK_AIR then
				HitCoords = {x = X, y = Y, z = Z}
				return true
			end
		end
	}
	cLineBlockTracer:Trace(World, Callbacks, Start.x, Start.y, Start.z, End.x, End.y, End.z)
	return HitCoords
end

function MoveToWorld(Player, World)
	local World = cRoot:Get():GetWorld(World)
	Player:SetPitch(0)
	Player:SetYaw(0)
	Player:MoveToWorld(World:GetName())
	HasTeleported[Player:GetUUID()] = true
end

function ShowTitle(Player, Title)
	Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(""))
	Player:GetClientHandle():SendSetSubTitle(cCompositeChat():AddTextPart(Title))
	Player:GetClientHandle():SendTitleTimes(10, 100, 5)
	TitleShown[Player:GetUUID()] = true
end
