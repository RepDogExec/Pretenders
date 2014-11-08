include( 'shared.lua' )

function thirdPerson( ply, pos, ang, fov )
	local view = {};
	view.origin = pos - ( ang:Forward() * 100 );
	view.angles = ang;
	view.angles.p = ang.p - 10;
	view.fov = fov;
	return view;
end

net.Receive( "tooltip", function( len, ply )
	NotifyPanel = vgui.Create( "DNotify" )
	NotifyPanel:SetPos( ScrW() / 2 - 100, ScrH() / 2 + 50 )
	NotifyPanel:SetSize( 300, 40 )
	local lbl = vgui.Create( "DLabel", NotifyPanel )
	local entName = net.ReadString()
	lbl:SetTextColor( Color( 255, 220, 0 ) )
	lbl:Dock( FILL )
	lbl:SetText( "Press \"E\" to use " .. entName )
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
	smFrame:ShowCloseButton( true )
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

hook.Add( "CalcView", "ThirdPerson", thirdPerson );
hook.Add( "ShouldDrawLocalPlayer", "MyShouldDrawLocalPlayer", function( ply )
	 return true
end )

