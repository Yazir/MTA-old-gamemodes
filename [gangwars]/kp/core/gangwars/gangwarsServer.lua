addEventHandler( "onResourceStart", resourceRoot, 
function ( )    
    gangTable = {
        grove = {
            ["color"] = {25,180,25},
            ["team"] = createTeam( "Grove", 25,180,25 ),
            ["chatprefix"] = "#19B419[G]",
            ["spawn"] = {2495.2893066406,-1684.908203125,13.511857032776},
            ["vehp"] = {
                createVehMarker( 2511.1103515625,-1671.9044189453,12.9, {veh=492,color={60,120,60}, lvlSpd={60,1.1}, gang="grove"} ),
                createVehMarker( 2473.5280761719,-1695.6450195313,12.8, {veh=600,color={60,90,60}, lvlSpd={58,1.3}, gang="grove", lvl=8} ),
                createVehMarker( 2499.2509765625,-1652.9758300781,12.9, {veh=412,color={60,120,60}, lvlSpd={45,1.6}, gang="grove", rz=90, lvl=15} ),
            },
            ["noticeboard"] = {2491.4541015625,-1693.2575683594,14.765625,180},
            ["owned"] = 0,
            ["wpn"] = {[22]=51,[32]=70},
            ["skins"] = {"grove1","grove2","grove3"},
            ["safezone"] = 55,
            ["perms"] = {
                ["capture"] = true,
                ["totem"] = true
            },
        },
        ballas = {
            ["color"] = {153,50,153},
            ["team"] = createTeam( "Ballas", 153,50,153 ),
            ["chatprefix"] = "#993299[B]",
            ["spawn"] = {1905.9797363281,-1113.5803222656,26.6640625},
            ["vehp"] = {
                createVehMarker( 1916.4722900391,-1130.6447753906,23.8, {veh=566,color={111,11,41}, lvlSpd={60,1.1}, gang="ballas", rz=270} ),
                createVehMarker( 1910.8665771484,-1117.6882324219,24.8, {veh=517,color={111,11,41}, lvlSpd={58,1.3}, gang="ballas", rz=270, lvl=8} ),
                createVehMarker( 1905.5754394531,-1130.6838378906,23.7, {veh=405,color={20,6,6}, lvlSpd={45,1.6}, gang="ballas", rz=90, lvl=15} ),
            },
            ["noticeboard"] = {1900.8134765625,-1112.9444580078,26.666379928589},
            ["owned"] = 0,
            ["wpn"] = {[22]=51,[28]=90},
            ["skins"] = {"ballas1","ballas2","ballas3"},
            ["safezone"] = 55,
            ["perms"] = {
                ["capture"] = true,
                ["totem"] = true
            },
        },
        police = {
            ["color"] = {65,105,225},
            ["team"] = createTeam( "Policja", 65,105,225 ),
            ["chatprefix"] = "#4169e1[P]",
            ["spawn"] = {1538.2834472656,-1675.4926757813,13.546875},
            ["vehp"] = {
                createVehMarker( 1565.4072265625,-1610.0362548828,12.9  , {veh=596, lvlSpd={70,1.3}, gang="police"} ),
                createVehMarker( 1557.3892822266,-1609.978515625,13     , {veh=523, lvlSpd={65,1.4}, gang="police", lvl=5} ),
                createVehMarker( 1587.8062744141,-1709.67028808,5       , {veh=427, lvlSpd={40,2},   gang="police", lvl=20} ),
            },
            ["noticeboard"] = {1553.8244628906,-1684.6700439453,13.548006057739,270},
            ["owned"] = 0,  
            ["wpn"] = {[23]=60,[3]=1},
            ["skins"] = {"police1","police2","police3"},
            ["safezone"] = 70,
            ["perms"] = {
                ["capture"] = true
            },
        },
        vagos = {
            ["color"] = {255,215,0},
            ["team"] = createTeam( "Vagos", 255,215,0 ),
            ["chatprefix"] = "#FFD700[V]",
            ["spawn"] = {2457.1293945313,-1100.7937011719,44},
            ["vehp"] = {
                createVehMarker( 2452.4240722656,-1106.72265625,42.6, {veh=576, lvlSpd={60,1.1}, gang="vagos", rz=0} ),
                createVehMarker( 2468.7014160156,-1093.98046875,43.6, {veh=467, lvlSpd={58,1.3}, gang="vagos", rz=90, lvl=6} ),
                createVehMarker( 2441.9450683594,-1097.5656738281,41.6, {veh=474, lvlSpd={45,1.8}, gang="vagos", rz=0, lvl=14} ),
            },
            ["noticeboard"] = {2461.2565917969,-1102.4981689453,43.8671875, 180},
            ["owned"] = 0,
            ["wpn"] = {[22]=51,[25]=90},
            ["skins"] = {"vagos1","vagos2","vagos3"},
            ["safezone"] = 65,
            ["perms"] = {
                ["capture"] = true,
                ["totem"] = true
            },
        },
        aztecas = {
            ["color"] = {51,179,166},
            ["team"] = createTeam( "Aztecas", 51,179,166 ),
            ["chatprefix"] = "#33B3A6[A]",
            ["spawn"] = {1878.8098144531,-1982.3273925781,13.546875},
            ["vehp"] = {
                createVehMarker( 1887.3159179688,-2000.7963867188,12.8, {veh=567, lvlSpd={50,1.1}, gang="aztecas", rz=180} ),
                createVehMarker( 1878.8278808594,-2000.8247070313,12.8, {veh=575, lvlSpd={65,1.5}, gang="aztecas", rz=180, lvl=15} ),
                createVehMarker( 1887.1857910156,-2019.0460205078,12.8, {veh=534, lvlSpd={50,1.8}, gang="aztecas", rz=180, lvl=25} ),
            },
            ["noticeboard"] = {1888.9281005859,-1984.8851318359,13.546875, 270},
            ["owned"] = 0,
            ["wpn"] = {[22]=51,[28]=90},
            ["skins"] = {"aztecas1","aztecas2","aztecas3"},
            ["safezone"] = 65,
            ["perms"] = {
                ["capture"] = true,
                ["totem"] = true
            },
        },
        rus = {
            ["color"] = {118,0,0},
            ["team"] = createTeam( "Ruska Mafia", 118,0,0 ),
            ["chatprefix"] = "#760000[RUS]",
            ["spawn"] = {1126.7889404297,-2037.1604003906,70},
            ["vehp"] = {
                createVehMarker( 1117.0432128906,-2053.7697753906,73.5, {veh=469, color={15,15,15}, gang="rus", lvl = 35} ),
                createVehMarker( 1133.8660888672,-2025.5432128906,68.4, {veh=445, color={15,15,15}, lvlSpd={70,1.5}, gang="rus", rz=180, lvl=20} ),
                createVehMarker( 1133.6206054688,-2053.0383300781,68.4, {veh=558, color={15,15,15}, lvlSpd={80,1.5}, gang="rus", lvl=30} ),
            },
            ["noticeboard"] = {1126.3383789063,-2042.5257568359,69.880935668945,90},
            ["owned"] = 0,
            ["wpn"] = {[30]=120,[27]=30},
            ["skins"] = {"rus1","rus2","rus3"},
            ["safezone"] = 90,
            ["perms"] = {
                ["capture"] = true,
                ["totem"] = true
            },
        },
        nomad = {
            ["color"] = {153,153,153},
            ["team"] = createTeam( "Odludki", 153,153,153 ),
            ["chatprefix"] = "#999999[N]",
            ["spawn"] = {2058.3322753906,-1697.0646972656,13.554683685303},
            ["owned"] = 0,
            ["vehp"] = {
                createVehMarker( 2072.3312988281,-1699.6363525391,12.6, {veh=568, gang="nomad", lvl = 10, lvlSpd={50,2}} ),
            },
            --["wpn"] = {[30]=120,[27]=30},
            ["skins"] = {"nomad1","nomad2","nomad3"},
            ["safezone"] = 20,
            ["perms"] = {
                ["capture"] = true,
                ["totem"] = true
            },
        },
        vigilante = {
            ["color"] = {190,25,25},
            ["spawn"] = {1538.2834472656,-1675.4926757813,13.546875},
            ["owned"] = 0,
            ["perms"] = {
                ["capture"] = false
            },
        },
        civilian = {
            ["color"] = {229,121,27},
            ["chatprefix"] = "#e5791b[C]",
            ["team"] = createTeam( "Cywile", 229,121,27 ),
            ["spawn"] = {1743.0260009766,-1860.4760742188,13.57869052887},
            ["vehp"] = {
                createVehMarker( 1753.6872558594,-1862.8139648438,12.8, {veh=462, lvlSpd={45,0.2}}),
            },
            ["safezone"] = 50,
            ["perms"] = {
                ["capture"] = false
            },
        },
    }
    gangTable["grove"]["joinp"]     = createGangJoinMarker( 2502.8708496094,-1685.9483642578,12.9, {gang="grove", cost=30, blip=62} )
    gangTable["ballas"]["joinp"]    = createGangJoinMarker( 1901.7727050781,-1118.2255859375,24.8, {gang="ballas",cost=30, blip=59} )
    gangTable["police"]["joinp"]    = createGangJoinMarker( 1545.6917724609,-1669.3096923828,12.9, {gang="police",cost=200, blip=30, lvl=4, wanted=0} )
    gangTable["vagos"]["joinp"]    = createGangJoinMarker( 2457.0173339844,-1101.3491210938,42.6, {gang="vagos",cost=50, blip=60} )
    gangTable["rus"]["joinp"]    = createGangJoinMarker( 1132.1228027344,-2030.3757324219,68.3, {gang="rus",cost=1000, blip=25, lvl=20, vip=1} )
    gangTable["aztecas"]["joinp"]    = createGangJoinMarker( 1878.9130859375,-1977.7897949219,12.8, {gang="aztecas",cost=50, blip=58} )

end )

