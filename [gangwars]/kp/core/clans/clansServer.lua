local clanInvites = {}

addEvent( "clanRequest", true )
addEventHandler( "clanRequest", root, 
function ( reqType, arg, arg2 )
	local pla = client
	local acc = getPlayerAccount( pla )
	local accName = getAccountName( acc )
	local clan = getAccountData( acc, "clan" )
	if reqType == "create" then
		dbQuery(
		function( qh )
			local result = dbPoll( qh, 0 )
			if result and result[1] and result[1]["name"] then outputChatBox( "[Clan] Ta nazwa jest już zajęta!", pla, 250, 50, 50 ) return
			else
				if not getAccountData( acc, "clan" ) then
					clanCreate( pla, arg )
				else
					outputChatBox( "[Clan] Już posiadasz klan!", pla, 250, 50, 50 )
				end
			end
		end, dbase, "SELECT * FROM 'clans' WHERE name = '"..arg.."' LIMIT 1" )
	elseif reqType == "data" then
		if clan then
			clanSendData( pla, clan )
		end
	
	elseif reqType == "clear" then
		setElementData( pla, "clan", false )
		setAccountData( acc, "clan", false )
		clanPlayerInit( pla )
	elseif reqType == "invite" then
		if clan and not getAccountData(getPlayerAccount( arg ), "clan") then 
			if not clanInvites[arg] then
				clanInvites[arg] = {}
				addEventHandler( "onPlayerQuit", arg, function() clanInvites[arg] = nil end )
			end
			dbQuery(
			function ( qh )
				local result = dbPoll( qh, 0 )
				if clMaxMembers( result[1]["bizModf"] ) > table.count( fromJSON( result[1]["members"] ) ) then	
					clanInvites[arg][result[1]["id"] ] = true
					outputChatBox("[Clan] Zostałeś zaproszony do "..result[1]["name"].."! Dołącz do niego za pomocą '/clan join "..result[1]["name"].."'' .", arg, 250,250,50)
					outputChatBox("[Clan] Zaprosiłeś "..getPlayerName( arg ).." do "..result[1]["name"]..".", pla, 250,250,50)
				else
					outputChatBox( "[Clan] Nie wystarczająca ilość miejsc. Kup lub ulepsz burdele (brothel)!", pla, 250, 50, 50 )
				end
			end, dbase, "SELECT * FROM clans WHERE name = ? LIMIT 1", clan )
		end
	elseif reqType == "join" then
		if arg then
			if not clan then
				dbQuery(
				function ( qh )
					local result = dbPoll( qh, 0 )
					if result[1] then
						if clanInvites[pla][result[1]["id"]] then
							if clMaxMembers( result[1]["bizModf"] ) > table.count( fromJSON( result[1]["members"] ) ) then	
								local members = fromJSON(result[1]["members"])
								members[getAccountName( getPlayerAccount( pla ) )] = { rank=3 }
								dbExec( dbase, "UPDATE clans SET members = ? WHERE id = ?", toJSON(members), result[1]["id"] )
								setAccountData( acc, "clan", arg )
								setElementData( pla, "clan", arg )
								clanPlayerInit( pla )
								clanInvites[pla][result[1]["id"]] = nil
							else
								outputChatBox( "[Clan] Nie ma wystarczająco miejsc w tym klanie!", pla, 250, 50, 50 )
							end
						else
	      					outputChatBox( "[Clan] Nie byłeś zaproszony do tego klanu!", pla, 250, 50, 50 )
						end
					else
	      				outputChatBox( "[Clan] Taki klan nie istnieje!", pla, 250, 50, 50 )
					end
				end, dbase, "SELECT * FROM clans WHERE name = '".. arg .."' LIMIT 1" )
			else
	      		outputChatBox( "[Clan] Już należysz do klanu!", pla, 250, 50, 50 )
			end
		end
	elseif reqType == "kick" then
		if clan then
			local acc2Name = arg
			dbQuery(
			function ( qh )
				local result = dbPoll( qh, 0 )
				local members = fromJSON( result[1]["members"] )
				local acc2 = getAccount( acc2Name )
				local pla2 = getAccountPlayer( acc2 )
				if acc ~= acc2 then
					local accRank = members[accName]["rank"]
					local acc2Rank = members[acc2Name]["rank"]
					if accRank > acc2Rank then
						setAccountData( acc2, "clan", false )
						if pla2 then
							setElementData( pla2, "clan", false )
						end
						members[acc2Name] = nil
						dbExec( dbase, "UPDATE clans SET members = ? WHERE id = ?", toJSON( members ), result[1]["id"] )

						clanSendData( pla, clan )
					else
	      				outputChatBox( "[Clan] Twoja ranga nie jest wystarczająco wysoka aby wyrzucić tego członka!", pla, 250, 50, 50 )
					end
				else
	      			outputChatBox( "[Clan] Nie możesz wyrzucić sam siebie!", pla, 250, 50, 50 )
				end
			end, dbase, "SELECT * FROM clans WHERE name = '".. clan .."' LIMIT 1" )
		end
	elseif reqType == "promote" then
		if arg and arg2 then
			clanPromote( getPlayerAccount( pla ), getAccount( arg ), tonumber(arg2) )
		end
	end
	--[[for k,v in ipairs( getElementsByType( "team" ) ) do
		if #getPlayersInTeam( v ) == 0 then
			destroyElement( v )
		end
	end]]
end )

