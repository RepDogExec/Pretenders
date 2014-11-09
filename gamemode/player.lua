local ply = FindMetaTable("Player")

function ply:PrdsSetTeam ( teamNum )
	self:SetTeam ( teamNum )
	
	if ( teamNum == 0) then
		self:SetModel("models/player/riot.mdl")
		self:Give( "weapon_stunstick" )
		self:Give("weapon_pistol")
		self:Give("weapon_empty_hands")
		self:GiveAmmo( 150, "Pistol", false )
		self:Give("weapon_shotgun")
		self:GiveAmmo( 30, "Buckshot", false )
		self:SetActiveWeapon( Camera )
		self:AllowFlashlight( true )
	end
	if ( teamNum == 1) then
		self:SetModel("models/player/phoenix.mdl")
		self:Give("weapon_crowbar")
		self:Give("weapon_empty_hands")
		self:SetActiveWeapon( Camera )
	end
end