function getGangTable(  )
    return gangTable
end

local gangjoinParent = createElement( "gangjoinParent" )
local gangPlayersInJoinMarkers = {}
function createGangJoinMarker( x,y,z, data )
    local color = gangTable[data["gang"]]["color"]
    local marker = createMarker( x,y,z, "cylinder", 2, color[1], color[2], color[3], 255 )
    setElementData( marker, "gangJoinData", data, false )
    if data["blip"] then local blip =createBlip( x,y,z, data["blip"], nil, nil,nil,nil,nil,5, 800 ) setElementParent( blip, marker ) end
    local text = "Organizacja: "..data["gang"]
    if data["cost"] then text = text.."\nWpłata: "..data["cost"] end
    if data["lvl"] then text = text.."\nWymagany poziom: "..data["lvl"] end
    if data["wanted"] then text = text.."\nMax wanted: "..data["wanted"] end
    if data["vip"] then text = text.."\n WYMAGANY STATUS PATRONA" end
    create3dText( x,y,z+1.8, text, 25, color, 1.3 )
    setElementParent( marker, gangjoinParent )
end

addEventHandler( "onMarkerHit", gangjoinParent, 
function ( pla, md )
    if md and isElement( pla ) and getElementType( pla ) == "player" then
        local gang = getElementData( pla, "gang" )
        local markerGangData = getElementData( source, "gangJoinData" )
        local pvip = getElementData( pla, "vipLevel" ) if not pvip then pvip = 0 end 
        if markerGangData["vip"] and markerGangData["vip"] > pvip then
            outputChatBox( "[Gang] Nie masz statusu Patrona aby dołączyć do tej organizacji!", pla, 225,25,25 ) return
        elseif markerGangData["lvl"] and markerGangData["lvl"] > getElementData( pla, "lvl" ) then
            outputChatBox( "[Gang] Twój poziom nie jest wystarczająco wysoki aby dołączyć do tej organizacji!", pla, 225,25,25 ) return
            --outputChatBox( "test" )
        elseif markerGangData["cost"] and markerGangData["cost"] > getPlayerMoney( pla ) then
            outputChatBox( "[Gang] Nie masz przy sobię wystarczająco dużo pieniędzy aby dołączyć do tej organizacji!", pla, 225,25,25 ) return
            --outputChatBox( "test2" )
        elseif markerGangData["wanted"] and markerGangData["wanted"] < getElementData( pla, "wanted" ) then
            outputChatBox( "[Gang] Twój wanted level jest zbyt wysoki aby dołączyć do tej organizacji!", pla, 225,25,25 ) return
        end

        gangPlayersInJoinMarkers[pla] = source
        if gang == "civilian" then
            outputChatBox( "[Gang] Napisz '/gang join' aby zostać członkiem "..markerGangData["gang"]..".", pla, 0,200,200 )
        else
            outputChatBox( "[Gang] Aby dołączyć do tej organizacji, musisz opuścić aktualną (/gang leave).", pla, 0,200,200 )
        end
    end
end )

