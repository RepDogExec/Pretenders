AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )

util.AddNetworkString( "tooltip" )
util.AddNetworkString( "createStartMenu" )
util.AddNetworkString( "spawnPlayer" )

function GM:PlayerSpawn( ply )
<<<<<<< HEAD
=======
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
>>>>>>> origin/master
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
<<<<<<< HEAD
	ply:PrintMessage( HUD_PRINTTALK, "Welcome, " .. ply:Name() .. "!" )
	net.Start( "createStartMenu" )
	net.Send( ply )
end

net.Receive( "spawnPlayer", function( len, ply ) 
	//self.BaseClass:PlayerSpawn( ply )   
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 ) 
	ply:SetTeam ( net.ReadInt( 32 ) )
	if ( ply:Team() == 1) then
		ply:SetModel("models/player/phoenix.mdl")
		ply:Give("weapon_crowbar")
	else
		ply:SetModel("models/player/riot.mdl")
		ply:Give("weapon_pistol")
		ply:Give("weapon_shotgun")
	end
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
=======
	   ply:PrintMessage( HUD_PRINTTALK, "Welcome, " .. ply:Name() .. "!" )
end
>>>>>>> origin/master
