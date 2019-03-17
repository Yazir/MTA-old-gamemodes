-- komendy wywolywane przez skrypt do bazy
dbExec(dbase, "CREATE TABLE IF NOT EXISTS pojazdy (id INTEGER PRIMARY KEY AUTOINCREMENT, wlasciciel TEXT, model INTEGER, x FLOAT, y FLOAT, z FLOAT, rot FLOAT, ca INTEGER, cb INTEGER, cc INTEGER, przebieg INTEGER)")
dbExec(dbase, "CREATE UNIQUE INDEX IF NOT EXISTS IDX_id on pojazdy(id)")
dbExec(dbase, "CREATE TABLE IF NOT EXISTS tuning (id INTEGER, t0 INTEGER, t1 INTEGER, t2 INTEGER, t3 INTEGER, t4 INTEGER, t5 INTEGER, t6 INTEGER, t7 INTEGER, t8 INTEGER, t9 INTEGER, t10 INTEGER, t11 INTEGER, t12 INTEGER, t13 INTEGER, t14 INTEGER, t15 INTEGER, t16 INTEGER, paintjob INTEGER, hr INTEGER, hg INTEGER, hb INTEGER)")
dbExec(dbase, "CREATE UNIQUE INDEX IF NOT EXISTS IDX_id on tuning(id)")



function onStartLoadVehicles()
vehlist = {}
local query = dbQuery(dbase, "SELECT * FROM pojazdy")
local result, num_rows, errormsg = dbPoll (query, -1)
	for i,v in pairs(result) do
	local veh = createVehicle(v["model"], v["x"], v["y"], v["z"])
	local textEl = create3dText( v.x,v.y,v.z,"Właściciel: "..v["wlasciciel"], 15, {100,100,100}, 1.2 )
	setElementParent( textEl, veh )
	--attachElements( textEl, veh )
	setTimer( 
	function ()
		local x,y,z = getElementPosition( veh )
		setElementPosition( textEl, x,y,z )
	end, 500, 0)
	table.insert(vehlist, veh)
	setElementRotation(veh, 0, 0, v["rot"])
	setVehicleColor(veh, v["ca"], v["cb"], v["cc"])
	ustawDanePojazdu(veh, v["id"], v["wlasciciel"])
	
	--<< na koncu -->>
	local query = dbQuery(dbase, "SELECT * FROM tuning WHERE id='"..v["id"].."'")
	local result, num_rows, errormsg = dbPoll (query, -1)
	setVehiclePaintjob(veh, result[1].paintjob)
	setVehicleHeadLightColor(veh, result[1].hr, result[1].hg, result[1].hb)
		for i,v in pairs(result) do
			for ii, vv in pairs(v) do
				if (ii ~= "id" and ii ~= "paintjob" and ii ~= "hr" and ii ~= "hg" and ii ~= "hb") then
				local vv = tonumber(vv)
					if vv ~= 0 then
					addVehicleUpgrade(veh, vv)
					end
				end
			end
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStartLoadVehicles)

function ustawDanePojazdu(veh, id, wlasciciel) --id = INT, wlasciciel = STRING
setElementData(veh, "car_id", id)
setElementData(veh, "car_owner", wlasciciel)
end

function onVehicleStartEnter(player, seat, jacked)
  if seat == 0 then
  local car_owner = getElementData(source, "car_owner")
	if car_owner then
	local account = getPlayerAccount(player)
		if account then
		local name = getAccountName(account)
			if car_owner == name then
			prawo_ = true
			end
		end
	
		if prawo_ then
		--wchodzim
		prawo_ = false
		else
		--sio
		outputChatBox("#FFFF00This vehicle doesn't belong to you!", player, 255, 255, 255, true)
		cancelEvent()
		end
	end
  end
end
addEventHandler ("onVehicleStartEnter", resourceRoot, onVehicleStartEnter)

--<<ZAPIS POJAZDU-->>

function zapiszPojazdy()
	for i,v in pairs(vehlist) do
	local id = getElementData(v, "car_id")
		if id then
		local owner = getElementData(v, "car_owner")
		local x, y, z = getElementPosition(v)
		local _, _, rot = getElementRotation(v)
		local color1, color2, color3, color4 = getVehicleColor(v, true)
		dbExec(dbase, "UPDATE pojazdy SET x='"..x.."', y='"..y.."', z='"..z.."', rot='"..rot.."', ca='"..color1.."', cb='"..color2.."', cc='"..color3.."' WHERE id="..id )
		
		local paintjob = getVehiclePaintjob(v)
		local r, g, b = getVehicleHeadLightColor(v)
		sav = {}
			for i=0, 16 do
			local upgrade = getVehicleUpgradeOnSlot(v, i)
			sav[i] = upgrade or 0
			end
		dbExec(dbase, "UPDATE tuning SET t0='"..sav[0].."', t1='"..sav[1].."', t2='"..sav[2].."', t3='"..sav[3].."', t4='"..sav[4].."', t5='"..sav[5].."', t6='"..sav[6].."', t7='"..sav[7].."', t8='"..sav[8].."', t9='"..sav[9].."', t10='"..sav[10].."', t11='"..sav[11].."', t12='"..sav[12].."', t13='"..sav[13].."', t14='"..sav[14].."', t15='"..sav[15].."', t16='"..sav[16].."', paintjob='"..paintjob.."', hr='"..r.."', hg='"..g.."', hb='"..b.."' WHERE id="..id.."")
		sav = nil
		end
	end
