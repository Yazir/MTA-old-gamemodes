local spectPlayers = {}
local spectDim = 0
local spectIndex = 1
function spectateStart( dim )
	dim = tonumber( dim )
	if dim then
		if dim ~= spectDim then spectDim = dim spectIndex = 1 end
		spectPlayers = {}
		for k,v in ipairs( getElementsByType( "player" ) ) do
			if getElementDimension( v ) == spectDim and not getElementData( v, "spectator" ) then
				spectPlayers[#spectPlayers+1] = v
			end
		end
		bindKey("a", "down", function() spectateNext( -1 ) end)
		bindKey("d", "down", function() spectateNext( 1 ) end)
		bindKey("f2", "down", spectateQuit)
		spectateRefresh( )
	end
end

function spectateNext( val )
	spectIndex = spectIndex+val
	spectateRefresh( )
end

function spectateRefresh( )
	setTimer(
	function ( )
		--if spectIndex > #spectPlayers then spectIndex = 0 end
		--if spectIndex < 1 then spectIndex = #spectPlayers end
		if spectIndex > #spectPlayers then spectIndex = 1
		elseif spectIndex < 1 then spectIndex = #spectPlayers end

		if #spectPlayers == 0 then spectateQuit( ) return end
		if getElementDimension( spectPlayers[spectIndex] ) ~= spectDim then spectateQuit( ) return end
		setCameraTarget( spectPlayers[spectIndex] )
		setElementData( localPlayer, "spectator", true )
		setElementDimension( localPlayer, spectDim )
		setElementInterior( localPlayer, getElementInterior( spectPlayers[spectIndex] ) ) 
		triggerServerEvent( "spectateForceDim", localPlayer, spectDim )
	end, 500, 1 )
end

function spectatorLobbyChange( dim )
	if spectDim ~= 0 then
		if dim == spectDim then
			spectateStart( dim )
		end
	end
end
--addEventHandler( "onClientPlayerQuit", root, function( ) spectatorLobbyChange( setElementDimension( source ) ) end )
addEventHandler( "onClientJoinLobby", root, function( ) spectatorLobbyChange( getElementDimension( source ) ) end  )
addEventHandler( "onClientLeaveLobby", root, function( dim ) spectatorLobbyChange( dim ) end )

function spectateQuit( )
	setCameraTarget( localPlayer )
	spectPlayers = {}
	spectDim = 0
	spectIndex = 1
	unbindKey( "a" )
	unbindKey( "d" )
	unbindKey( "f2", "down", spectateQuit )
	setElementInterior( localPlayer, 0 ) 
	triggerServerEvent( "spectateForceDim", localPlayer, 0 )
end

addCommandHandler( "spectate", function ( cmd, arg ) spectateStart( arg ) end )