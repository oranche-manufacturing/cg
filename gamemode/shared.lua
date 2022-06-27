-- oranche manufacturing
-- 2022-06-27

-- Shared initialization

function GM:PlayerNoClip( pl, on )
	if ( !on ) then return true end
	-- Allow noclip if we're in single player and living
	return IsValid( pl ) && pl:Alive()
end