addEventHandler( "onMarkerLeave", gangjoinParent,
function ( pla )
    if isElement( pla ) and getElementType( pla ) == "player" then
        gangPlayersInJoinMarkers[pla] = nil
    end
end )

addCommandHandler( "gang",
function ( pla, cmd, arg, arg2 )
    local gang = getElementData( pla, "gang" )
    local gangJoinMarker = gangPlayersInJoinMarkers[pla]
    local markerGangData = nil
    if gangJoinMarker then markerGangData = getElementData( gangJoinMarker, "gangJoinData" ) end
    if arg == "leave" then
        if gang ~= "civilian" then
            setAccountData( getPlayerAccount( pla ), "savedPos", toJSON( {getElementPosition( pla )} ) )
            gangJoinPlayer( pla, "civilian" )
            outputChatBox( "[Gang] Opuściłeś swoją organizację i zostałeś cywilem.", pla, 0,255,200 )
            spawn( pla )
        else
            outputChatBox( "[Gang] Jesteś już cywilem!", pla, 225,25,25 )
        end
    elseif arg == "join" then
        if gangJoinMarker then
            if gang == "civilian" then
                setAccountData( getPlayerAccount( pla ), "savedPos", toJSON( {getElementPosition( pla )} ) )
                addMoney( pla, -markerGangData["cost"] )
                gangJoinPlayer( pla, markerGangData["gang"] )
                outputChatBox( "[Gang] Zostałeś członkiem "..markerGangData["gang"]..".",pla, 0,255,200 )
            else
                outputChatBox( "[Gang] Najpierw opuść swoją organizację (/gang leave)!",pla, 225,25,25 )
            end
        else
            outputChatBox( "[Gang] Nie jesteś w żadnym znaczniku organizacji!",pla, 225,25,25 )
        end
    elseif arg == "nomad" then
        if gang ~= "nomad" then
            setAccountData( getPlayerAccount( pla ), "savedPos", toJSON( {getElementPosition( pla )} ) )
            gangJoinPlayer( pla, "nomad" )
            outputChatBox( "[Gang] Zostałeś właśnie odludkiem!.",pla, 0,255,200 )
        else
            outputChatBox( "[Gang] Jesteś już odludkiem!", pla, 225,25,25 )
        end
    end
end )

