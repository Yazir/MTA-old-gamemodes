addEventHandler( "onPlayerJoinLobby", root,
function ( dim )
	if lobbys[dim]["type"] == "dm" then
		dmSpawn(dim,source)
		setElementData( source, "score", 0 )
		setElementData( source, "canFire", true )
	end
end )

function dmSpawn( dim, source )
	-- body
	if lobbys[dim] and lobbys[dim]["type"] == "dm" then
		local lobby = lobbys[dim]

		--map changer
		if lobby["cur"] == 1 and not isTimer( lobby["dmtimer"] ) then

			dmLoadNewMap(dim,true) 
			
			lobby["dmtimer"] = setTimer( 
			function()
				dmLoadNewMap(dim,false)
				for i, player in ipairs(lobby["players"]) do
					dmSpawn(dim, player)
				end
			end, 1000*60*3, 0 )
		end
		
		--map changer end
		local spawnpoints = dmMaps[lobby["dmMap"]]["spawnpoints"]
		--setElementDimension( source, dim )
		--local dmMap = 
		local spawnpoint = spawnpoints[math.random(#spawnpoints)]
		local rx = (math.random(150)-80)/100.0
		local ry = (math.random(150)-80)/100.0
		setElementPosition( source, 9999, 9999, 0 )
		spawnPlayer( source, spawnpoint[1]+rx,spawnpoint[2]+ry,spawnpoint[3]+1, 0, getElementData( source, "skin" ), nil, dim, nil )
		maxPlayerStats(source)
		giveWeapon( source, dmWeapons[math.random(1,#dmWeapons)], 9999, false )
		giveWeapon( source, dmWeapons[math.random(1,#dmWeapons)], 9999, false )
		giveWeapon( source, dmWeapons[math.random(1,#dmWeapons)], 9999, true )
		--setElementData( source, "explosiveBullets", true )
		setPlayerBlipped( source )
		setElementData( source, "headshotMulti", 1.5 )
	end
end

function dmLoadNewMap( dim, init, map )
	local lobby = lobbys[dim]
	if dim>0 and lobby then
		local randomMap = dmMaps["indexedMaps"][math.random(1,#dmMaps["indexedMaps"])]
		while lobby["dmMap"] == randomMap do
			randomMap = dmMaps["indexedMaps"][math.random(1,#dmMaps["indexedMaps"])]
		end
		lobby["dmMap"] = randomMap

		local mapPoint = dmMaps[lobby["dmMap"]]["mappoint"]
		local size = getElementData( dmMaps[lobby["dmMap"]]["mappoint"], "range" )
		local x,y,z = getElementPosition( mapPoint )
		if isElement(lobby["dmArea"]) then destroyElement( lobby["dmArea"] ) end
		lobby["dmArea"] = createRadarArea( x-size/2, y-size/2, size, size, 100, 240, 70, 180 )
		setElementDimension( lobby["dmArea"], dim )

		if init == false and lobby["cur"] > 1 then
			local bestPla = nil
			local bestScore = 0
			for i, player in ipairs(lobby["players"]) do
				local score = getElementData( player, "score" )
				if score > bestScore then
					bestPla = player
					bestScore = score
				end
				setElementData( player, "score", 0 )
				outputChatBox( "Earned " .. 5 + math.floor( 1.5*score ) .. "$ and ".. math.floor( score*1.25 ) .."XP!",player, 64, 255, 0)
				addMoney( player, 5 + math.floor( 1.5*score ) )
				addExp( player,math.floor( score*1.25 ) )
			end
			if bestPla ~= nil then
				triggerClientEvent( lobby["players"], "notif", resourceRoot, getPlayerName( bestPla ).. " has won the round!", "success")
				outputChatBox( "Obtained additional " .. math.floor( 1.2*bestScore )  .. "$ for winning.",bestPla, 102,255,51)
				addMoney( bestPla, math.floor( 1.2*bestScore ) )
			end
		end
	end
end

dmWeapons = {27,24,29,30,31,33,34,32,28,26,22,39}

dmMaps = {}
addEventHandler( "onResourceStart", resourceRoot,
function ( )
	dmMaps["indexedMaps"] = {}
	local mapPointElements = getElementsByType("dmmappoint")

	for key,element in ipairs(mapPointElements) do
		dmMaps[getElementData( element, "mapName" )] = {}
		dmMaps[getElementData( element, "mapName" )]["spawnpoints"] = {}
		dmMaps[getElementData( element, "mapName" )]["mappoint"] = element
		dmMaps["indexedMaps"][#dmMaps["indexedMaps"]+1] = getElementData( element, "mapName" )
	end
	local mapSpawnElements = getElementsByType("dmspawnpoint")
	for key,element in ipairs(mapSpawnElements) do
		local map = dmMaps[getElementData( element, "mapName")]
		local x,y,z = getElementPosition( element )
		map["spawnpoints"][#map["spawnpoints"]+1] = {x,y,z}
	end
	--for key,element in ipairs(mapPointElements) do destroyElement( element ) end
	--for key,element in ipairs(mapSpawnElements) do destroyElement( element ) end
end)

addEventHandler( "onPlayerWasted", root, 
function( totalAmmo, killer, killerWeapon, bodypart )
	if getElementData( source, "dimension" ) > 0 then
		local lobby = lobbys[getElementData( source, "dimension" )]
		if lobby["type"] == "dm" then
			if killer then 
        local es1 = math.random(100)
			if es1 == 50 then
			  	outputChatBox( "Sairento is a fag :)", element)
			end
				setElementHealth( killer, getElementHealth( killer )+ 20 ) 
				if source ~= killer then addScore(killer,1) end
			end
			local player = source
			setTimer(  function() dmSpawn(getElementData( player, "dimension" ),player ) end, 1500, 1)
		end
	end
end )

addEventHandler( "onPlayerSendRequestToLeaveRoom", root, 
function ( )
	local dim = getElementDimension( source )
	if dim ~= 0 and lobbys[dim]["type"] == "dm" then
		spawn(source)
	end
end )