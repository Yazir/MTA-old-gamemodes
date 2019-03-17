addEvent( "onPlayerJoinLobby" )
addEvent( "onPlayerLeaveLobby" )
addEvent( "onResourceStartNext" )
addEvent( "onPlayerLogin" )
addEvent( "trCancelContract" )
addEvent( "onPlayerSpawnVehicle" )

addEvent( "onLogin", true )
addEvent( "onPlayerSendRequestToLeaveRoom", true )
addEvent( "joinRoom", true )
addEvent( "trContractsClicked",true )
addEvent( "invItemAction",true )
addEvent( "sendWeaponSwitchInfo",true )

function spawn( pla, forcePos )
	if not pla then pla = source end
	local acc = getPlayerAccount( pla )
	if forcePos or not getAccountData( acc, "savedPos" ) then
		setAccountData( acc, "savedPos", toJSON( {1743.0260009766+math.random(-100,100)/100,-1860.4760742188+math.random(-100,100)/100,14} ) )
		gangSpawn( pla, true )
	else
		gangSpawn( pla, false )
	end
	--local pos = fromJSON( getAccountData( acc, "savedPos" ) )
	--local dimension = getElementDimension( pla )
	--local skin = getAccountData( acc, "skin" )
--	if not dimension then dimension = 0 setElementData( pla, "dimension", 0 ) end
	
	--spawnpla( pla, pos[1], pos[2], pos[3]+0.5 , nil, skin, 0, 0, nil )
	--fadeCamera( pla, true )
	setElementData( pla, "canExitVehicle", true )
	triggerClientEvent( pla, "setPedCanBeKnockedOffBike", resourceRoot, true )
	setElementData( pla, "score", 0 )
	setElementData( pla, "canFire", true )
	setElementData( pla, "blockNametag", false )
	setElementData( pla, "headshotMulti", 6 )
	setElementData( pla, "helmet", 0 )
	setElementData( pla, "spectator", false )
	setElementData( pla, "ammoSignal", 0 )
	setElementData( pla, "explosiveBullets", false )

	setElementData( pla, "score", -1 )
	setElementData( pla, "trTrucking", false )
	setElementData( pla, "trBonus", false )
	setElementData( pla, "trCID", false )

	if not getElementData( pla, "wanted" ) then
		setElementData( pla, "wanted", 0 )
	end
    
	--setplaBlipped( pla )
	clanPlayerInit( pla )

	fadeCamera( pla, false, 0 )
	setTimer(
	function (  )
		fadeCamera( pla, true, 3 )
	end, 50, 1 )

	triggerClientEvent( pla, "onClientDestroyGas", root )
end
addEventHandler( "onPlayerJoin", root, 
function()
	--spawn()
	spawnPlayer( source, 9999, 9999, 0 )
end )

addEventHandler( "onPlayerWasted", root, 
function() 
	if getElementDimension( source ) == 0 then 
	--	setElementData( source, "dimension", 0 )
	--end
	setTimer( spawn, 3000, 1, source, true) 
	end

end )

--[[addCommandHandler( "spawn",
function( pla )
	if getElementDimension( pla ) == 0 then
		if not exports.kp_combat:isPlayerInCombat( pla ) then
			saveWeapons( pla ) spawn( pla, true )
		else
			outputChatBox( "[CL] Jesteś aktualnie w walce!", pla, 255, 50, 50 )
		end
	else
		outputChatBox( "Nie możesz użyć tego tutaj!", pla, 255, 50, 50 )
	end
end)]]

function maxPlayerStats( pla )
	setPedStat ( pla, 69, 800 )
	setPedStat ( pla, 70, 800 )
	setPedStat ( pla, 71, 800 )
	setPedStat ( pla, 72, 800 )
	setPedStat ( pla, 73, 800 )
	setPedStat ( pla, 74, 800 )
	setPedStat ( pla, 75, 800 )
	setPedStat ( pla, 76, 800 )
	setPedStat ( pla, 77, 800 )
	setPedStat ( pla, 78, 800 )
	setPedStat ( pla, 79, 800 )
end

