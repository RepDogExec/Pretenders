AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

util.AddNetworkString( "use_progress" )

function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/Shoe001a.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType( ONOFF_USE )
	self.Entity:SetName( "clothes" )
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:EnableGravity(true) phys:Wake() end
end

function ENT:SetItemName( name )
	self.itemName = name
end

function ENT:Use( activator, caller, useType, val )
	if activator:Team() == 1 then
		if useType == USE_ON then
			timer.Create( "DRESS_UP", 3, 1, function()
				activator:SetModel("models/player/riot.mdl")
				activator:PrintMessage( HUD_PRINTTALK, "Player " .. activator:Name() .. " pretended to be a cop!" )
				self:Remove()
			end)
			net.Start( "use_progress" )
			net.WriteBit( true )
			net.Send( activator )
		elseif useType == USE_OFF then
			timer.Destroy( "DRESS_UP" )
			net.Start( "use_progress" )
			net.WriteBit( false )
			net.Send( activator )
		end
	end
end

function ENT:Touch( ent )
end

function ENT:OnRemove()
end

function ENT:Think()
end