--[[addEventHandler( "onPlayerQuit", root, 
function (  )
	local pla = source
	local clan = getElementData( pla, "clan" )
	if clan then
		local team = getTeamFromName( clan )
		if team and #getPlayersInTeam( team ) == 1 then
			destroyElement( team )
		end
	end
end )]]
onlineClans = {}
function clanPlayerInit( pla )
	local acc = getPlayerAccount( pla )
	local clan = getAccountData( acc, "clan" )
	if not clan then clan = "" end
	dbQuery(
	function ( qh )
		local result = dbPoll( qh, 0 )
		if not result[1] then
			setAccountData( acc, "clan", false )
		else
			local isInClan = false
			local members = fromJSON(result[1]["members"])
			if members[getAccountName( acc )] then isInClan = true end

			if isInClan then
				--[[local team = getTeamFromName( result[1]["name"] )
				if not team then
					team = createTeam( result[1]["name"], math.random(100,220), math.random(100,220), math.random(100,220) )
					clBizRefMod( result[1]["name"] )
				end
				setPlayerTeam( pla, team )]]
				--clBizRefMod( clan )
			else
				setAccountData( acc, "clan", false )
			end
		end
		setElementData( pla, "clan", getAccountData( acc, "clan" ) )
	end, dbase, "SELECT * FROM 'clans' WHERE name = ? LIMIT 1", clan )
end

function clanKick( pla )
	if pla then
		setAccountData( getPlayerAccount( pla ), "clan", false )
		clanPlayerInit( pla )
	end
end
function clanCreate( pla, name )
	local acc = getPlayerAccount( pla )
	local members = {}
	members[getAccountName( getPlayerAccount( pla ) )] = { rank=20 }
	dbExec( dbase, "INSERT INTO clans VALUES (?,?,?,?,?,?,?)", nil, name, toJSON( members ), 0, 0, toJSON( {} ), bizModf)
	outputChatBox("[Clan] Właśnie stworzyłeś klan o nazwie "..name.."!", pla, 50,250,50)
	setAccountData( acc, "clan", name )
	setElementData( pla, "clan", name )
	--local team = createTeam( name, 150,250,50 )
	--setPlayerTeam( pla, team )
	clBizRefMod( name )
end

function clanSendData( pla, clan )
	if not clan then getElementData( pla, "clan" ) end
	if clan then	
		dbQuery( 
		function ( qh )
			local result = dbPoll( qh, 0 )
			if result then
				dbQuery( 
				function ( qh )
					local result2 = dbPoll( qh, 0 )
					triggerClientEvent( pla, "clanReceiveData", pla, result[1], result2 )	
				end, dbase, "SELECT * FROM biz WHERE clan = ?", result[1]["name"] )
			else
				outputChatBox( "[Clan] SV-Error-1 occurred: Could not load clan data!", pla, 250, 50, 50 )
			end
		end, dbase, "SELECT * FROM clans WHERE name = ? LIMIT 1", clan )
	end
end

function clanPromote( acc, acc2, val )
	local pla = getAccountPlayer( acc )
	local accName = getAccountName( acc )
	local acc2Name = getAccountName( acc2 )
	local clan = getAccountData( acc2, "clan" )
	dbQuery( 
	function ( qh )
		local result = dbPoll( qh, 0 )
		if result[1] then
			local members = fromJSON( result[1]["members"] )
			local curRank2 = members[acc2Name]["rank"]
			local curRank = members[accName]["rank"]
			if curRank2+val <= 0 or curRank2+val > 9 then
				outputChatBox( "[Clan] Nie możesz ustawić tej rangi temu członkowi!", pla, 250, 50, 50 )
				return
			end

			members[acc2Name]["rank"] = curRank2+val
			dbExec( dbase, "UPDATE clans SET members = ? WHERE id = ?", toJSON( members ), result[1]["id"] )
		end
	end, dbase, "SELECT * FROM clans WHERE name = '".. clan .."' LIMIT 1")
