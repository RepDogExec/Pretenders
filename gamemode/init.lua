AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( 'shared.lua' )

function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply )   
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
    ply:SetWalkSpeed( 190 )  
    ply:SetRunSpeed ( 235 ) 
	ply:SetModel("models/player/dod_german.mdl")
	
	local item = ents.Create( "clothes" )
	item:SetNWString( "name", "clothes" )
	item:SetNWString( "itemName", name )
	item:SetNWInt( "uID", 1 )
	item:SetNWBool( "pickup", true )
	item:SetNWEntity( "owner", ply )
	item:SetItemName("clothes1")
	item:Spawn()
	item:Activate()
end

function GM:PlayerLoadout( ply )
	
end

function GM:PlayerInitialSpawn( ply )
	   ply:PrintMessage( HUD_PRINTTALK, "Welcome, " .. ply:Name() .. "!" )
end