GM.Name 		= "Source SDK"
GM.Author 		= "Capster"
GM.TeamBased 	= false

color_white = color_white

print = function(...)
	for k,v in pairs({...}) do
		MsgC(color_white, v)
	end
	MsgN("")
end

function GM:Print(...)
	MsgC(Color(255, 165, 0), "[SDK] ") print(...)
end

function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/group02/male_02.mdl")

	ply:EmitSound("sdk/UI/spawn.wav",75,100)

	ply:Give("weapon_physcannon")
	ply:Give("weapon_crowbar")
	ply:Give("weapon_pistol")
	ply:GiveAmmo(150,"pistol")
end

function GM:DoPlayerDeath(ply)
	ply:CreateRagdoll()

	local weapon_class = ply:GetActiveWeapon():GetClass()

	local weapon = ents.Create(weapon_class)

	weapon:SetPos(ply:EyePos() + ply:GetAng():Forward() * 25)
	weapon:SetAng(ply:GetAng())
	weapon:Spawn()
end

function GM:KeyPress(ply, mc)
	if SERVER and mc == IN_USE then
		ply:EmitSound("common/wpn_denyselect.wav",75,100)
	end
end

function GM:GetGameDescription()
	return self.Name
end

function GM:Tick()
end

function GM:OnEntityCreated(entity)
	local id,class = entity:EntIndex(),entity:GetClass()

	if class ~= "prop_physics" then
		self:Print("Entity ["..id.."]["..class.."] spawned")
	end
end

function GM:EntityRemoved(entity)
	local id, class = entity:EntIndex(),entity:GetClass()

	if class ~= "prop_physics" then
		self:Print("Entity ["..id.."]["..class.."] removed")
	end
end