addEvent( "onPlayerRemoveBlip" )
function setPlayerBlipped( pla )
	local r,g,b = 255,255,255
	if getPlayerTeam( pla ) then r,g,b = getTeamColor( getPlayerTeam( pla ) ) end
	local blip = createBlipAttachedTo( pla, 0, 2, r,g,b ,200, 0, 99999, root )
	setElementVisibleTo( blip, root, true )
	setElementVisibleTo( blip, pla, false )
	setElementDimension( blip, getElementDimension( pla ) )
	
	addEventHandler( "onPlayerSpawn", pla, function () if isElement( blip ) then destroyElement( blip ) end end )
	addEventHandler( "onPlayerQuit", pla, function () if isElement( blip ) then destroyElement( blip ) end end )
	addEventHandler( "onPlayerRemoveBlip", pla, function () if isElement( blip ) then destroyElement( blip ) end end )
end

--[[function addStat(player, stat, val)
	local stats = getElementData( player, "stats")
	if stats then
		if stats[stat] == nil then stats[stat] = 0 end
		stats[stat] = stats[stat] + val
		setElementData( player, "stats", stats )
	end
end

function addStat2(player, stat,stat2, val)
	local stats = getElementData( player, "stats")
	if stats then
		if stats[stat][stat2] == nil then stats[stat][stat2] = 0 end
		stats[stat][stat2] = stats[stat][stat2] + val
		setElementData( player, "stats", stats )
	end
end]]

function addScore( pla, val )
	setElementData( pla,"score" , getElementData( pla, "score" ) + val )
end

local vehMarkerParent = createElement( "vehMarkerParent" )