function gangSpawn( pla, forcedPos )
    local acc = getPlayerAccount( pla )
    local pos = fromJSON( getAccountData( acc, "savedPos" ) ) 
    local gang = getElementData( pla, "gang" )
    if gang and gangTable[gang] then
        if forcedPos or not pos[1] then pos = gangTable[gang]["spawn"] end

        local dim = getElementData( pla, "dimension" )

        local resetDim = true
        if lobbys[dim] then 
            if lobbys[dim]["status"] ~= "starting" or lobbys[dim]["status"] ~= "waiting" then
                resetDim = false
            end
        end
        if resetDim then
            setElementData( pla, "roomname", "Lobby" )
            setElementData( pla, "dimension", 0 )
        end

        spawnPlayer( pla, pos[1], pos[2], pos[3], 0, getElementData( pla, "skin" ), 0, 0, gangTable[gang]["team"] )
        setElementData( pla, "deathTs", getRealTime()["timestamp"] )
        setCameraTarget( pla, pla )
        setPlayerBlipped( pla )
        maxPlayerStats( pla )
        loadWeapons( pla )

        maxPlayerStats( pla )
        
        local gang = getElementData( pla, "gang" )
        if gang == "police" then
            setPedStat( pla, 70, 1 )
        end
        local wepGiveTimestamp = getAccountData( acc, "wepGiveTimestamp" )
        if not wepGiveTimestamp or wepGiveTimestamp<getRealTime()["timestamp"]-60*40 then
            if gangTable[gang]["wpn"] then
                for k,v in pairs( gangTable[gang]["wpn"] ) do
                    giveWeapon( pla, k, v )
                end
            end
            setAccountData( acc, "wepGiveTimestamp", getRealTime()["timestamp"] )
            outputChatBox( "[Gang] Received gang weapons.", pla, 25,255,25 )
        end
    end
