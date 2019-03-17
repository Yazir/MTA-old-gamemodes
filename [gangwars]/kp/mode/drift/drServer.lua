addEventHandler( "onPlayerJoinLobby", root,
function ( dim )
	drSpawn(dim,source)
	if lobbys[dim]["type"] == "dr" and lobbys[dim]["cur"] == 1 then
	end
end )

local vehs = {429, 562, 496, 589}
function drSpawn( dim, source )
	if lobbys[dim]["type"] == "dr" then
		local player = source
		local lobby = lobbys[dim]
		spawnPlayer( source, -1309.7486572266,-194.2532043457,13.558059692383, nil, getElementData( source, "skin" ), 0, dim, nil )
		local x,y,z = getElementPosition( source )
		local veh = createVehicle( vehs[math.random(#vehs)], x, y, z ,0,0, 180, "#REKT" )
		setElementDimension( veh, dim )
		warpPedIntoVehicle( player, veh )
		setElementData( player, "stVeh", veh, false )
		setElementData( player, "canExitVehicle", false )
		drSetHandling( veh )
		setElementData( player, "score", getElementData( player, "drHiScore" ) )
		triggerClientEvent( player, "drSpawned", resourceRoot, veh )
	end
end

addEventHandler( "onPlayerWasted", root, 
function( totalAmmo, killer, killerWeapon, bodypart )
	if getElementData( source, "dimension" ) > 0 then
		local lobby = lobbys[getElementData( source, "dimension" )]
		local player = source
		if lobby["type"] == "dr" then
			setTimer(  function() drSpawn(getElementData( player, "dimension" ),player ) end, 1500, 1)
		end
	end
end)

addEventHandler( "onPlayerSendRequestToLeaveRoom", root, 
function ( )
	local dim = getElementDimension( source )
	if dim ~= 0 and lobbys[dim]["type"] == "dr" then
		local veh = getElementData( source,"stVeh" )
		if isElement( veh ) then
			destroyElement( veh )
			spawn(source)
			if lobbys[dim]["cur"] <= 0 then
				local vehs = getElementsByType( "vehicle" )
				for key,veh2 in ipairs(vehs) do
					if getElementDimension( veh2 ) == dim then
						destroyElement( veh2 )
					end
				end
			end
		end
	end
end )

addEvent( "drUpdateScore", true )
addEventHandler( "drUpdateScore", root,
function ( val )
	setElementData( source, "score", val )
	setElementData( source, "drHiScore", val )
end )

	--Drift Handling by DeMoNeK_
function drSetHandling ( v )
  	-- tutaj mozna sie bawic (nie zmieniaj masy auta)
    setVehicleHandling (v, "mass", 100000.0)
    setVehicleHandling(v, "turnMass", 300000)
    setVehicleHandling(v, "centerOfMass", { 0.0,-0.15,-0.55 } )
    setVehicleHandling(v, "percentSubmerged", 70)
    setVehicleHandling(v, "tractionMultiplier", 0.95)
    setVehicleHandling(v, "tractionLoss", 0.8)
    setVehicleHandling(v, "tractionBias", 0.48)
    setVehicleHandling(v, "numberOfGears", 5)
    setVehicleHandling(v, "maxVelocity", 180.0)
    setVehicleHandling(v, "engineAcceleration", 50.0 )
    setVehicleHandling(v, "engineInertia", -1000)
    setVehicleHandling(v, "driveType", "rwd")
    setVehicleHandling(v, "engineType", "electric")
    setVehicleHandling(v, "brakeDeceleration", 5)
    setVehicleHandling(v, "brakeBias", 0.8)
    -- nie radze zmieniac
    setVehicleHandling(v, "steeringLock",  70.0 )
    setVehicleHandling(v, "suspensionForceLevel", 0.6)
    setVehicleHandling(v, "suspensionDamping", 0.25 )
    setVehicleHandling(v, "suspensionHighSpeedDamping", 0.0)
    setVehicleHandling(v, "suspensionUpperLimit", 0.1 )
    setVehicleHandling(v, "suspensionLowerLimit", -0.1)
    setVehicleHandling(v, "suspensionFrontRearBias", 0.4 )
    setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.24)
    setVehicleHandling(v, "seatOffsetDistance", 0.0)
    setVehicleHandling(v, "collisionDamageMultiplier", 0.00)
    setVehicleHandling(v, "monetary",  10000)
    --setVehicleHandling(v, "modelFlags", 1002000)
    --setVehicleHandling(v, "handlingFlags", 1000002)
    setVehicleHandling(v, "headLight", 3)
    setVehicleHandling(v, "tailLight", 2)
    setVehicleHandling(v, "animGroup", 4)
end