end
setTimer(zapiszPojazdy, 60*5, 0)

function zapiszKomenda(player)
local acc = getAccountName (getPlayerAccount(player))
    if isObjectInACLGroup ("user."..acc, aclGetGroup ("Admin")) then
	zapiszPojazdy()
	outputChatBox("#FFFF00 Zapisano pojazdy.", player, 255, 255, 255, true)
	end
end
addCommandHandler("zapiszpojazdy", zapiszKomenda)

-- mapa, f11
addEvent("pobierzPojazdyGracza", true)
addEventHandler("pobierzPojazdyGracza", getRootElement(),
function()
local account = getPlayerAccount(source)
	if account then
	local name = getAccountName(account)
	local vehs = getVehiclesByOwner(name)
	triggerClientEvent(source, "zwrocPojazdyGracza", root, vehs)
	end
end)

--
-- id pojazdu
function getVehicleByID(poszukiwane_id)
	for i,v in pairs(vehlist) do
	local id = getElementData(v, "car_id")
		if id then
		local id = tonumber(id)
		local poszukiwane_id = tonumber(poszukiwane_id)
			if id == poszukiwane_id then
			return v
			end
		end
	end
	return false
end

--zwraca pojazdy ktore posiada dany login
function getVehiclesByOwner(szukany)
tab = {}
	for i,v in pairs(vehlist) do
	local owner = getElementData(v, "car_owner")
		if owner then
			if owner == szukany then
			table.insert(tab, v)
			end
		end
	end
	return tab
end

--zwraca liczbe pojazdow jaka ma dany login
function getYourVehicleCount(login)
local vehs = getVehiclesByOwner(login)
return #vehs
end


-- salon

local zakup = {}
--wzor: zakup[id_pojazdu] = cena
zakup[404] = {1500,0} -- perenial
zakup[600] = {1750,0} -- picador
zakup[543] = {1750,0} -- sadler
zakup[546] = {2000,0} -- intruder
zakup[515] = {2250,0} -- roadtrain
zakup[410] = {2500,0} -- manana
zakup[466] = {2750,0} -- glendale
zakup[468] = {2750,0} -- sanchez
zakup[516] = {2750,0} -- nebula
zakup[426] = {5500,0} -- premier
zakup[509] = {6666,0} -- bike
zakup[475] = {7000,0} -- sabre
zakup[489] = {7500,0} -- rancher
zakup[402] = {8000,0} -- buffalo
zakup[496] = {9000,0} -- blista compact
zakup[581] = {12000,0} -- bf-400
zakup[602] = {14000,0} -- alpha
zakup[520] = {800000,0}
zakup[411] = {15000,1} --infernus
zakup[560] = {17500,1} --sultan
zakup[593] = {20000,1} --dodo
zakup[522] = {22500,1} --nrg

local marker = createMarker(1362.1064453125,-1755.7653808594,13.51268196106-0.85, "cylinder", 1, 255, 0, 0, 100)
local blip = createBlip( 1362.1064453125,-1755.7653808594,13.51268196106, 55, 2,nil,nil,nil,5, 1000 )

function onSalonHit(hitElement, md)
    if getElementType(hitElement) == "player" and md then
    triggerClientEvent(hitElement, "pokazGUISalonu", root, zakup)
    end