end


-- biznesy

function bizCreate( x,y,z, bizType )

	-- dać sprawdzenie typu itd
	dbExec( dbase, "INSERT INTO biz VALUES (?,?,?,?,?,?,?,?,?,?)", nil, toJSON( {x,y,z} ), bizType, "", 1, 500, 0, "name",0,nil )
end

--[[
addCommandHandler( "biz",
function ( pla, cmd, arg )
	local x,y,z = getElementPosition( pla )
	createBlip( x, y, z )
	bizCreate( x,y,z, arg )
end )]]

addEventHandler( "onResourceStart", resourceRoot, 
function (  )
	dbQuery( 
	function ( qh )
		local result = dbPoll( qh, 0 )
		local bizColParent = createElement( "bizColParent" )
		for k,v in ipairs(result) do
			local pos = fromJSON(v["pos"])
			local obj = nil
			if v["clan"] == "" then
				obj = createObject( 1273, pos[1], pos[2], pos[3], nil,nil,nil, true )
			else
				obj = createObject( 1272, pos[1], pos[2], pos[3], nil,nil,nil, true )
			end
			setObjectScale( obj, 2 )
			setElementCollisionsEnabled( obj, false )
			local col = createColSphere( pos[1], pos[2], pos[3], 1.5 )
			setElementData( col, "biz", v["id"] )
			setElementParent( col, bizColParent )
			--if v["clan"] == "" then createBlip( pos[1], pos[2], pos[3], 8, 1, nil,nil,nil,nil , 5, 170 ) end
		end
		addEventHandler( "onColShapeHit", bizColParent,
		function ( el, md )
			if getElementType( el ) == "player" and md and not isPedInVehicle( el ) then
				local clan = getElementData( el, "clan" )
				if clan then
					local col = source
					if md and getElementType( el ) == "player" then
						dbQuery( 
						function ( qh )
							local result = dbPoll( qh, 0 )
							if result[1] then
								triggerClientEvent( el, "bizWindowOpen", el, result[1] )
							else
								outputDebugString( "Biz from col did not load " .. getElementData( col, "biz" ) , 3, 255, 0, 0 )
							end
						end, dbase, "SELECT * FROM biz WHERE id = " .. getElementData( col, "biz" ) )
					end
				else
					outputChatBox( "[Clan] Żeby kupować biznesy, potrzebujesz klanu!", el, 250, 50, 50 )
				end
			end
		end )
	end, dbase, "SELECT * FROM biz" )
end )




function bizRemove( id )
	if getAccountName( getPlayerAccount( client ) ) == "Yazir" then
		dbExec( dbase, "DELETE FROM biz WHERE id = ?", id)
		for i,v in ipairs(getElementsByType( "colshape" )) do
			if getElementData( v, "biz" ) and getElementData( v, "biz" ) == id then
				destroyElement( v )
			end
		end
	end	
end
addEvent( "bizRemove", true )
addEventHandler( "bizRemove", root, bizRemove )

addEvent( "clanDeposit", true )
addEventHandler( "clanDeposit", root, 
function ( money )
	if type(money) == "number" then
		money = math.floor( money )
		if money > 0 and getPlayerMoney( client ) >= money then
			local clan = getElementData( client, "clan" )
			takePlayerMoney( client, money )
			dbExec( dbase, "UPDATE clans SET balance = balance + ? WHERE name = ?", money, clan )
			outputChatBox("[Clan] Depozyt udany!", client, 50,250,50)
			clanSendData( client, clan )
		end
	end
end )

