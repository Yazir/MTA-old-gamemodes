function savePlayer( pla )
	if not isElement(pla) then pla = source end
	if isPedDead( pla ) then return end
	local acc = getPlayerAccount( pla )
	if acc and getElementData(pla,"login") then
		local dim = getElementDimension( pla )
		--local stats = { ["kills"] = 0, ["deaths"] = 0, ["played"] = 0, ["won"] = 0, ["wstats"] = {},} for key,wep in pairs(widToName) do stats["wstats"][key] = 0 end setElementData( pla, "stats", stats )
		setAccountData( acc, "money", getPlayerMoney( pla ) )
		--outputConsole( "Save: "..getPlayerName( pla ).. toJSON(getElementData( pla, "stats")) )
		setAccountData( acc, "skin", getElementData( pla, "skin" ) )
		setAccountData( acc, "exp", math.floor( getElementData( pla, "exp" ) ) )
		setAccountData( acc, "lvl", getElementData( pla, "lvl" ) )
		setAccountData( acc, "globalInv", toJSON( getElementData( pla, "globalInv" ) ) )
		setAccountData( acc, "drHiScore", getElementData( pla, "drHiScore" ) )
		setAccountData( acc, "gang", getElementData( pla, "gang" ) )
		setAccountData( acc, "wanted", getElementData( pla, "wanted" ) )
		setAccountData( acc, "kpStats", toJSON( getElementData( pla, "kpStats" ) ) )
		if dim == 0 then
			local x,y,z = getElementPosition( pla )
			setAccountData( acc, "savedPos", toJSON( {x,y,z} ) )
			saveWeapons( pla )
		end
	end
end
addEventHandler( "onPlayerQuit", root, savePlayer)

function loadPlayer( pla )
	local acc = getPlayerAccount( pla )
	if acc then
		initPlayer( pla )
		loadWeapons( pla )

		setPlayerMoney( pla, getAccountData( acc, "money" ) )
		setElementData( pla, "skin", getAccountData( acc, "skin" ) )
		setElementData( pla, "lvl", getAccountData( acc, "lvl" ) )
		setElementData( pla, "exp", getAccountData( acc, "exp" ) )
		setElementData( pla, "drHiScore", getAccountData( acc, "drHiScore" ) )
		setElementData( pla, "globalInv", fromJSON( getAccountData( acc, "globalInv" ) ) )
		setElementData( pla, "gang", getAccountData( acc, "gang" ) )
		setElementData( pla, "wanted", getAccountData( acc, "wanted" ) )
		setElementData( pla, "kpStats", fromJSON( getAccountData( acc, "kpStats" ) ) )

		if getAccountData( acc, "gang" ) then
			gangJoinPlayer( pla, getAccountData( acc, "gang" ) )
			showCursor( source, false )
		else
			gangJoinPlayer( pla, "civilian" )
			showCursor( source, false )
			--triggerClientEvent( source, "gangClientShowJoin", source )
		end
		
		local inv = getElementData( pla, "globalInv" )
		--inv["skinEarlyplayer"] = 1
		inv["default"] = 1
		setElementData( pla, "globalInv", inv )

		clanPlayerInit( pla )
		--checkStats( pla )
	end
end

