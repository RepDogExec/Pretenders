AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )

util.AddNetworkString( "tooltip" )

function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply )   
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 ) 
	ply:SetModel("models/player/phoenix.mdl")
	
	local item = ents.Create( "clothes" )
	item:SetNWString( "name", "clothes" )
	item:SetNWString( "itemName", name )
	item:SetNWInt( "uID", 1 )
	item:SetNWBool( "pickup", true )
	item:SetNWEntity( "owner", ply )
	item:SetItemName("clothes")
	item:Spawn()
	item:Activate()
end

function GM:PlayerTick( ply, cmd ) 
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 300
	trace.filter = ply
	local tr = util.TraceLine(trace)
	
	if (tr.HitWorld) then return end
	if tr.Entity:IsValid() and tr.Entity:GetNWBool( "pickup" ) then
		net.Start( "tooltip" )
		net.WriteString( tr.Entity:GetName() )
		net.Send( ply )
	end
end

function GM:PlayerLoadout( ply )
end

function GM:PlayerInitialSpawn( ply )
	   ply:PrintMessage( HUD_PRINTTALK, "Welcome, " .. ply:Name() .. "!" )
end
