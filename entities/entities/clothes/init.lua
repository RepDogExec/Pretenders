AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/Shoe001a.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	self.Entity:SetName( "clothes" )
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:EnableGravity(true) phys:Wake() end
end

function ENT:SetItemName( name )
	self.itemName = name
end

function ENT:Use( activator, caller )
	activator:SetModel("models/player/riot.mdl")
	activator:PrintMessage( HUD_PRINTTALK, "Player " .. activator:Name() .. " pretended to be a cop!" )
	self:Remove()
end

function ENT:Touch( ent )
end

function ENT:OnRemove()
end

function ENT:Think()
end