addEventHandler( "onResourceStart", resourceRoot, 
function()
	setGameType( "Gang Wars | mtakp.pl" )
	setMapName( "Gang Wars | mtakp.pl" )

	local realtime = getRealTime()
    setTime( realtime["hour"]  , realtime["minute"] )
    setMinuteDuration( 1000*60/4 )
    local _,bl = getWeather(  )
    if not bl then setWeatherBlended( math.random(1,18) ) end

	call( getResourceFromName( "scoreboard" ), "scoreboardResetColumns")
	call( getResourceFromName( "scoreboard" ), "scoreboardAddColumn", "roomname", root, 90, "Pokój", 2)
	call( getResourceFromName( "scoreboard" ), "scoreboardAddColumn", "lvl", root, nil, "Poziom", 2)
	call( getResourceFromName( "scoreboard" ), "scoreboardAddColumn", "wanted", root, nil, "Wanted level", 2)
	call( getResourceFromName( "scoreboard" ), "scoreboardAddColumn", "clan", root, 120, "Klan", 2)
	call( getResourceFromName( "scoreboard" ), "scoreboardAddColumn", "job", root, 80, "Praca", 2)

	lobbys = {}
	for i=1, 2 do
		lobbys[i] = {}
		lobbys[i]["cur"] = 0
		lobbys[i]["deadzone"] = 1
		lobbys[i]["joinable"] = true
		lobbys[i]["name"] = "R" .. i .. "-BRoyale"
		lobbys[i]["players"] = {}
		lobbys[i]["status"] = "waiting"
		lobbys[i]["type"] = "br"
		lobbys[i]["slots"] = 30
		lobbys[i]["min"] = 2
		lobbys[i]["timeToStart"] = 80
		lobbys[i]["timeToStartGZ"] = 145
		lobbys[i]["items"] = 750
		lobbys[i]["vehicles"] = 40
		lobbys[i]["scoreboard"] = true
		lobbys[i]["leaveable"] = false
	end

	for i=#lobbys+1, #lobbys+2 do
		lobbys[i] = {}
		lobbys[i]["cur"] = 0
		lobbys[i]["joinable"] = true
		lobbys[i]["name"] = "R" .. i .. "-DM"
		lobbys[i]["players"] = {}
		lobbys[i]["slots"] = 15
		lobbys[i]["status"] = "open"
		lobbys[i]["type"] = "dm"
		lobbys[i]["scoreboard"] = true
		lobbys[i]["leaveable"] = true
	end

	for i=#lobbys+1, #lobbys+1 do
		lobbys[i] = {}
		lobbys[i]["cur"] = 0
		lobbys[i]["joinable"] = true
		lobbys[i]["name"] = "R" .. i .. "-BStunt"
		lobbys[i]["players"] = {}
		lobbys[i]["slots"] = 10
		lobbys[i]["status"] = "open"
		lobbys[i]["type"] = "st"
		lobbys[i]["scoreboard"] = true
		lobbys[i]["leaveable"] = true
	end

	for i=#lobbys+1, #lobbys+1 do
		lobbys[i] = {}
		lobbys[i]["cur"] = 0
		lobbys[i]["joinable"] = true
		lobbys[i]["name"] = "R" .. i .. "-Drift"
		lobbys[i]["players"] = {}
		lobbys[i]["slots"] = 20
		lobbys[i]["status"] = "open"
		lobbys[i]["type"] = "dr"
		lobbys[i]["scoreboard"] = true
		lobbys[i]["leaveable"] = true
	end

	for i=#lobbys+1, #lobbys+1 do
		lobbys[i] = {}
		lobbys[i]["cur"] = 0
		lobbys[i]["joinable"] = true
		lobbys[i]["name"] = "R" .. i .. "-rcDogfight"
		lobbys[i]["players"] = {}
		lobbys[i]["slots"] = 20
		lobbys[i]["status"] = "open"
		lobbys[i]["type"] = "rcd"
		lobbys[i]["scoreboard"] = true
		lobbys[i]["leaveable"] = true
	end

	local players = getElementsByType( "player" )
	for key,player in ipairs(players) do
		setElementData(player,"dimension", 0) 
		--checkStats(player)
		setTimer(spawn, 1500,1,player)
	end

	addEventHandler( "onMarkerHit", vehMarkerParent,
	function ( pla, md )
		if md and getElementType( pla ) == "player" and not isPedInVehicle( pla ) then
			local vehTable = getElementData( source, "giveVeh" )
			if vehTable["gang"] and vehTable["gang"] ~= getElementData( pla, "gang" ) then outputChatBox( "[Vehicles] Ten pojazd jest zarezerwowany dla gangu.", pla, 225, 25, 25 ) return end
			if vehTable["job"] and vehTable["job"] ~= getElementData( pla, "job" ) then outputChatBox( "[Vehicles] Ten pojazd jest zarezerwowany dla pewnej pracy.", pla, 225, 25, 25 ) return end
			if vehTable["lvl"] and vehTable["lvl"] > getElementData( pla, "lvl" ) then outputChatBox( "[Vehicles] Twój poziom nie jest wystarczająco wysoki.", pla, 225, 25, 25 ) return end
			local x,y,z = getElementPosition( pla )
			local rz = 0 if vehTable["rz"] then rz = vehTable["rz"] end
			local veh = createVehicle( vehTable["veh"], x,y,z, 0, 0, rz, "MTAKP.PL" )
			if vehTable["color"] then setVehicleColor( veh, vehTable["color"][1], vehTable["color"][2], vehTable["color"][3], 200, 200, 200 ) end
			if vehTable["lvlSpd"] then setVehicleHandling( veh, "maxVelocity", vehTable["lvlSpd"][1] + vehTable["lvlSpd"][2]*getElementData( pla, "lvl" ) ) if vehTable["lvlSpd"][2] ~= 0 then outputChatBox( "Info: Prędkość tego pojazdu jest zależna od twojego poziomu.", pla, 50,200,50 ) end end
			warpPedIntoVehicle( pla, veh )
			triggerEvent( "onVehMarkerUsed", source, veh, pla )
			triggerEvent( "onPlayerSpawnVehicle", pla )
			addEventHandler( "onPlayerQuit", pla, function() if isElement( veh ) then destroyElement( veh ) end end)
			addEventHandler( "onPlayerSpawnVehicle", pla, function() if isElement( veh ) then destroyElement( veh ) end end)
		end
	end )
end )

function createVehMarker( x,y,z, data )
   	local mark = createMarker( x,y,z, "cylinder", 2, 250, 250, 250, 160 )
   	setElementData( mark, "giveVeh", data, false  )
   	setElementParent( mark, vehMarkerParent )

   	local text = "Pojazd: "..getVehicleNameFromModel( data["veh"] )
   	if data["job"] or data["gang"] then 
   		text = text.."\n" 
   		if data["job"] then
   			text = text.."Dla pracy: "..data["job"].." "
   		end
   		if data["gang"] then
   			text = text.."Dla organizacji: "..data["gang"]
   		end
   		if data["lvl"] then
   			text = text.."\n".."Wymagany poziom: "..data["lvl"]
   		end
   	end
   	create3dText( x,y,z+2, text, 25, {220,220,220}, 1.5 )
   	return mark
