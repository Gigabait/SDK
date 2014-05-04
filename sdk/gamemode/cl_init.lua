include("shared.lua")

surface.CreateFont("hl2c_crosshair", {font = "HL2Cross", size = 50, weight = 430, blursize = 0, scanlines = 0, antialias = true})

function GM:HUDPaint()

	local me = LocalPlayer()

	local crosshair_x		= surface.ScreenWidth() * 0.5
	local crosshair_y		= surface.ScreenHeight() * 0.5
	local crosshair_color	= Color(255,220,0,220)
	local crosshair_spacing	= 15

	draw.SimpleText("[","hl2c_crosshair",crosshair_x - crosshair_spacing,crosshair_y,crosshair_color,2,1)
	draw.SimpleText("]","hl2c_crosshair",crosshair_x + crosshair_spacing,crosshair_y,crosshair_color,0,1)

	local trace = me:GetEyeTrace()

	if IsValid(trace.Entity) then
		local pos = trace.Entity:GetPos():ToScreen()
		draw.SimpleText(trace.Entity:GetClass(),"DebugFixed",pos.x,pos.y,Color(255,255,255,255),2,1)
	end

	surface.SetDrawColor(0, 0, 0, 220)
	surface.SetTextColor(255,255,255,255)
	surface.SetFont("DebugFixed")
	local _, h = surface.GetTextSize("<<I")
	
	surface.DrawRect(0, 0, 200, h*6+10)

	surface.SetTextPos(10, 3)
	surface.DrawText("Engine statistics")

	surface.SetTextPos(10, 3 + h)
	surface.DrawText("FPS: "..math.floor(1/FrameTime()))

	surface.SetTextPos(10, h*3)
	surface.DrawText("LocalPlayer statistics")

	local vel = me:GetVelocity():Length()

	surface.SetTextPos(10, h*4)
	surface.DrawText("Velocity: "..math.Round(vel,1))

	local ping = me:Ping()

	surface.SetTextPos(10, h*5)
	surface.DrawText("Ping: "..math.Round(ping,1))
end

local halo_FakeColor,halo_RealColor = Color(0,0,0,0),Color(0,0,0,0)

function GM:PreDrawHalos()

	local player = LocalPlayer()

	local entity = player:GetEyeTrace().Entity

	if entity ~= NULL and entity:GetClass() != "worldspawn" then
		local size = 2 + math.sin(CurTime() * 5) * 0.75
		halo.Add({entity},Color(0,255,0,255),size,size,1)
	end

end
