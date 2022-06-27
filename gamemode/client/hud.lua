-- oranche manufacturing
-- 2022-06-27

-- HUD

local C_W = Color( 255, 255, 255, 255 )
local C_B = Color( 0, 0, 0, 127 )

function CGSS( size )
	return size * ( ScrH() / 720 )
end

surface.CreateFont( "CGHUD_1", {
	font = "Cascadia Mono",
	size = CGSS(72),
	weight = 0,
	scanlines = 2*0,
	blursize = 5*0,
} )
surface.CreateFont( "CGHUD_2", {
	font = "Bahnschrift",
	size = CGSS(16),
	weight = 0,
} )

function CGHUD_FT( text, font, x, y, ax, ay )
	surface.SetFont(font)

	local zx, zy = surface.GetTextSize(text)

	local tx, ty = Lerp(ax, x, y - zx), Lerp(ay, y, y - zy)

	--surface.SetDrawColor( 0, 0, 0, 127)
	--surface.DrawRect(tx, ty, zx, zy)

	surface.SetTextPos(tx, ty)
	surface.DrawText(text)
end

hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
	local w, h = ScrW(), ScrH()
	local ss = CGSS(1)
	local bb = ss*16

	local P		= LocalPlayer()
	local PW	= LocalPlayer():GetActiveWeapon()

	surface.SetDrawColor( C_B )
	surface.DrawRect( ((w/2)-(ss*160*0.5)), h - bb - (ss*58), (ss*160), (ss*58) )

	surface.SetDrawColor( C_W )
	surface.DrawRect( ((w/2)-(ss*160*0.5)) + (ss*4), h - bb - (ss*4) - (ss*4), (ss*152*(P:Health()/100)), (ss*4) )

	surface.SetTextColor( C_W )
	surface.SetTextPos( ((w/2)-(ss*160*0.5)), h - bb )
	surface.SetFont("CGHUD_1")
	--surface.DrawText(P:Health())

	CGHUD_FT( P:Health(), "CGHUD_1", ((w/2)-(ss*160*0.5)) + (ss*60), h - bb - (ss*0), 0, 1 )
	CGHUD_FT( "HEALTH", "CGHUD_2", ((w/2)-(ss*160*0.5)) + (ss*6), h - bb - (ss*10), 0, 1 )
end )

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true
}

hook.Add( "HUDShouldDraw", "CG_HUDShouldDraw", function( name )
	if ( hide[ name ] ) then return false end
end )