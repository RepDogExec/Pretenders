include( 'shared.lua' )

local lastpos;

function thirdPerson( ply, pos, ang, fov )
	local eyepos = ply:EyePos()
	local angles = ply:GetAimVector():Angle()
	local offset = Vector(50 + (ply:OBBMaxs().z - ply:OBBMins().z), 0, 10)
	local t = {
		start = eyepos,
		endpos = eyepos
			+ (angles:Forward() * -offset.x)
			+ (angles:Right() * offset.y)
			+ (angles:Up() * offset.z),
		filter = ply
	}
	
	local trace = util.TraceLine(t)
	
	local view = {}
	view.origin = trace.HitPos + ply:GetForward() * 5
	view.angles = ply:EyeAngles()
	view.fov = fov
	return GAMEMODE:CalcView( ply, view.origin, view.angles, view.fov )	
end

net.Receive( "tooltip", function( len, ply )
	NotifyPanel = vgui.Create( "DNotify" )
	NotifyPanel:SetPos( ScrW() / 2 - 110, ScrH() / 2 + 50 )
	NotifyPanel:SetSize( 220, 40 )
	local lbl = vgui.Create( "DLabel", NotifyPanel )
	local entName = net.ReadString()
	lbl:SetTextColor( Color( 255, 220, 0, 150 ) )
	lbl:Dock( FILL )
	lbl:SetText( "Hold \"E\" to use " .. entName )
	lbl:SetFont( "CloseCaption_Normal" )
	NotifyPanel:AddItem( lbl )
end )

net.Receive( "createStartMenu", function ( len, ply )
	local smFrame = vgui.Create( "DFrame" )
	smFrame:SetPos( ScrW()/2 - 200, ScrH()/2 - 120)
	smFrame:SetSize( 400, 240 )
	smFrame:SetTitle( "Select your team" )
	smFrame:SetVisible( true )
	smFrame:SetDraggable( false )
	smFrame:SetSizable(false)
	smFrame:ShowCloseButton( false )
	smFrame:MakePopup( true )
	
	smPanelList = vgui.Create( "DPanelList", smFrame )
	smPanelList:SetPos( 100, 100)
	smPanelList:SetSize( 220, 200 ) 
	smPanelList:SetSpacing( 2 ) 
	smPanelList:EnableHorizontal( false ) 
	smPanelList:EnableVerticalScrollbar( true )
	
	local smButton1 = vgui.Create( "DButton" )
	local smComboBox = vgui.Create( "DComboBox" )
	smComboBox:SetValue( "select team" )
	smComboBox:AddChoice( "cops" )
	smComboBox:AddChoice( "pretenders" )
	local selectIndex
	smComboBox.OnSelect = function( panel, index, value )
		selectIndex = index - 1 
		smButton1:SetDisabled( false )
	end
	smButton1:SetText( "START PLAY" )
	smButton1:SetDisabled( true )
	smButton1.DoClick = function()
		net.Start( "spawnPlayer" )
		net.WriteInt( selectIndex, 32 )
		net.SendToServer( ply )	
		smFrame:Remove()
	end
	smPanelList:AddItem( smComboBox )
	smPanelList:AddItem( smButton1 )
end)

net.Receive( "use_progress", function ( len, ply )
	local val = net.ReadBit()
	if val == 1 then
		DProgress = vgui.Create( "DProgress" )
		DProgress:SetPos( ScrW() / 2 - 110, ScrH() / 2 + 30 )
		DProgress:SetSize( 220, 5 )
		DProgress:SetFraction( 0.0 )
		timer.Create ( "PROGRESS_TIMER", 0.1, 30, function()
			DProgress:SetFraction( DProgress:GetFraction() + 1/30 )
			if DProgress:GetFraction() > 0.999 then
				DProgress:Remove()
			end
		end)
	else
		timer.Destroy( "PROGRESS_TIMER" )
		DProgress:Remove()
	end
end)

hook.Add( "CalcView", "ThirdPerson", thirdPerson );
hook.Add( "ShouldDrawLocalPlayer", "MyShouldDrawLocalPlayer", function( ply )
	if ply:Team() == 0 or ply:Team() == 1 then
		return true
	else
		return false
	end
end )