addEvent( "buyBizRequest", true )
addEventHandler( "buyBizRequest", root,
function ( bizID )
	local clan = getElementData( client, "clan" )
	local pla = client
	if not clan then return end
	dbQuery(
	function ( qh )
		local result = dbPoll( qh, 0 )
		dbQuery( 
		function ( qh2 )
		 	local result2 = dbPoll( qh2, 0 )
		 	local cost = clBizPrice( result[1]["bizModf"], result2[1]["level"] )
		 	if result[1]["balance"] >= cost then
		 		if result2[1]["clan"] == "" then
		 			local bizModf = fromJSON( result[1]["bizModf"] )
		 			--outputChatBox( result[1]["bizModf"] )
		 			--outputChatBox( clMaxBiz( result2[1]["bizType"] ) .. " " .. tostring( bizModf["count"] ) )
		 			if ( clMaxBiz( result[1]["bizModf"] ) > bizModf["count"] ) or ( result2[1]["bizType"] == "crib" and clMaxBiz( result[1]["bizModf"] == 3 ) ) then
			 			dbExec( dbase, "UPDATE clans SET balance = balance - ? WHERE name = ?", cost, clan )
			 			dbExec( dbase, "UPDATE biz SET clan = ? WHERE id = ?", clan, bizID )
			 			--dbExec( dbase, "UPDATE clans SET bizCount = bizCount+1 WHERE clan = ?", clan )
						outputChatBox("[Clan] Biznes kupiony pomyślnie!", pla, 50,250,50 )
						clBizRefMod( clan )
					else
					outputChatBox( "[Clan] Osiągnięto biznes limitów, kup lub ulepsz hacjentę (crib)!", pla, 250, 50, 50 )
					end
		 		else
					outputChatBox( "[Clan] Ten biznes jest już zajęty!", pla, 250, 50, 50 )
		 		end
		 	else
				outputChatBox( "[Clan] Twój klan nie ma wystarczająco gotówki!", pla, 250, 50, 50 )
		 	end
		end, dbase, "SELECT * FROM biz WHERE id = ?", bizID )
	end, dbase, "SELECT * FROM clans WHERE name = ?", clan )
end )