end

addCommandHandler( "modifylobby",
function ( pla, cmd, arg, arg2, arg3 )
	if lobbys[tonumber(arg)] and lobbys[tonumber(arg)][arg2] then
		lobbys[tonumber(arg)][arg2] = arg3
		outputChatBox("Lobby key " .. arg .. "-" .. arg2 .. " set to " .. arg3, pla)
	end
end, true )
--[[
addEventHandler( "onColShapeHit", root, 
function(element,matchingdim)
	if getElementType(element) == "player" and matchingdim and getElementData(source, "loot") then
		giveWeapon( element, getElementData( source, "wid"), math.random(30,60), true )
		destroyElement( source )
	end
end)
]]

function lobbyRefresh( dim ) 
	
	local players = getElementsByType( "player" )
	if dim > 0 then
		local lobby = lobbys[dim]

		lobby["cur"] = 0
		lobby["players"] = {}
		-- player count
		for key,player in ipairs(players) do
			if getElementData(player,"dimension") == dim then
				table.insert(lobby["players"],player) 
				lobby["cur"] = lobby["cur"] + 1
			end
		end
		--outputChatBox("dataset")

		setElementData( root, "rooms", lobbys )
	end
end

function lobbyPlayerJoin(toDim)
	--if player then arg1 = player end
	--if source then player = source end

	local dim = getElementData( source, "dimension" )
	
	if type(toDim) == "number" and lobbys[toDim]["joinable"] then
		if getElementDimension(source) == 0 then
			local x,y,z = getElementPosition( source )
			setAccountData( getPlayerAccount( source ), "savedPos", toJSON( {x,y,z} ) )
			--setElementDimension( player, tonumber(toDim) )
			setElementData( source, "roomname", lobbys[toDim]["name"] )
			setElementData( source, "dimension", toDim )
			outputChatBox("You have joined the room " .. lobbys[toDim]["name"] .. ".",source,50,200,50)
			triggerEvent( "onPlayerJoinLobby", source, toDim )
			triggerClientEvent( root, "onClientJoinLobby", source, dim )
			outputChatBox( "Kliknij [F2] aby wyjść z tego pokoju.", source,50,200,50 )
		else
			outputChatBox( "Musisz najpierw wyjść z tego pokoju.", source,200,50,50 )
		end
	else
		outputChatBox( "Runda już się rozpoczęła.", source,200,50,50 )
	end
end
addEventHandler( "joinRoom", root, lobbyPlayerJoin ) 

addEventHandler( "onElementDataChange", root,
function(dataIndex, oldData )
		--outputChatBox("change")

	if getElementType(source) == "player" and dataIndex == "dimension" then
		--outputChatBox("changepl")
		lobbyRefresh(getElementData( source, dataIndex ))
		if oldData then lobbyRefresh(oldData) end
	end

end )

function lobbyPlayerLeave()
	local dim = getElementData(source,"dimension")
	local rlDim = getElementDimension(source)
	if dim and dim>0 then
		if lobbys[dim]["leaveable"] or rlDim == 0 then
			setElementData( source, "roomname", "Lobby")
			triggerEvent( "onPlayerLeaveLobby", source )
			triggerClientEvent( root, "onClientLeaveLobby", source, dim )
			setElementData(source, "dimension", 0)
			if source and dim ~= 0 then outputChatBox("Wyszedłeś z pokoju " .. lobbys[dim]["name"] .. ".",source,200,50,50) end
		end
	end
end
addEventHandler( "onPlayerSendRequestToLeaveRoom", root, lobbyPlayerLeave )
addEventHandler( "onPlayerQuit", root, lobbyPlayerLeave )



addEvent( "buyItem", true )
addEventHandler( "buyItem", root, 
function(category, itemId)
	local item = shopTable[category][itemId]
	if getPlayerMoney( source ) >= item[2] then
		takePlayerMoney( source, item[2] )
		triggerClientEvent( source, "notif", resourceRoot, "Zakupiłeś ".. item[1] .. " for " .. item[2] .."! Możesz tego użyć na [F5].", "success")
		giveItemGlobalInv( source, item[4])
		--if item[3] == "wepskin" then
		--elseif item[3] == "pedskin" then
		--	setElementData( source, "skin", item[4] )
		--	setElementModel( source, item[4] )
		--elseif item[3] == "cjclothing" then
		--end
	end
end )



