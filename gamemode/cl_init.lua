include( 'shared.lua' )

function thirdPerson( ply, pos, ang, fov )
	local view = {};
	view.origin = pos - ( ang:Forward() * 100 );
	view.angles = ang;
	view.angles.p = ang.p - 10;
	view.fov = fov;
	return view;
end;

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

hook.Add( "CalcView", "ThirdPerson", thirdPerson );
hook.Add( "ShouldDrawLocalPlayer", "MyShouldDrawLocalPlayer", function( ply )
	 return true
end )