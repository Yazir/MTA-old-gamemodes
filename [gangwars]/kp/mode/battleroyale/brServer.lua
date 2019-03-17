itemsDyn = {}
addEvent( "onPickupRequest", true )
addEventHandler( "onPickupRequest", root, 
function( col )
	if isElement(col) and isPedDead( source )==false then 
		local playerInventory = getElementData(source,"inventory")
		if playerInventory == false then setElementData( source, "inventory", {}) playerInventory = {} end
		local itemid = getElementData( col, "iid")
		if getElementData( source, "slots") + itemTable[itemid]["weight"] <= getElementData( source, "maxSlots") then
			setElementData( source, "slots", getElementData( source, "slots" ) + itemTable[itemid]["weight"])
			playerInventory[#playerInventory+1] = itemid
			setElementData( source, "inventory", playerInventory )
			--setElementData( root, "items", itemsDyn )
			destroyElement( col )
		else
			outputChatBox( "Not enough space in inventory!", source, 255, 50, 50 )
		end
	end
end )

function removePlayerItem(player, iid, item)
	local playerInventory = getElementData(player,"inventory")
	setElementData( source, "slots", getElementData( source, "slots" ) - itemTable[iid]["weight"])
	table.remove(playerInventory,item)
	setElementData( player, "inventory", playerInventory )
end

--[[addEventHandler( "onPlayerWasted", root, 
function( totalAmmo, killer, killerWeapon, bodypart )
	local dim = getElementDimension(source)
	if lobbys[dim] and lobbys[getElementDimension(source)]["type"] == "br" and killer and getElementDimension( source ) ~= 0 and killer ~= source and getElementType(killer) == "player" and killerWeapon ~= 0 then
		--addStat(source,"deaths",1)
		if killer and getElementType( killer ) == "player" then
			--addStat(killer,"kills",1)
			--addStat2(killer,"wstats",killerWeapon,1)
		end
	end
end )]]

addEvent( "onPlayerHelmetDestroy" )
addEvent( "onInventoryAction", true )
addEventHandler( "onInventoryAction", root, 
function( action, item )
	local pla = client
	local playerInventory = getElementData(pla,"inventory")
	if playerInventory == false then setElementData( pla, "inventory", {}) playerInventory = {} end
	if action == "drop" then
		if playerInventory[item] then
			local x,y,z = getElementPosition( pla )
			local iid = playerInventory[item]
			setElementData( pla, "slots", getElementData( pla, "slots" ) - itemTable[iid]["weight"])
			createItemGround(x,y,z-0.7,iid,getElementDimension( pla ))
			table.remove(playerInventory,item)
			setElementData( pla, "inventory", playerInventory )
		end
	elseif action == "use" then
		if playerInventory[item] then
			local itemdata = itemTable[playerInventory[item]]
			if itemdata then
				local iid = playerInventory[item]
				if itemdata["usage"] == "equip" then
					giveWeapon( pla, itemdata["wid"], itemdata["ammo"], false) -- change this to false to make the bug happen less often
					removePlayerItem(pla, iid, item)
				elseif itemdata["usage"] == "heal" then
					setPedAnimation( pla, "food", "eat_burger", 2000, true, true, true, false )
					setTimer( 
					function ( )
						if isElement( pla ) and isPedDead( pla ) then killTimer( sourceTimer ) return end
						setElementHealth( pla, getElementHealth( pla ) + itemdata["hp"]/itemdata["time"] )
					end, 1000, itemdata["time"] )
					removePlayerItem(pla, iid, item)
				elseif itemdata["usage"] == "kevlar" then
					setPedArmor( pla, getPedArmor( pla ) + itemdata["kevlarAmm"] )
					removePlayerItem(pla, iid, item)
				elseif itemdata["usage"] == "helmet" then
					setElementData( pla, "helmet", itemdata["hits"] )
					removePlayerItem(pla, iid, item)
					local x,y,z = getElementPosition( pla )
					local helm = createObject( 2053, x,y,z )
					setElementCollisionsEnabled( helm, false )
					setElementDimension( helm, getElementDimension( pla ) )
					setObjectScale( helm, 0.85 )
					setElementDoubleSided( helm, true )
					attachElementToBone(helm, pla, 1, 0.02,0.05,0.15,0,0,180)
					triggerEvent( "onPlayerHelmetDestroy", pla )
					addEventHandler( "onPlayerSpawn", pla, function() if isElement( helm ) then destroyElement( helm ) end end )
					addEventHandler( "onPlayerHelmetDestroy", pla, function() if isElement( helm ) then destroyElement( helm ) end end )
				elseif itemdata["usage"] == "ammoSignal" then
					removePlayerItem( pla, iid, item )
					setElementData( pla, "ammoSignal", getElementData( pla, "ammoSignal" ) + itemdata["ammoCount"] )
					outputChatBox( "Signal ammo: "..getElementData( pla, "ammoSignal" ), pla )
				end
			end
		end
	end
end )

function createItemGround( x,y,z,iid, dim )
	local obj = createObject( itemTable[iid]["model"], x, y, z+0.2)
	local col = createColSphere( x, y, z, 3 )
	--local blip = createBlip( x, y, z )
	--setElementDimension( blip, dim )
	attachElements( col, obj )
	addEventHandler("onElementDestroy", col, function() destroyElement( obj )  end)
	setElementDimension( obj, dim )
	setElementDimension( col, dim )

	setElementData( col, "loot", true )
	setElementData( col, "iid", iid)

	setElementCollisionsEnabled( obj, false )

end


addEventHandler( "onPlayerJoinLobby", root,
function ( dim )
	local lobby = lobbys[dim]
	if lobby["type"] == "br" then
		if lobby["cur"] >= lobby["min"] and lobby["status"] == "waiting" then
			lobby["status"] = "starting"
			lobby["joinable"] = true

			for key3, playera in ipairs(getElementsByType("player")) do if getElementDimension( playera ) == 0 then triggerClientEvent( playera, "notif", resourceRoot, lobby["name"] .. " starts in ".. lobby["timeToStart"] .." seconds!", "info") outputChatBox(lobby["name"] .. " starts in ".. lobby["timeToStart"] .. " seconds!",playera,200,150,50) end end
			setTimer( 
			function()
				if lobby["cur"] <= 1 and lobby["min"] ~= 1 then
					lobby["status"] = "waiting"
					for key3, playera in ipairs(getElementsByType("player")) do if getElementDimension( playera ) == 0 then triggerClientEvent( playera, "notif", resourceRoot, lobby["name"] .. " did not start, because there was not enough players.", "error") outputChatBox(lobby["name"] .. " did not start!",playera,200,150,50) end end
					return false
				end
				if isTimer(lobby["timer"]) then killTimer( lobby["timer"] ) end
				if isTimer(lobby["timer2"]) then killTimer( lobby["timer2"] ) end
				lobby["timer"] = setTimer( 
				function() 
				randx,randy = math.random(-1200,1000), math.random(-450,450)
				--lobby["area"] = createRadarArea( 1735+randx,-1553+randy, 300, 300,50, 255, 50, 190, root )
				--local ax,ay = getElementPosition( lobby["area"] )
				lobby["areapos"] = {}
				--setElementData( lobby["area"], "size", 300)
				--lobby["areapos"][1], lobby["areapos"][2] = ax+300/2,ay+300/2
				lobby["areapos"][1], lobby["areapos"][2] = 1735+randx,-1553+randy
				--setElementDimension( lobby["area"], dim)

				local zoneBlip = createBlip( lobby["areapos"][1], lobby["areapos"][2], 0, 47, 1, nil, nil, nil, nil, nil, nil, nil)
				setElementDimension( zoneBlip, dim )

				triggerClientEvent(lobby["players"], "onGreenZoneActivated", resourceRoot)
				for key3, playera in ipairs(lobby["players"]) do triggerClientEvent( playera, "notif",resourceRoot, "Green zone is now active! Check your map.", "warning") outputChatBox( "Green zone is now active! Check your map.",playera,50,255,50 ) end
				
				local furthestPlayer = nil
				local furthestDist = 0
				for i,v in ipairs( lobby["players"] ) do
					local x,y,z = getElementPosition( v )
					local dist = getDistanceBetweenPoints2D( x,y, lobbys[dim]["areapos"][1], lobbys[dim]["areapos"][2] )
					if dist > furthestDist then
						furthestDist = dist
					end
				end
				triggerClientEvent(lobby["players"], "onClientCreateGas", root, lobbys[dim]["areapos"][1], lobbys[dim]["areapos"][2], 0, furthestDist+600, 30, 4 )
				--[[
				lobby["timer2"] = setTimer(
				function()
					if isElement( lobby["markerParent"] ) then destroyElement( lobby["markerParent"] ) end
					
					if isElement(lobby["markerParent"]) then destroyElement( lobby["markerParent"] ) end 
					lobby["markerParent"] = createElement( "markerparent" )
					setElementDimension( lobby["markerParent"], dim)
					if 3 < 3000*lobby["deadzone"] then
						for i=1,16 do
							local blip = createBlip( math.cos(360/16*(i-1)) * 3000*lobby["deadzone"] + lobby["areapos"][1], math.sin(360/16*(i-1)) * 3000*lobby["deadzone"] + lobby["areapos"][2], 0, 56, 2+lobby["deadzone"]*2, 255, 0, 0, 200, 0, 300 )
							setElementDimension( lobby["markerParent"], dim)
							setElementParent( blip, lobby["markerParent"] )
						end
					end
					for key, player in ipairs(lobby["players"]) do
						local x,y,z = getElementPosition( player )
						if getDistanceBetweenPoints2D( x, y, lobby["areapos"][1], lobby["areapos"][2] ) > 3000*lobby["deadzone"] then
							setElementHealth( player, getElementHealth( player ) - 3 ) --3
							playSoundFrontEnd( player, 49 )
						end
					end
					if 50 <= 3000*lobby["deadzone"] then
						lobby["deadzone"] = lobby["deadzone"] * 0.991 - 0.0003
					elseif 15 <= 3000*lobby["deadzone"] then
						lobby["deadzone"] = lobby["deadzone"] - 0.0002
					elseif 0 <= 3000*lobby["deadzone"] then
						lobby["deadzone"] = lobby["deadzone"] - 0.0001
					end
				end, 1000, 0) -- 1000 ]]
			end , 1000*lobby["timeToStartGZ"], 1 ) -- green zone

				local items = getElementsByType( "loot")
				for i=1,lobby["items"] do 
					local item = items[math.random(1,#items)]
					local x,y,z = getElementPosition( item )
					x,y = x+math.random(-50,50)/100, y+math.random(-50,50)/100
					createItemGround(x,y,z,math.random(1,#itemTable),dim)
				end

				local vehicles = getElementsByType( "vehiclebr" )
				local alreadySpawned = {}
				for i=1,lobby["vehicles"] do
					local vehicle = vehicles[math.random(1,#vehicles)]
					local loopI = 1
					while alreadySpawned[vehicle] or loopI > 100 do
						vehicle = vehicles[math.random(1,#vehicles)]
						loopI = loopI+1
					end
					alreadySpawned[#alreadySpawned+1] = vehicle
					local x,y,z = getElementPosition( vehicle )
					local veh = createVehicle( vehicleIDS[math.random(1,#vehicleIDS)], x+math.random(-1,1), y+math.random(-1,1), z+1.3, 0, 0, math.random(360) )
					setElementDimension( veh, dim )
					i = i+1
				end
				local x,y = 1735,-1553
				
				for key3, playera in ipairs(getElementsByType("player")) do if getElementDimension( playera ) == 0 then triggerClientEvent( playera, "notif",resourceRoot, lobby["name"] .. " has started.", "info") outputChatBox(lobby["name"] .. " has started.",playera,200,150,50) end end
				lobby["status"] = "started"
				lobby["joinable"] = false
				local spawnX, spawnY = math.random(-700,700)+x, math.random(-500,500)+y
				for key,player in ipairs(lobby["players"]) do
					local savx,savy,savz = getElementPosition( player )
					setAccountData( getPlayerAccount( player ), "savedPos", toJSON( {savx,savy,savz} ) )
					saveWeapons( player )
					local skin = getElementData( player, "skin" )
					--addStat(player,"played",1)
					setElementData( player, "headshotMulti", 4 )
					setElementData( player, "blockNametag", true )
					setElementData( player, "score", -1 )
					setElementData( player, "slots", 0 )
					setElementData( player, "maxSlots", 35 )
					setElementData( player, "inventory", {})
					setElementPosition( player, 9999, 9999, 0 )
					spawnPlayer( player, -1500*key,-1500*key,1500*key, nil, skin, nil, dim)
					setElementDimension( player, dim )
					setElementData( player, "canFire", true )
					giveWeapon( player, 46, 1, true)
					setElementDimension( player, dim )
					setElementPosition( player, spawnX+math.cos( math.rad( key * 360/#lobby["players"] ) )*3, spawnY+math.sin( math.rad( key * 360/#lobby["players"] ) )*3 , 800, true )
					setElementFrozen( player, true )
					setTimer( 
					function (  )
						triggerEvent( "onSafezoneLeave", player )
						setElementFrozen( player, false )
						setElementVelocity( player, math.random(-8,8), math.random(-8,8), math.random(50,55) )
					end, 1000, 1 )
				end
				triggerClientEvent( lobby["players"], "brOnReceiveGasTime", resourceRoot, lobby["timeToStartGZ"] )
				lobby["initPlaCount"] = #lobby["players"]
				lobby["rewardMoney"] = 20 + #lobby["players"]*13
				lobby["rewardXP"] = #lobby["players"]*8
				lobby["timestamp"] = getRealTime()["timestamp"]
			end, 1000*lobby["timeToStart"], 1 ) -- match start
		end
	end
end )

function brOnPlayerLeave()
	local dim = getElementData( source, "dimension" )
	local lobby = lobbys[dim]
	if lobby and lobby["type"] == "br" and lobby["status"] == "started" then
		setElementData( source, "dimension", 0 )

		local player = source
		local playerInv = getElementData( player, "inventory" )
		local x,y,z = getElementPosition( player, dim )
		for key,item in pairs(playerInv) do
			createItemGround(x+math.random(-100,100)/50,y+math.random(-100,100)/50,z,item,dim)
		end
		if isPedDead( player ) then
			brGiveReward( player, dim )
		end
		for key3, playera in ipairs(lobby["players"]) do outputChatBox( getPlayerName(player) .." is out, ".. lobby["cur"] .." left.",playera,50,255,50 ) end
		--[[
		setTimer(
		function()
			if isElement( player ) then
				--spawn( player )
				spawnPlayer( player, x, y, z + 20, 0, 0, 0, dim )
				setElementData( player, "roomname", "Spectator" )
				setElementData( player, "dimension", 0 )
				setElementData( player, "canExitVehicle", false )
				setElementData( player, "canFire", false )
				setTimer( 
				function (  )
					local veh = createVehicle( 501, x, y, z + 20 )
					warpPedIntoVehicle( player, veh )
					triggerClientEvent( root, "setHeliBladeCollisionsEnabled", veh, false )
					setElementVelocity( veh, math.random(-1,1), math.random(-1,1), math.random(0.8,1.2) )
					setPlayerBlipped( player )
					addEventHandler( "onVehicleExplode", veh,
					function (  )
						setTimer(
						function (  )
							spawn( player )
						end, 5000, 1)
					end )
				end, 500, 1 )
			end
		end,1500,1)]]

		setTimer( function (  )
			if isElement( player ) then
				spawn( player )
			end
		end, 5000, 1 )

		setTimer( 
		function()
			if lobby["cur"] <= 1 and lobby["status"] == "started" then
				lobby["deadzone"] = 1
				lobby["status"] = "waiting"
				lobby["joinable"] = true
				if isTimer(lobby["timer"]) then killTimer( lobby["timer"] ) end
				if isTimer(lobby["timer2"]) then killTimer( lobby["timer2"] ) end

				local elements = {getElementsByType( "colshape" ), getElementsByType( "vehicle" ), getElementsByType( "radararea" ), getElementsByType( "blip" ), getElementsByType( "marker" )}
				for key1,group in ipairs(elements) do
					for key,element in ipairs(group) do
						if getElementDimension( element ) == dim then
							destroyElement( element )
							--outputChatBox(key)
						end
					end
				end
				
				if lobby["cur"] == 1 then
					outputChatBox(lobby["name"] .. " has been won by " .. getPlayerName(lobby["players"][1]),root,200,200,50)
					for key3, playera in ipairs(getElementsByType("player")) do if getElementDimension( playera ) == 0 or getElementDimension( playera ) == dim then triggerClientEvent( playera, "notif", resourceRoot, lobby["name"] .. " has been won by " .. getPlayerName(lobby["players"][1]), "info") end end
					--addStat(lobby["players"][1],"won",1)
					--spawn(lobby["players"][1])
					brGiveReward( lobby["players"][1], dim)
				else
					outputChatBox(lobby["name"] .. " ended in a draw!",root,200,200,50)
					for key3, playera in ipairs(getElementsByType("player")) do if getElementDimension( playera ) == 0 then triggerClientEvent( playera, "notif", resourceRoot, lobby["name"] .. " ended in a draw!", "info") end end
				end
				for k,v in ipairs(getElementsByType("player")) do
					if getElementDimension( v ) == dim then
						spawn( v )
						if isPedInVehicle( v ) then destroyElement( getPedOccupiedVehicle( v ) ) end
					end
				end
				setElementData( root, "rooms", lobbys )
			end
			
		end, 5000, 1) 
	end
end
addEventHandler( "onPlayerWasted", root, brOnPlayerLeave)
addEventHandler( "onPlayerLeaveLobby", root, brOnPlayerLeave)
addEventHandler( "onPlayerQuit", root, brOnPlayerLeave )

addEventHandler( "onPlayerJoinLobby", root,
function ( dim )
	if lobbys[dim]["type"] == "br" then
		setElementData( source, "score", 0 )
		outputChatBox("Battle Royale gamemode needs at least " .. lobbys[dim]["min"] .. " people to start.",source,240,170,120)
	end
end )

function brGiveReward( pla, dim )
	local lobby = lobbys[dim]
	if lobby then
		local percent = math.min( (getRealTime()["timestamp"]-lobby["timestamp"])/(60*2), 1 )
		local rewMoney = math.floor( lobby["rewardMoney"] * ( ( 1-(lobby["cur"] ) / lobby["initPlaCount"] ) ) * percent )
		local rewXP =  math.floor( lobby["rewardXP"] * ( ( 1-(lobby["cur"] ) / lobby["initPlaCount"] ) ) * percent )
		addMoney( pla, rewMoney )
		addExp( pla, rewXP )
		outputChatBox( "You have earned ".. rewMoney .."$ and ".. rewXP .."XP!", pla, 64, 255, 0 )
	end
end

addEventHandler( "onPlayerDamage", root, 
function ( attacker, weapon, bodypart, loss )
	if attacker and getElementType( attacker ) == "player" then
		local dim = getElementDimension( attacker )
		if lobbys[dim] and lobbys[dim]["type"] == "br" then
			if getElementData( attacker, "ammoSignal" ) > 0 then
				setElementData( attacker, "ammoSignal", getElementData( attacker, "ammoSignal" )-1 )
				brSetPlayerSignalled( source, 25 )
			end
		end
	end
end )

function brSetPlayerSignalled( pla, dur )
	setTimer(
	function (  )
		if isElement( pla ) and getElementDimension( pla ) ~= 0 then
			local x,y,z = getElementPosition( pla )
			local signalBlip = createBlip( x+math.random(-20,20),y+math.random(-20,20),z, 0, 1, 255, 0, 0, math.random(255), 0, 250 )
			setElementDimension( signalBlip, getElementDimension( pla ) )
			setTimer( function (  ) if isElement( signalBlip ) then destroyElement( signalBlip ) end end, 2500, 1 )
		end
	end, 1000, dur )
end