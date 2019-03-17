addEvent( "spectateForceDim", true )
addEventHandler( "spectateForceDim", root,
function ( dim )
	setElementDimension( source, dim )
	setElementPosition( source, 99999, 99999, 1, false )
	setElementData( source, "spectator", true )
	setElementData( source, "roomname", dim.." Spectator" )
	triggerEvent( "onPlayerRemoveBlip", source )
	if dim == 0 then
		spawn( source )
	end
end )