addEvent( "clBizAction", true )
addEventHandler( "clBizAction", root,
function ( action, id )
	local clan = getElementData( client, "clan" )
	local pla = client
	dbQuery( 
	function ( qh )
		local result = dbPoll( qh, 0 )
		local biz = result[1]
		dbQuery( 
		function ( qh2 )
			local result2 = dbPoll( qh2, 0 )
			local clan = result2[1]
			local bizModf = fromJSON(clan["bizModf"])
			if action == "upgrade" then
				if bizCostAtLevel( result[1]["level"] ) <= result2[1]["balance"] then
					dbExec( dbase, "UPDATE biz SET level = level + 1 WHERE id = ?", id )
					dbExec( dbase, "UPDATE clans SET balance = balance - ? WHERE name = ?", bizCostAtLevel( result[1]["level"] ), clan["name"] )
					outputChatBox("[Clan] Business upgraded!", pla, 50,250,50 )
					clBizRefMod( clan )
					clanSendData( pla, clan["name"] )
				else
					outputChatBox( "[Clan] Twój klan nie ma wystarczająco pieniędzy!", pla, 250, 50, 50 )
				end
			elseif action == "use" then
				if type(biz["ready"]) == "number" and biz["ready"] == 1 then
					local pos = fromJSON( biz["pos"] )
					if biz["bizType"] == "illmoney" then
						dbExec( dbase, "UPDATE biz SET ready = NULL WHERE id = ? ", biz["id"])
						dbExec( dbase, "UPDATE biz SET timer = 30 WHERE id = ? ", biz["id"])

						local col = createColSphere( pos[1], pos[2], pos[3], 5 )
						local blip = createBlip( pos[1], pos[2], pos[3], 51, 2, 0,0,0, 255, 5000, 99999, pla )
						outputChatBox( "[Clan] Udaj się do punktu na mapie.", pla, 250,200,50 )
						addEventHandler( "onPlayerQuit", pla, function (  ) if isElement( col ) then destroyElement( col ) end end )
						addEventHandler( "onElementDestroy", col, function (  ) destroyElement( blip ) end )
						addEventHandler( "onColShapeHit", col,
						function ( el, md )
							if md and el == pla then
								local veh = createVehicle( 609, pos[1], pos[2], pos[3] )
								addEventHandler( "onPlayerQuit", pla, function (  ) if isElement( veh ) then destroyElement( col ) end end )
								setElementData( veh, "clan", getElementData( pla, "clan" ) )
								setElementData( veh, "money",  50 + biz["level"] * 50 )
								warpPedIntoVehicle( pla, veh ) destroyElement( col )
								outputChatBox( "Dostarcz tą ciężarówkę do najbliższej pralni (laundry).", pla, 250,200,50 )
								addEventHandler( "onColShapeHit", root,
								function ( el, md )
								 	if el == veh and getElementData( source, "biz" ) then
								 		dbQuery( 
								 		function ( qh )
								 		 	local result3 = dbPoll( qh, 0 )
								 		 	if result3[1]["bizType"] == "laundry" and result3[1]["clan"] == getElementData( veh, "clan" ) and result3[1]["ready"] then
								 		 		dbExec( dbase, "UPDATE clans SET balance = balance + ? WHERE name = ?", getElementData( veh, "money" ), getElementData( veh, "clan" )  )
												dbExec( dbase, "UPDATE biz SET timer = 20 WHERE id = ? ", biz["id"])
												dbExec( dbase, "UPDATE biz SET ready = NULL WHERE id = ? ", biz["id"])
												dbExec( dbase, "UPDATE biz SET timer = ? WHERE id = ? ", math.max(10,25-15*(result3[1]["level"]/10)), result3[1]["id"])
												dbExec( dbase, "UPDATE biz SET ready = NULL WHERE id = ? ", result3[1]["id"])
												outputChatBox("[Clan] Money delivered to clan successfully (".. getElementData( veh, "money" ) ..") !", pla, 50,250,50 )
								 		 		destroyElement( veh )
								 		 	end
								 		end, dbase, "SELECT * FROM biz WHERE id = ?", getElementData( source, "biz" ) )
								 	end
								end )
							end
						end )
					elseif biz["bizType"] == "money" then
						dbExec( dbase, "UPDATE biz SET ready = NULL WHERE id = ? ", biz["id"])
						dbExec( dbase, "UPDATE biz SET timer = 45 WHERE id = ? ", biz["id"])
						local col = createColSphere( pos[1], pos[2], pos[3], 5 )
						local blip = createBlip( pos[1], pos[2], pos[3], 52, 2, 0,0,0, 255, 5000, 99999, pla )
						outputChatBox( "Go to the spot that appeared on your map.", pla, 250,200,50 )
						local money = 20 + biz["level"] * 35
						addEventHandler( "onElementDestroy", col, function (  ) destroyElement( blip ) end )
						addEventHandler( "onColShapeHit", col,
						function ( el, md )
							if md and el == pla then
								destroyElement( col )
								dbExec( dbase, "UPDATE clans SET balance = balance + ? WHERE name = ?", money, clan["name"]  )
								outputChatBox("[Clan] Zebrano pieniądze i wpłacono do klanu (".. money ..") !", pla, 50,250,50 )
							end
						end )
					else
						outputChatBox( "[Clan] Mie możesz użyć tego biznesu!", pla, 250, 50, 50 )
					end
				else
					outputChatBox( "[Clan] Ten biznes nie jest jeszcze gotowy!", pla, 250, 50, 50 )
				end
			end
		end, dbase, "SELECT * FROM clans WHERE name = ?", clan )
	end, dbase, "SELECT * FROM biz WHERE id = ?", id )
end )

function clBizRefMod( clan )
	if type( clan ) == "table" then clan = clan["name"] end
	dbQuery(
	function ( qh )
		local bizRes = dbPoll( qh, 0 )
		local bizModf = {}
		local count = 0
		for k,v in ipairs(bizRes) do
			if not bizModf[v["bizType"]] then bizModf[v["bizType"]] = 0 end 
			bizModf[v["bizType"]] = bizModf[v["bizType"]] + 1 + v["level"]
			count = count + 1
			--outputChatBox( "Dodaj do: ".. v["bizType"] .. " . Suma: " .. bizModf[v["bizType"]] )
		end
		bizModf["count"] = count
		dbExec( dbase, "UPDATE clans SET bizModf = ? WHERE name = ?", toJSON( bizModf ), clan )
	end, dbase, "SELECT * FROM biz WHERE clan = ?", clan )
end

setTimer( 
function ( )
	dbExec( dbase, "UPDATE biz SET timer = timer - 1 WHERE NOT clan = ''" )
	clBizCheckAll( )
end, 60*1000, 0 )

function clBizCheckAll( )
	dbQuery(
	function ( qh )
		local result = dbPoll( qh, 0 )
		for k,v in ipairs( result ) do
			if v["timer"] <= 0 then
				dbExec( dbase, "UPDATE biz SET ready = 1 WHERE id = ?", v["id"] )
				dbExec( dbase, "UPDATE biz SET timer = 0 WHERE id = ?", v["id"] )
			end
		end
	end, dbase, "SELECT * FROM biz WHERE NOT clan = ''" )
end