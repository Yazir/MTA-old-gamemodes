function dmOutsideAreaCheck( )
	local dim = getElementDimension( localPlayer )
	if dim>0 and lobbys and lobbys[dim] and lobbys[dim]["type"] == "dm" and not getElementData( localPlayer, "spectator" ) and isElement(lobbys[dim]["dmArea"]) then
		local x,y = getElementPosition(localPlayer)
		if isInsideRadarArea( lobbys[dim]["dmArea"], x, y ) == false then
			setElementHealth( localPlayer, getElementHealth( localPlayer )-2.5 )
			playSoundFrontEnd( 49 )
		end
	end
end
setTimer( dmOutsideAreaCheck, 500, 0 )