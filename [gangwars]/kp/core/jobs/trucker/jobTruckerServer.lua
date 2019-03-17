local jobMarker = createJobMarker( 2179.4426269531,-2263.6328125,13.8, {job="trucker", blip=42} )

local trMarker = createMarker( 2183.8078613281,-2279.7033691406,12.7 , "cylinder", 5, 50,250,50,220, root ) setElementData( trMarker, "trContractData", {} )
local trMarkers = {trMarker}

local trContracts = {
	pos = {
		{-2484.0085449219,2234.4833984375,4.84375},			
		{2368.755859375,2750.2331542969,10.8203125},		
		{2464.1235351563,-41.431079864502,26.484375},		
		{719.28442382813,-474.70492553711,16.343704223633},	
		{-2215.5524902344,-2326.7514648438,30.625},			
		{-109.6195602417,1116.5998535156,19.7421875},		
		{-2677.4233398438,-39.627151489258,4.3359375},
	},
	types = { 
		{name="Furniture", ill=false, mod=435 },
		{name="Food", ill=false, mod=435},
		{name="Alcohol", ill=false, mod=435},
		{name="Cigarettes", ill=false, mod=435},
		{name="Milk", ill=false, mod=584},
		{name="Petrol", ill=false, mod=584},
	}
}

function trCreateContract( marker )
	local data = getElementData( marker, "trContractData" )
	if table.count( data ) < 10 then
		local randType = trContracts["types"][math.random( 1, #trContracts["types"] )]
		local pos = trContracts["pos"][math.random( 1, #trContracts["pos"] )]
		local x,y,z = getElementPosition( marker )
		local dist = getDistanceBetweenPoints3D( x, y, z, pos[1], pos[2], pos[3] )
		local rewardMoney = math.floor( dist*0.025 + math.random(-20,20) )
		local rewardXP = math.floor( dist*0.004 + math.random(-5,5) )
		local cost = math.floor( dist*0.014  + math.random(-5,5) )
		local bonusMoney = math.floor( dist*0.006  + math.random(-5,5) )
		local bonusXP = math.floor( dist*0.004  + math.random(-5,5) )
		
		data[table.count( data )+1] = {
		pos = pos,
		name = randType["name"],
		illegal = randType["ill"],
		dist = math.floor( dist ),
		money = rewardMoney,
		bonusMoney = bonusMoney,
		xp = rewardXP,
		bonusXP = bonusXP,
		cost = cost,
		key = {marker, table.count( data )+1},
		model = randType["mod"]
		}

		setElementData( marker, "trContractData", data )
	end
end


function trAddMarkers(  )
	for k,v in ipairs( trMarkers ) do
		trCreateContract( v )
	end
end
setTimer( trAddMarkers, 1000*60*5, 0 )
trAddMarkers()
trAddMarkers()
trAddMarkers()
--[[
addEventHandler( "onPlayerWasted", root, 
function( totalAmmo, killer, killerWeapon, bodypart )
	if getElementData( source, "dimension" ) == 0 then
		if lobbys[getElementDimension(source)] and lobbys[getElementDimension(source)]["type"] == "tr" then
			local pla = source
			setTimer(  function() trSpawn(pla ) end, 1500, 1)
		end
	end
end )

function trSpawn( pla )
	local dim = getElementData( pla, "dimension" )
	if dim>0 and lobbys[dim]["type"] == "tr" then
		spawnPlayer( pla, 65.730411529541,-248.30088806152,1.578125, 0, getElementData( pla, "skin" ), 0, dim )
		local veh = createVehicle( 515, 65.730411529541,-248.30088806152,3, 0,0,0, "trucker" )
		setElementDimension( veh, dim )
		addEventHandler( "onPlayerLeaveLobby", pla, function() if isElement(veh) then destroyElement(veh) end end )
		addEventHandler( "onPlayerSpawn", pla, function() if isElement(veh) then destroyElement(veh)  end end )
		setTimer( function() warpPedIntoVehicle( pla, veh ) end, 200, 1 )
		setElementData( pla, "trTrucking", false )
		setElementData( source, "trBonus", false )
		setPlayerBlipped( pla )
	end
end]]

function assignTask( pla, contract)
	local rx,ry,rz = getElementRotation( getPedOccupiedVehicle( pla ) )
	local trailer = createVehicle( contract["model"], 9999,9999,-10, 0,0,rz, "trucker" )
	attachTrailerToVehicle( getPedOccupiedVehicle( pla ), trailer )

	setElementData( source, "trBonus", false )
	setElementData( pla, "trTrucking", true )

	local x,y,z = getElementPosition( pla )
	local pos = contract["pos"]
	local marker = createMarker( pos[1],pos[2],pos[3]-0.5, "cylinder", 6, 250,50,50, 200, pla )
	local blip = createBlip( pos[1],pos[2],pos[3], 41, 2, nil,nil,nil, 240, 999, nil, pla )

	--setElementData( trailer, "cID", cID )
	--setElementData( pla, "trCID", cID )
	--local moneyPayment = math.floor( getDistanceBetweenPoints2D( mx,my,mz, pos[1],pos[2],pos[3] ) /60 )
	--local xpPayment = math.floor( getDistanceBetweenPoints2D( mx,my,mz, pos[1],pos[2],pos[3] ) /250 )

	--addEventHandler( "onPlayerLeaveLobby", pla, function() trDestroyContract( marker, blip, trailer ) end )
	addEventHandler( "onPlayerSpawn", pla, function() trDestroyContract( marker, blip, trailer ) end )
	addEventHandler( "trContractsClicked", pla, function() trDestroyContract( marker, blip, trailer ) setElementData( pla, "trTrucking", false ) end )

	addEventHandler( "onMarkerHit", marker,
	function(element)
		if element == trailer then
			trDestroyContract( marker, blip, trailer )
			triggerClientEvent( pla, "notif", resourceRoot, "You have delivered the trailer! Your payment is ".. contract["money"] .."$ and ".. contract["xp"] .."XP. Drive back to the trucking spot to claim your bonus!", "success")
			outputChatBox( "Get back to the truck zone to get bonus pay!", pla, 64, 255, 0)
			addMoney( pla, contract["money"] )
			addExp( pla, contract["xp"])
			setElementData( pla, "trBonusPay", {xp=contract["bonusXP"],money=contract["bonusMoney"]} )
			setElementData( pla, "trTrucking", false )
			setElementData( pla, "trBonus", true )
			writeLog("truck", "Player: " .. getPlayerName( pla ) .. "(" .. getAccountName( getPlayerAccount( pla ) ) .. " , " .. getAccountSerial( getPlayerAccount( pla ) ) .. ")" .. " delivered for MONEY " .. contract["money"] .. " EXP " .. contract["xp"] )
		end
	end )
end

function trDestroyContract( marker, blip, trailer )
	if isElement( marker ) then destroyElement( marker ) end
	if isElement( blip ) then destroyElement( blip ) end
	if isElement( trailer ) then destroyElement( trailer ) end
end

--[[
function trGiveBonus(element,md)
	if md and element == source then
		triggerClientEvent( source, "notif", resourceRoot, "Earned bonus pay that is" .. getElementData( source, "trReward") .. "!", "success")
		addMoney( source, getElementData( source, "trReward") )
		addExp( source, 10)
		setElementData( source, "trReward", false )
		removeEventHandler( "onMarkerHit", trMarker, trGiveBonus  )
	end
end


addEventHandler( "onPlayerSendRequestToLeaveRoom", root, 
function ( )
	local dim = getElementDimension( source )
	if dim ~= 0 and lobbys[dim]["type"] == "tr" then
		spawn(source)
	end
end )]]

addEventHandler( "trContractsClicked", root,
function ( button, key )
	if getElementDimension( source ) == 0 then
		if button == "bonus" and getElementData( source, "trBonus") then
			local bonuses = getElementData( source, "trBonusPay" )
			--local contract = trContractsTable[ getElementData( source, "trCID" ) ]
			triggerClientEvent( source, "notif", resourceRoot, "Earned bonus pay that is " .. bonuses["money"] .. "$ and ".. bonuses["xp"] .."XP!", "success")
			addMoney( source, bonuses["money"] )
			addExp( source, bonuses["xp"] )
			setElementData( source, "trBonus", false )
			setElementData( source, "trCID", false )
		elseif button == "accept" then
			contract = getElementData( key[1], "trContractData" )[key[2]]
			if getElementData(source,"trTrucking") == false then
				--local dist = math.floor(getDistanceBetweenPoints2D( mx,my,contract["pos"][1],contract["pos"][2] ) )
				--local cost = math.floor(dist/300)
				local cost = contract["cost"]
				if cost <= getPlayerMoney( source ) then
					assignTask( source, contract )
					addMoney( source, -cost )
					triggerClientEvent( source, "trContractTaken", source )
					triggerClientEvent( source, "notif", resourceRoot, "You have bought the load for ".. cost .."$. Follow the location marked on the map to deliver the load.", "info")
					local data = getElementData( key[1], "trContractData" )
					data[key[2]] = nil
					setElementData( key[1], "trContractData", data )
				else
					triggerClientEvent( source, "notif", resourceRoot, "You have not enough money for that load!", "error")
				end
			end
		elseif button == "cancel" then
			triggerEvent( "trCancelContract", source )
		end
	end
end )

createVehMarker( 2157.7973632813,-2293.8354492188,12.8, {veh=403, job="trucker", rz=220} )