end
addEventHandler("onMarkerHit", marker, onSalonHit)
addEvent("kupPojazdSalon", true)
addEventHandler("kupPojazdSalon", getRootElement(),
function(id)
local cena = zakup[id][1]
    if cena then
		local account = getPlayerAccount(source)
        if account then

        	local vipLevel = getAccountData( account, "vipLevel" )
        	if zakup[id][2] > 0 then 
        		if not vipLevel then
        			outputChatBox("#FF0000[+] Nie masz odpowiedniej usługi aby kupić ten pojazd.", source, 255, 255, 255, true)
        			return
        		elseif vipLevel < zakup[id][2] then
        			outputChatBox("#FF0000[+] Twoja usługa jest zbyt niskiego poziomu aby kupić ten pojazd.", source, 255, 255, 255, true)
        			return
        		end
        	end 

	        if getPlayerMoney(source) >= cena then
	          local wlasciciel = getAccountName(account)
	            if 100 >= getYourVehicleCount(wlasciciel) then
	            takePlayerMoney(source, cena)
	            triggerClientEvent(source, "potwierdzKupnoPojazduPrywatnego", root)
	            fadeCamera(source, false)
	                setTimer(function(source)
	               	-- tutaj zmien s ekordy po zakupie auta (x, y, z, rotacja)
	                local x, y, z, rot = 1344.4523925781,-1752.5454101563,13.360048294067, 350
	                local veh = createVehicle(id, x, y, z)
	                table.insert(vehlist, veh)
	                local r, g, b = getVehicleColor(veh, true)
	                fadeCamera(source, true)
	                --<<-->>
	                local query = dbQuery(dbase, "INSERT INTO pojazdy (wlasciciel, model, x, y, z, rot, ca, cb, cc, przebieg, paliwo) VALUES (?, ?, ?, ?, ?, ?,?,?,?,?,?)", wlasciciel, id, x, y, z, rot, r, g, b, 50, 0)
	                local result, num_affected_rows, last_insert_id = dbPoll(query, -1)
	                local r, g, b = getVehicleHeadLightColor(veh)
	                dbExec(dbase, "INSERT INTO tuning (id, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, paintjob, hr, hg, hb) VALUES (?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", last_insert_id, "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "3", r, g, b)
	                --<<-->>
	                setElementRotation(veh, 0, 0, rot)
	                ustawDanePojazdu(veh, last_insert_id, wlasciciel)
	                warpPedIntoVehicle(source, veh)
	                --local text = create3dText( x,y,z, "test", 50, "#ffb7d2a8", 1 )
	                --attachElements( text, veh )
	                end, 1500, 1, source)
	            else
	            -- gdy gracz ma max aut to nic sie nie dzieje
	            end
          	else
	        outputChatBox("#FF0000[+] Nie masz "..cena.."#FF0000$ by kupić ten pojazd.", source, 255, 255, 255, true)
	        end
	    end
    end
end)

--komenda tworzaca
function stworzPojazdCMD(player, cmd, id, wlasciciel)
local acc = getAccountName (getPlayerAccount(player))
    if acc then
    if isObjectInACLGroup ("user."..acc, aclGetGroup ("Admin")) then
        if id and wlasciciel then
        local id = tonumber(id)
            if id then
                if getVehicleNameFromModel(id) then
                local x, y, z = getElementPosition(player)
                local _, _, rot = getElementRotation(player)
                
                local veh = createVehicle(id, x, y, z)
                    if veh then
                    table.insert(vehlist, veh)
                    local r, g, b = getVehicleColor(veh, true)
                    --<<-->>
                    local query = dbQuery(dbase, "INSERT INTO pojazdy (wlasciciel, model, x, y, z, rot, ca, cb, cc, przebieg, paliwo) VALUES (?, ?, ?, ?, ?, ?,?,?,?,?,?)", wlasciciel, id, x, y, z, rot, r, g, b, 50, 0)
                    local result, num_affected_rows, last_insert_id = dbPoll(query, -1)
                    local r, g, b = getVehicleHeadLightColor(veh)
                    dbExec(dbase, "INSERT INTO tuning (id, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, paintjob, hr, hg, hb) VALUES (?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", last_insert_id, "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "3", r, g, b)
                    --<<-->>
                    setElementRotation(veh, 0, 0, rot)
                    ustawDanePojazdu(veh, last_insert_id, wlasciciel)
                    else
                    outputChatBox("#FF0000[+] Nie ma takiego pojazdu w gta typie.", player, 255, 255, 255, true)
                    end
                else
                outputChatBox("#FF0000[+] Nie ma takiego pojazdu w gta typie", player, 255, 255, 255, true)
                end
            end
        else
        outputChatBox("#FF0000[+] Poprawne uzycie: /dajauto <id> <nick>", player, 255, 255, 255, true)
        end
    end
    end
end
addCommandHandler("dajauto", stworzPojazdCMD)

addCommandHandler( "dajkamienia",
function ( pla )
	local acc = getPlayerAccount( pla )
	dbQuery( 
	function ( qh )
		local result = dbPoll( qh, 0 )
		local vehTable = {}
		for k,v in ipairs( result ) do
			vehTable[v["id"]] = true
		end
		local x,y,z = getElementPosition( pla )
	 	for k,v in ipairs( vehlist ) do
		 	if not isPedInVehicle( pla ) and vehTable[getElementData( v, "car_id" )] then
		 		setElementPosition( v, x, y, z+1 )
		 		spawnVehicle( v, x + #vehlist/2*math.cos( k*math.rad(360/#vehlist) ), y + #vehlist/2*math.sin( k*math.rad(360/#vehlist) ), z + math.random(2,3) )
		 	end
	 	end
	end, dbase, "SELECT * FROM pojazdy WHERE wlasciciel = ?", getAccountName( acc ) )
end )