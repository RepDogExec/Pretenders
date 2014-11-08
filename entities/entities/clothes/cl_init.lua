include("shared.lua")

local drawTip = false

function ENT:Think()
end

function ENT:Draw()
	self:AddEffects( 256 )
    self:DrawModel()
end