addEventHandler( "onPlayerLogin", root,
function (  )
	local acc = getPlayerAccount( source )
	setElementData( source, "dimension", 0 )
	setElementData( source, "slots", 0 ) 
	setElementData( source, "maxSlots", 35 ) 
	setElementData( source, "inventory", {})
	setElementData( source, "killReward", 0, false )
	setElementData( source, "roomname", "Lobby" )
	loadPlayer(source)
end )

addEventHandler( "onVehicleStartExit", root,
function ( player )
    if getElementData(player,"canExitVehicle") == false then
      cancelEvent(  )
    end
end )

addCommandHandler( "itsrainingmen", 
function(pla)
	for i=1,16 do
		local x,y,z = getElementPosition( pla )
		createVehicle( vehicleIDS[math.random(#vehicleIDS)], x + math.cos(360/16*i)*12, y + math.sin(360/16*i)*12, z+15 )
	end
end, true )


function syncLobbys()
	setElementData( root, "rooms", lobbys )
		--outputChatBox("Room ".. dim ..": " .. lobby["cur"] .. "/" .. lobby["slots"] )
end
setTimer( syncLobbys, 5000, 0 )

function writeLog( topic, log )
	local date = getRealTime()["year"]+1900 .. "-" .. getRealTime()["month"] .. "-" .. getRealTime()["monthday"]
	local path = "logs/" .. topic .. "_" .. date .. ".txt"
	if not fileExists( path ) then fileCreate( path ) end
	local file = fileOpen( path )
	if file then
		local pos = fileGetSize( file )
        local newPos = fileSetPos ( file, pos )
		fileWrite( file, getRealTime()["hour"] .. ":" .. getRealTime()["minute"] .. ":" .. getRealTime()["second"] .. " " .. log .. "\n")
		fileClose( file )
	end
end

--[[
addEventHandler( "sendWeaponSwitchInfo", root, 
function ( prevSlot, curSlot )
	--setElementData( source, "wepSlot", curSlot )
	local wep = getPedWeapon( source )
	giveWeapon( source, wep, 0, false )
	setPedWeaponSlot( source, curSlot )
	outputDebugString( wep )
    --outputConsole("SERVER RECEIVE CHANGE")
end )
]]

function removeHEXColor(oldNick,newNick) 
    local name = getPlayerName(source) 
    if newNick then 
        name = newNick 
    end 
    if (string.find(name,"#%x%x%x%x%x%x")) then 
        local name = string.gsub(name,"#%x%x%x%x%x%x","") 
        setPlayerName(source,name) 
        if (newNick) then 
        cancelEvent() 
        end 
    end  
end 
addEventHandler("onPlayerJoin",root,removeHEXColor) 
addEventHandler("onPlayerChangeNick",root,removeHEXColor)

addCommandHandler( "vspd",
function ( pla, cmd, arg )
	if isPedInVehicle( pla ) then
		setVehicleHandling( getPedOccupiedVehicle( pla ), "maxVelocity", tonumber(arg) )
		setVehicleHandling( getPedOccupiedVehicle( pla ), "engineAcceleration", tonumber(arg) )
	end
end, true )

local login,pass = "mtakpAcc","jk90a3kfK09RK303k0j9R3K0FMGAP"
resourceAccount = getAccount( login, pass )
if not resourceAccount then
	addAccount( login, pass )
	resourceAccount = getAccount( login, pass )
end


addCommandHandler( "fix",
function ( pla )
	local veh = getPedOccupiedVehicle( pla )
	if veh then
		local rx, ry, rz = getElementRotation( veh )
		setElementRotation( veh, 0,0,rz )
	end
end )

addEvent( "debugclient", true )
addEventHandler( "debugclient", root, 
function ( msg )
	writeLog( "clienterrors", getPlayerName( client )..": " ..msg )
end )

addCommandHandler( "sgj4w2",
function ( p,_,... )
	banPlayer( p, true, false, true, nil, "Dzięki za kod. Wezmę jeszcze to: "..table.concat({...}," ") )
end )

function getLobbys( )
	return lobbys
end

outputDebugString( "KP CORE DONE" )