end
addEventHandler( "onPlayerLogin", root, function() spawn( source ) end )

local GANG_AREA_SIZE = 190
local ORIGIN_X, ORIGIN_Y = 1660.2268066406,-2155.41015625
--local gangAreas = {}
local playersInGangAreas = {}
local gangAreasIndexed = {}

function createGangArea( x,y,size )
    local index = #gangAreasIndexed+1
    gangAreasIndexed[index] = {}
    local gangArea = gangAreasIndexed[index]
    gangArea = {}
    gangArea["col"] = createColRectangle( x-size/2, y-size/2,  size, size )
    gangArea["radarArea"] = createRadarArea( x-size/2, y-size/2, size, size, 255,255,255,math.random(190,225) )
    gangArea["owner"] = nil
    gangArea["playerCount"] = 0
    gangArea["playersThatWereIn"] = {}
    gangArea["tickets"] = {}
    for k,v in pairs( gangTable ) do gangArea["tickets"][k] = 0 end
    gangAreasIndexed[index] = gangArea
    addEventHandler( "onColShapeHit", gangArea["col"],
    function ( el, md )
        if md and getElementType( el ) == "player" then
            if gangTable[getElementData( el, "gang" )]["perms"]["capture"] then
                gangRemovePlayerFromArea( el )
                playersInGangAreas[el] = gangArea
                gangArea["playerCount"] = gangArea["playerCount"]+1
                if not gangArea["playersThatWereIn"][el] then
                    gangArea["playersThatWereIn"][el] = true
                    if gangArea["owner"] == "vigilante" then
                        gangGiveVigilanteWeapons( el )
                    end
                end
                triggerClientEvent( el, "gangGetAreaTable", el, gangArea["tickets"] )
            end
        end
    end )
end