function initPlayer( pla )
	local acc = getPlayerAccount( pla )
	if not getAccountData( acc, "money" ) then setAccountData( acc, "money", 20 ) end
	--if not getAccountData( acc, "stats" ) then local stats = { ["kills"] = 0, ["deaths"] = 0, ["played"] = 0, ["won"] = 0, ["wstats"] = {},} for key,wep in pairs(widToName) do stats["wstats"][key] = 0 end setAccountData( acc, "stats", stats ) end
	--local stats = { ["kills"] = 0, ["deaths"] = 0, ["played"] = 0, ["won"] = 0, ["wstats"] = {},} for key,wep in pairs(widToName) do stats["wstats"][key] = 0 end setAccountData( acc, "stats", toJSON(stats) )
	if not getAccountData( acc, "skin" ) then setAccountData( acc, "skin", 73 ) end
	if not getAccountData( acc, "lvl" ) then setAccountData( acc, "lvl", 1 ) end
	if not getAccountData( acc, "exp" ) then setAccountData( acc, "exp", 0 ) end
	if not getAccountData( acc, "clan" ) then setAccountData( acc, "clan", false ) end
	if not getAccountData( acc, "drHiScore" ) then setAccountData( acc, "drHiScore", 0 ) end
	if not getAccountData( acc, "kpStats" ) then setAccountData( acc, "kpStats", toJSON({}) ) end
	if type(getAccountData( acc, "globalInv" )) ~= "string" then setAccountData( acc, "globalInv", toJSON({}) ) end
end

function saveAllPlayers( )
	local players = getElementsByType( "player" )
	for key,player in ipairs(players) do
		savePlayer(player)
	end
end
addEventHandler( "onResourceStop", resourceRoot, saveAllPlayers)
setTimer( saveAllPlayers, 1000*60*5, 0)

--[[local statsNames = {
{"kills",	0 },
{"deaths",	0 },
{"played",	0 },
{"won", 	0 },
{"wstats",	{}}
}

function checkStats( pla )
	if getElementType(source) == "player" then pla = source end 
	local acc = getPlayerAccount( pla )
	if acc and not isGuestAccount( acc ) then 
		local stats  = {}
		if getAccountData(acc, "stats") ~= false then local Astats = fromJSON(getAccountData(acc, "stats")) end
		local Estats = getElementData( pla, "stats" )
		--outputConsole( getAccountData(acc, "stats") )
		if Astats ~= nil then
			if Estats ~= nil then
				if Astats ~= Estats then
					stats = Estats
				else
					stats = Estats
				end 
				if type(Astats) == "string" then
					stats =  Astats
				end
			end

			if type(Astats) == "string" then
				stats =  Astats 
			end
		else
			stats = { ["kills"] = 0, ["deaths"] = 0, ["played"] = 0, ["won"] = 0, ["wstats"] = {},} for key,wep in pairs(widToName) do stats["wstats"][key] = 0 end
		end
		if stats == nil then stats = {} end
		for i, sName in ipairs(statsNames) do
			if stats[sName[1] ] == nil then
				stats[sName[1] ] = sName[2]
			end 
		end 
		setElementData( pla, "stats", stats)
		setAccountData( acc, "stats", toJSON(stats) )
		--savePlayer(pla)
	end
end
addEventHandler( "onPlayerLogin", root, checkStats )]]

function saveWeapons( pla, ignoreDim )
	local dim = getElementDimension( pla )
	local acc = getPlayerAccount( pla )
	if dim==0 or ignoreDim then
		--outputDebugString( getPlayerName( pla ).." weapons saved.")
		local wpns = {}
		for i=1,13 do
			wpns[i] = {getPedWeapon( pla, i-1 ),getPedTotalAmmo( pla, i-1 )}
			--outputChatBox( tostring( getPedTotalAmmo( pla, i ) ) )
		end
		--setElementData( pla, "wpns", wpns, false )
		setAccountData( acc, "wpns", toJSON( wpns ) )
	end
end
addEventHandler( "onPlayerWasted", root, function (  ) saveWeapons( source ) end )
--addEventHandler( "onPlayerQuit", root, function (  ) saveWeapons( source ) end )

function loadWeapons( pla, ignoreDim )
	local dim = getElementDimension( pla )
	local acc = getPlayerAccount( pla )
	if dim==0 or ignoreDim then
		if getAccountData( acc, "wpns" ) then
			takeAllWeapons( pla )
			local wpns = fromJSON( getAccountData( acc, "wpns" ) )
			for i,v in ipairs( wpns ) do
				giveWeapon( pla, v[1], v[2] )
			end
			if wpns[1][1] == 1 then giveWeapon( pla, 1, 1 ) end
		end
	end
end