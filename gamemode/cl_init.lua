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
	 return true
end )