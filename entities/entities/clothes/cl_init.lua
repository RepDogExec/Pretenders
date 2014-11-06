include("shared.lua")

local drawTip = false

function ENT:Think()
end

function ENT:Draw()
	self:AddEffects( 256 )
    self:DrawModel()
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 200 then
		AddWorldTip( self:EntIndex(), "COP'S CLOTHES", 0.5, self:GetPos(), self  )
	end
end