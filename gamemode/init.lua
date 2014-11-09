AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )
include( 'player.lua' )

util.AddNetworkString( "tooltip" )
util.AddNetworkString( "createStartMenu" )
util.AddNetworkString( "spawnPlayer" )

function GM:PlayerSpawn( ply )

end

function GM:PlayerTick( ply, cmd ) 
	if ply:Team() == 1 then
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
end

function GM:PlayerLoadout( ply )
end

function GM:PlayerInitialSpawn( ply )
	ply:PrintMessage( HUD_PRINTTALK, "Welcome, " .. ply:Name() .. "!" )
	ply:SetTeam ( -1 )
	net.Start( "createStartMenu" )
	net.Send( ply )
end

net.Receive( "spawnPlayer", function( len, ply )  
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 ) 
	ply:PrdsSetTeam ( net.ReadInt( 32 ) )
	local item = ents.Create( "clothes" )
	item:SetNWString( "name", "clothes" )
	item:SetNWString( "itemName", name )
	item:SetNWInt( "uID", 1 )
	item:SetNWBool( "pickup", true )
	item:SetNWEntity( "owner", ply )
	item:SetItemName("clothes1")
	item:Spawn()
	item:Activate()	
end )
