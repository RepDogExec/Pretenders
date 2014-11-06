include( 'shared.lua' )

function ThirdPerson( ply, pos, ang, fov )
	local view = {};
	view.origin = pos - ( ang:Forward() * 100 );
	view.angles = ang;
	view.angles.p = ang.p - 10;
	view.fov = fov;
			
	return view;
end;
hook.Add( "CalcView", "ThirdPerson", ThirdPerson );
hook.Add( "ShouldDrawLocalPlayer", "MyShouldDrawLocalPlayer", function( ply )
	 return true
end )