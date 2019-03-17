addEventHandler( "onPlayerJoinLobby", root,
function ( dim )
	stSpawn(dim,source)
	if lobbys[dim]["type"] == "st" and lobbys[dim]["cur"] == 1 then
		stSetPoint(dim)
	end
end )

function stSpawn( dim, source )
	if lobbys[dim]["type"] == "st" then
		local player = source
		local lobby = lobbys[dim]
		spawnPlayer( source, -1374.9686279297,1648.7744140625,1052.53125, nil, getElementData( source, "skin" ), 14, dim, nil )
		local x,y,z = getElementPosition( source )
		local veh = createVehicle( 468, x, y, z ,0,0, 180, "#REKT" )
		setElementDimension( veh, dim )
		setElementInterior( veh, 14 )
		warpPedIntoVehicle( player, veh )
		setElementData( player, "stVeh", veh, false )
		setElementData( player, "canExitVehicle", false )
		triggerClientEvent( player, "setPedCanBeKnockedOffBike", resourceRoot, false )
	end
end

addEventHandler( "onPlayerWasted", root, 
function( totalAmmo, killer, killerWeapon, bodypart )
	if getElementData( source, "dimension" ) > 0 then
		local lobby = lobbys[getElementData( source, "dimension" )]
		local player = source
		if lobby["type"] == "st" then
			setTimer(  function() stSpawn(getElementData( player, "dimension" ),player ) end, 1500, 1)
		end
	end
end)

addEventHandler( "onPlayerSendRequestToLeaveRoom", root, 
function ( )
	local dim = getElementDimension( source )
	if dim ~= 0 and lobbys[dim]["type"] == "st" then
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
				local markers = getElementsByType( "marker" )
				for key,marker in ipairs(markers) do
					if getElementDimension( marker ) == dim then
						destroyElement( marker )
					end
				end
			end
		end
	end
end )


local stMoneyPoints = {
	{-1404.8306884766,1645.6236572266,1070.8533935547},
	{-1484.1083984375,1595.9630126953,1060.7902832031},
	{-1372.9150390625,1562.4938964844,1059.7564697266},
	{-1355.1245117188,1604.0167236328,1055.9411621094},
	{-1354.8914794922,1603.6833496094,1057.4543457031},
	{-1389.7843017578,1620.2834472656,1056.1665039063},
	{-1407.1285400391,1568.6943359375,1055.8474121094},
	{-1408.6750488281,1589.5499267578,1057.1328125},
	{-1431.2784423828,1580.9217529297,1056.1617431641},
	{-1360.5145263672,1637.2170410156,1056.4389648438},
	{-1486.8664550781,1641.8793945313,1059.7705078125},
	{-1486.8031005859,1563.9666748047,1055.7275390625},
	{-1452.0904541016,1571.1844482422,1058.2136230469},
	{-1453.7999267578,1635.7114257813,1055.5242919922},
	{-1399.453125,1602.9604492188,1056.0373535156},
	{-1378.8210449219,1610.1766357422,1052.7961425781},
	{-1362.404296875,1613.9011230469,1053.1873779297},
	{-1360.6104736328,1634.3898925781,1055.1242675781},
}

function stSetPoint( dim )
	local moneyPoint = stMoneyPoints[math.random(#stMoneyPoints)]
	local marker = createMarker( moneyPoint[1], moneyPoint[2], moneyPoint[3] , "corona", 2.5, 50, 200, 50, 230 )
	setElementDimension( marker, dim )
	setElementInterior( marker, 14)
	local blip = createBlip(moneyPoint[1], moneyPoint[2], moneyPoint[3],0,1,50,220,50,230)
	setElementData( marker, "blip", blip, false )
	setElementDimension( blip, dim )
	setElementInterior( blip, 14)

	addEventHandler( "onMarkerHit", marker,
	function (element, matchingdim )
		if matchingdim and getElementType(element) == "player" and isPedInVehicle( element ) then 
			addMoney( element, 3 )
			stSetPoint(dim)
			destroyElement( source )
			addScore(element,3)
			addExp(element,1)
			local es1 = math.random(100)
			if es1 == 50 then
			  	outputChatBox( "Sairento is a fag :)", element)
			end
		end
	end )
	addEventHandler( "onElementDestroy", marker,
	function()
		destroyElement( getElementData(source,"blip") )
	end )
end