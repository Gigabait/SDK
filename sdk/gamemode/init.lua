include("shared.lua")

function GM:Think()
end

function GM:EntityTakeDamage(ent, info)
end

function GM:CreateEntityRagdoll(entity, ragdoll)
end

local function HostnameThink()
	SetGlobalString("ServerName", GetHostName())
end

timer.Create("HostnameThink", 30, 0, HostnameThink)

function GM:ShowTeam()
end

function GM:CheckPassword(steamid, networkid, server_password, password, name)
	if server_password ~= "" then
		if server_password ~= password then
			return false, "#GameUI_ServerRejectBadPassword"
		end
	end
	
	return true
end
