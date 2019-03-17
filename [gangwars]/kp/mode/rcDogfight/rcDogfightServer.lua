addEventHandler( "onPlayerJoinLobby", root,
function ( dim )
	if lobbys[dim]["type"] == "rcd" then
		rcdSpawn(dim,source)
		setElementData( source, "score", 0 )
		setElementData( source, "canFire", true )
	end
end )

function rcdSpawn( dim, source )
	-- body
	if lobbys[dim] and lobbys[dim]["type"] == "rcd" then
		local lobby = lobbys[dim]
		local pla = source
		setElementPosition( pla, 9999, 9999, 0 )
		spawnPlayer( pla, -1780.2586669922,574.46185302734,260, 0, 284, nil, dim, nil )
		local veh = createVehicle( 464, -1780.2586669922,574.46185302734,260)
		setElementDimension( veh, getElementDimension( pla ) )
		warpPedIntoVehicle( pla, veh )
		setPlayerBlipped( pla )
	end
end

addEventHandler( "onPlayerWasted", root, 
function( totalAmmo, killer, killerWeapon, bodypart )
	if getElementData( source, "dimension" ) > 0 then
		local lobby = lobbys[getElementData( source, "dimension" )]
		if lobby["type"] == "rcd" then
			if killer then
				setElementHealth( killer, getElementHealth( killer )+ 20 ) 
				if source ~= killer then addScore(killer,1) end
			end
			local player = source
			setTimer(  function() rcdSpawn(getElementData( player, "dimension" ),player ) end, 1500, 1)
		end
	end
end )

addEventHandler( "onPlayerSendRequestToLeaveRoom", root, 
function ( )
	local dim = getElementDimension( source )
	if dim ~= 0 and lobbys[dim]["type"] == "rcd" then
		spawn(source)
	end
end )