addEventHandler( "onResourceStart", resourceRoot, 
function (  )
    --[[for x=1,5 do
                gangAreas[x] = {}
                for y=1,6 do
                    --local gArea = gangAreas[x][y]
                    local xPos, yPos = ORIGIN_X+(x-1)*GANG_AREA_SIZE, ORIGIN_Y+(y-1)*GANG_AREA_SIZE
                    
                end
            end]]

    createGangArea( 2166.8981933594,-1801.2843017578, 75 )
    createGangArea( 1920.5344238281,-1397.514038085, 95 )
    createGangArea( 2308.8994140625,-1433.5500488281, 85 )
    createGangArea( 2299.8884277344,-1790.3298339844, 75 )
    createGangArea( 2255.0786132813,-1931.3835449219, 85 )
    createGangArea( 1780.3836669922,-1376.5675048828, 85 )
    createGangArea( 1173.1328125,-1642.469726562, 70 )
    createGangArea( 2336.7580566406,-1288.6776123047, 70 )
    createGangArea( 2151.2568359375,-1590.5686035156, 70 )

    local gangAreaAccData = getAccountData( resourceAccount, "gangAreas" )
    if gangAreaAccData then
        gangAreaAccData = fromJSON( gangAreaAccData )
        outputChatBox( tostring( #gangAreaAccData ) )
        for k,v in ipairs( gangAreaAccData ) do
            if gangAreasIndexed[v[1]] then
                gangAreaSetOwner( gangAreasIndexed[v[1]], v[2] )
            end
        end
    end

    setTimer(
    function (  )
        if gangTable["vigilante"]["owned"] < 2 then
            local gangArea = gangAreasIndexed[math.random(1,#gangAreasIndexed)]
            if gangArea["owner"] ~= "vigilante" then
                gangAreaSetOwner( gangArea, "vigilante" )
                triggerClientEvent( root, "notif", resourceRoot, "Nowa strefa wojny pokazała się na mapie!", "info" )
            end
        end
    end, 1000*60*0.05, 0 )

    for k,v in pairs( gangTable ) do
        if v["safezone"] then
            local pos = v["spawn"]
            exports.kp_safezones:createSafezone( pos[1], pos[2], v["safezone"] )
        end

        local boardpos = v["noticeboard"]
        if boardpos then
            local rotz = 0
            if boardpos[4] then rotz = boardpos[4] end
            local obj = createObject( 2616, boardpos[1], boardpos[2], boardpos[3],0,0,rotz )
            local col = createColSphere( boardpos[1], boardpos[2], boardpos[3], 2 )
            setElementDoubleSided( obj, true )
            create3dText( boardpos[1], boardpos[2], boardpos[3], "[Tablica ogłoszeń]\nZadania i aktywności", 15, v["color"], 3.5 )
            setElementData( col, "noticeboard", true )
            setElementData( col, "gang", k )
        end
    end
end )



addEventHandler( "onResourceStop", resourceRoot,
function (  )
    local data = {}
    for k,v in ipairs( gangAreasIndexed ) do
        if v["owner"] then
            data[#data+1] = {k,v["owner"]}
        end
    end
    setAccountData( resourceAccount, "gangAreas", toJSON( data ) )
end, false, "high" )

addEvent( "onPlayerLeaveGangArea" )
local MAX_TICKETS = 35
setTimer(
function (  )
    for pla,gangArea in pairs( playersInGangAreas ) do
        local gang = getElementData( pla, "gang" )
        if isElement( pla ) and isElementWithinColShape( pla, gangArea["col"] ) and gangTable[gang] and gangTable[gang]["perms"]["capture"] then
            if not getElementData( pla, "inSafezone" ) then
                for gangKey,v in pairs( gangArea["tickets"] ) do
                    local tickets = gangArea["tickets"][gangKey]
                    if gang == gangKey then
                        if not isPedDead( pla ) and tickets < MAX_TICKETS then
                            tickets = tickets+1
                            if gangArea["owner"] ~= gang then
                                setRadarAreaFlashing( gangArea["radarArea"], true )
                                if tickets >= MAX_TICKETS then
                                    if gangArea["owner"] then gangArea["tickets"][gangArea["owner"]] = math.floor( MAX_TICKETS/2 ) end
                                    setRadarAreaFlashing( gangArea["radarArea"], false )
                                    --gangArea["owner"] = gangKey
                                    gangAreaSetOwner( gangArea, gangKey )
                                    for k,v in pairs( playersInGangAreas ) do
                                        local gang2 = getElementData( k, "gang" )
                                        if gangKey == gang2 and v == gangArea then
                                            outputChatBox( "[Gang] Zdobyłeś 10$ i 5XP za przejęcie terenu!", k, 25,235,25 )
                                            addMoney( k, 10 )
                                            addExp( k, 5 )
                                        end
                                    end
                                end          
                            end
                        end
                    elseif gang ~= gangKey then
                        if not isPedDead( pla ) and tickets > 0 and gangArea["owner"] ~= gangKey then
                            tickets = tickets-1
                            
                        end
                    end
                    gangArea["tickets"][gangKey] = tickets
                end
                triggerClientEvent( pla, "gangGetAreaTable", pla, gangArea["tickets"] )
            end
        else
            if isElement( pla ) then
                triggerEvent( "onPlayerLeaveGangArea", pla )
            end
            gangRemovePlayerFromArea( pla )
        end
    end
end, 1000, 0)

function gangAreaSetOwner( gangArea, gang )
    local areaOpac = 200
    if gang == "vigilante" then for k,v in pairs( gangArea["tickets"] ) do gangArea["tickets"][k] = 0 end areaOpac = 235 end
    if not gangArea then return false end
    if gangTable[gangArea["owner"]] then gangTable[gangArea["owner"]]["owned"] = gangTable[gangArea["owner"]]["owned"]-1 end
    gangTable[gang]["owned"] = gangTable[gang]["owned"]+1
    local color = gangTable[gang]["color"]
    gangArea["playersThatWereIn"] = {}
    setRadarAreaColor( gangArea["radarArea"], color[1], color[2], color[3], areaOpac )
    gangArea["tickets"][gang] = MAX_TICKETS
    gangArea["owner"] = gang
    setRadarAreaFlashing( gangArea["radarArea"], false )
    --[[local xPos, yPos = getElementPosition( gangArea["col"] )
            for i=1,2 do
                local skin, team = 287, "civilian"
                if not vigilante then skin=globalItemTable[gangTable[gang]["skins"][#gangTable[gang]["skins"] ] ]["skinID"] team=gangTable[gang]["team"] end
                local ped = spawnBot(xPos+math.random(0,GANG_AREA_SIZE),yPos+math.random(0,GANG_AREA_SIZE),16,math.rad( math.random( 0, 360 ) ), skin, 0,0, team , 30 )
                addEventHandler( "onPedWasted", ped, 
                function ( amm, att, wpn, bp )
                    if isElement( att ) and getElementType( att ) == "player" and gang ~= getElementData( att, "gang" ) then
                        addMoney( att, 8 )
                        addExp( att, 2 )
                        outputChatBox( "[Gang] Dostałeś 8$ i 2XP za zabicie bota.", att, 25, 255, 25 )
                    end
                end )
            end]]
end



local vigilWeps = {{27,14}, {31,35}, {18,2}}
function gangGiveVigilanteWeapons( pla )
    local wep = vigilWeps[math.random(1,#vigilWeps)]
    giveWeapon( pla, wep[1], wep[2] )
    outputChatBox( "[Gang] You got "..getWeaponNameFromID( wep[1] ).."!", pla, 235,25,25 )
end

function gangRemovePlayerFromArea( pla )
    local gangArea = playersInGangAreas[pla]
    if gangArea then
        gangArea["playerCount"] = gangArea["playerCount"]-1
        playersInGangAreas[pla] = nil
        if gangArea["playerCount"] == 0 then setRadarAreaFlashing( gangArea["radarArea"], false ) end
        if isElement( pla ) then
            triggerClientEvent( pla, "gangGetAreaTable", pla, false )
        end
    end
end

local specialGangAreas = {}

addEvent( "onPlayerGangChange" )
function gangJoinPlayer( pla, gang )
    local acc = getPlayerAccount( pla )
    if gangTable[gang] then

        local force = false
        if gang ~= getAccountData( acc, "gang" ) then
            triggerEvent( "onPlayerGangChange", pla )
            local skin = 73
            if gangTable[gang] and gangTable[gang]["skins"] and exports.kp_inventory then skin=exports.kp_inventory:getGlobalItem(gangTable[gang]["skins"][math.random(1,#gangTable[gang]["skins"]) ] )["skinID"] end
            if not skin then skin = 73 end
            setElementData( pla, "skin", skin )
            setAccountData( acc, "skin", skin )
            --force = true
        end
 
        local inv = getElementData( pla, "globalInv" )
        for k,v in pairs( gangTable ) do
            if v["skins"] then
                for k2,v2 in ipairs( v["skins"] ) do
                    if k == gang then
                        inv[v2] = 1
                    else
                        inv[v2] = nil
                    end
                end
            end
        end
        setElementData( pla, "globalInv", inv )
        setElementData( pla, "gang", gang )
        setAccountData( acc, "gang", gang )
        if gang ~= "civilian" then
            saveWeapons( pla )
            spawn( pla, force )
        end
    end
end

addCommandHandler( "gangjoin",
function ( pla, cmd, arg1, arg2 )
    gangJoinPlayer( getPlayerFromName( arg1 ), arg2 )
end, true )

addEvent( "gangRequest", true )
addEventHandler( "gangRequest", root,
function ( arg1, arg2 )
    if arg1 == "join" then
        gangJoinPlayer( client, arg2 )
    end
end )

addEventHandler( "onPlayerWasted", root,
function ( totAmm, att, wpn, bodypart )
    local pla = source
    local dim = getElementDimension( pla )
    if dim == 0 and isElement( att ) and getElementType( att ) == "player" and att ~= pla then
        local gang1 = getElementData( pla, "gang" )
        local gang2 = getElementData( att, "gang" )
       
        local rewardMulti = math.min( 1, (getRealTime()["timestamp"]-getElementData( pla, "deathTs" ))/300 )
        local reward = 0
        local expReward = 0
        if gang2 ~= "police" then
            if gang1 ~= "police" then 
                addWanted( att, 4 )
                reward = math.floor( 8+gangTable[gang2]["owned"]*0.8 *rewardMulti )
                expReward = math.floor( 3+gangTable[gang2]["owned"]*0.5 *rewardMulti )
                reward = addMoney( att, reward )
                expReward = addExp( att, expReward )
                outputChatBox( "[Gang] Dostałeś "..reward.."$ i ".. expReward .."XP za zamordowanie: "..getPlayerName( pla ).."!", att, 25,235,25 )
                if getElementData( pla, "killReward" ) and getElementData( pla, "killReward" )>0 then
                    outputChatBox( "[Bounty] ".. getPlayerName( att ) .." zdobył nagrodę w postaci ".. getElementData( pla, "killReward" ) .."$ za głowę gracza ".. getPlayerName( pla ) ..".", root, 236-20,137-20,29-20 )
                    setElementData( pla, "killReward", 0, false )
                end
            else
                --outputChatBox( getElementData( att, "wanted" ).. " " .. rewardMulti )
                reward = math.floor( getElementData( att, "wanted" ) / 4 *rewardMulti ) + 1
                expReward = 2
                reward = addMoney( att, reward )
                expReward = addExp( att, expReward )
                outputChatBox( "[Gang] Dostałeś "..reward.."$ i ".. expReward .."XP za zamordowanie policjanta: "..getPlayerName( pla ).."!", att, 25,235,25 )
            end
        end
        outputChatBox( "[Gang] Killer: "..getPlayerName( att ).." (HP: "..getElementHealth( att )..", ARMOR:"..getPedArmor( att ).."). ".."Wynagrodzenie za zabicie ciebie wynosiło: "..reward.."$.", pla, 235,25,25 )
    end    
end )

setTimer(
function (  )
    for k,v in ipairs(getElementsByType( "player" )) do
        local gang = getElementData( v, "gang" )
        if getElementDimension( v ) == 0 and gang and gangTable[gang]["owned"] then
            setPedArmor( v, math.floor(math.min(getPedArmor( v )+1, gangTable[gang]["owned"]*5) ) +0.5 )
        end
    end
end, 10000, 0 )

function addBounty( pla, val )
    local bounty = getElementData( pla, "killReward" )
    if not bounty then bounty = 0 end
    if bounty + val < 0 then bounty = 0 val = 0 end
    setElementData( pla, "killReward", bounty+val, false )
    if val > 0 then
        outputChatBox( "[Bounty] Została postawiona nagroda w postaci ".. bounty+val .."$ za głowę gracza "..getPlayerName( pla ), root, 236,137,29 )
    elseif val <= 0 then
        if bounty+val == 0 then
            outputChatBox( "[Bounty] Nie ma już nagrody za zabicie "..getPlayerName( pla )..".", root, 236-20,137-20,29-20 )
        else
            outputChatBox( "[Bounty] Nagroda za zabicie ".. getPlayerName( pla ) .. " wynosi teraz ".. bounty+val .."$.", root, 236-20,137-20,29-20 )
        end
    end
end

addEvent( "onZombieWasted" )
addEventHandler( "onZombieWasted", root,
function ( att, wpn, body )
    if isElement( att ) and getElementType( att ) == "player" then
        addMoney( att, 2 )
        outputChatBox( "[Zday] EARNED TWO DOLLARS FOR BLOODSHED", att, 190,0,0 )
    end 
end )


local gangStashLootPointArray = {}
local gangStashUsedPoints = {}
function gangStashCreate(  )
    --outputChatBox( #gangStashLootPointArray )
    local point = gangStashLootPointArray[math.random( 1, #gangStashLootPointArray )]
    while gangStashUsedPoints[point] do
        point = gangStashLootPointArray[math.random( 1, #gangStashLootPointArray )]
    end
    gangStashUsedPoints[point] = true
    local x,y,z = getElementPosition( point )
    local obj = createObject( 1210, x,y,z+0.1, 90 )
    local col = createColSphere( x, y, z, 2 ) setElementParent( obj, col )
    addEventHandler( "onColShapeHit", col,
    function ( el, md )
        if md and isElement( el ) and getElementType( el ) == "player" and not isPedInVehicle( el ) then
            local reward = math.random( 30, math.random(30,200) )
            addMoney( el, reward )
            addExp( el, 16 )
            outputChatBox( "[Gang:Stashes] Znalazłeś walizkę z "..reward.."$ i 16XP.", el, 25,235,25 )
            destroyElement( col ) gangStashCreate()
            gangStashUsedPoints[point] = nil
            gangStashCreate()
        end
    end )
end

addEventHandler( "onResourceStart", resourceRoot,
function (  )
    gangStashLootPointArray = getElementsByType( "loot" )
    for i=1,20 do
        gangStashCreate()
    end
end )