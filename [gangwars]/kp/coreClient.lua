addEvent( "onClientLeaveLobby", true )
addEvent( "onClientJoinLobby", true )
addEvent( "trContractTaken", true )

local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot,
function()
    lobbys = {}

    inventoryWindow = guiCreateWindow((screenW - 291) / 2, (screenH - 468) / 2, 291, 468, "EKWIPUNEK", false)
    guiWindowSetSizable(inventoryWindow, false)
    itemGridlist = guiCreateGridList(10, 46, 261, 371, false, inventoryWindow)
    guiGridListAddColumn( itemGridlist, "Nazwa", 0.60)
    guiGridListAddColumn( itemGridlist, "Sloty", 0.30)
    useButton = guiCreateButton(19, 427, 90, 31, "Użyj", false, inventoryWindow)
    dropButton = guiCreateButton(119, 427, 90, 31, "Wyrzuć", false, inventoryWindow)
    dropAmmEdit = guiCreateEdit(219, 427, 52, 31, "1", false, inventoryWindow)
    slotsLabel = guiCreateLabel(10, 22, 266, 24, "Slots 10/20", false, inventoryWindow)
    guiLabelSetVerticalAlign(slotsLabel, "center")
    guiSetEnabled( dropAmmEdit, false )
    guiGridListSetSortingEnabled( itemGridlist, false )
    guiSetVisible( inventoryWindow, false ) 

    roomWindow = guiCreateWindow((screenW - 323) / 2, (screenH - 437) / 2, 323, 437, "POKOJE GIER", false)
    guiWindowSetSizable(roomWindow, false)
    roomGridlist = guiCreateGridList(10, 45, 205, 374, false, roomWindow)
    guiGridListAddColumn(roomGridlist, "Nazwa", 0.4)
    guiGridListAddColumn(roomGridlist, "Gracze", 0.25)
    --guiGridListAddColumn(roomGridlist, "Slots", 0.13)
    guiGridListAddColumn(roomGridlist, "Status", 0.25)
    joinRoomButton = guiCreateButton(225, 45, 86, 36, "Dołącz", false, roomWindow)
    leaveRoomButton = guiCreateButton(225, 86, 86, 36, "Wyjdź", false, roomWindow)
    spectateRoomButton = guiCreateButton(225, 127, 86, 36, "Obserwuj", false, roomWindow)
    guiSetEnabled ( leaveRoomButton, false )
    guiSetEnabled ( spectateRoomButton, false )
    guiGridListSetSortingEnabled( roomGridlist, false )
    guiSetVisible( roomWindow, false )

    statsWindow = guiCreateWindow((screenW - 295) / 2, (screenH - 448) / 2, 295, 448, "[KP] STATYSTYKI", false)
    guiWindowSetSizable(statsWindow, false)
    statsGridlist = guiCreateGridList(10, 32, 275, 406, false, statsWindow)
    guiGridListAddColumn(statsGridlist, "", 0.6)
    guiGridListAddColumn(statsGridlist, "", 0.3)
    guiGridListAddRow(statsGridlist)
    guiGridListSetSortingEnabled( statsGridlist, false )
    guiSetVisible( statsWindow, false )

    shopWindow = guiCreateWindow((screenW - 323) / 2, (screenH - 435) / 2, 323, 435, "[KP] SKLEP", false)
    guiWindowSetSizable(shopWindow, false)
    shopGridlist = guiCreateGridList(11, 63, 220, 362, false, shopWindow)
    guiGridListAddColumn(shopGridlist, "Nazwa", 0.7)
    guiGridListAddColumn(shopGridlist, "Koszt", 0.2)
    shopCombobox = guiCreateComboBox(10, 30, 221, 82, "Player skins", false, shopWindow)
    guiComboBoxAddItem(shopCombobox, "Weapon skins")
    guiComboBoxAddItem(shopCombobox, "Player skins")
    guiComboBoxAddItem(shopCombobox, "CJ clothes")
    buyButton = guiCreateButton(241, 63, 72, 35, "Kup", false, shopWindow)
    guiGridListSetSortingEnabled( shopGridlist, false )
    guiSetVisible( shopWindow, false )
    addEventHandler( "onClientGUIComboBoxAccepted", shopCombobox, function() refreshShop() end )
    guiComboBoxSetSelected( shopCombobox, 1 )


    create3dText( 1726.5092773438,-1854.9946289063,14.5, "Witamy na Królewskiej Piaskownicy!"                                 , 7, tocolor( 255, 50, 150, 240 ), 4)
    create3dText( 1719.0518798828,-1874.3089599609,13.8, "Tutaj dołączysz do pokoju gry [F2]"                                    , 18, tocolor( 255, 5, 5, 240 ), 2.5)
    create3dText( 1711.0402832031,-1874.5053710938,13.8, "Tu możesz kupić skiny (przebudowa) [F4]"                                      , 16, tocolor( 5, 255, 5, 240 ), 2.5)
    create3dText( 1711.1392822266,-1885.5639648438,13.8, "Tu możesz zobaczyć swoje statystyki (przebudowa) [F3]"                                      , 16, tocolor( 5, 255, 5, 240 ), 2.5)
    create3dText( 1719.0551757813,-1885.4940185547,13.8, "Tutaj możesz przeczytać nudne wprowadzenie [F1]"  , 18, tocolor( 50, 50, 255, 240 ), 1.7)

    local rooms = createObject( 1719.0518798828,-1874.3089599609,13.565570831299, 0,0,180)
    local roomsMarker = createMarker( 1719.0518798828,-1874.3089599609,13.565570831299, "corona", 2, 255, 50, 50, 200)
    setObjectScale( rooms, 3.5 )
    setElementCollisionsEnabled( rooms, false )
    addEventHandler( "onClientMarkerHit", roomsMarker, function(element) if element == localPlayer then roomsOpened = true guiSetVisible( roomWindow, true ) refreshRooms() showCursor(true ) end end)

    local info = createObject( 1239, 1719.0551757813,-1885.4940185547,13.565569877625, 0,0,205)
    local infoMarker = createMarker( 1719.0551757813,-1885.4940185547,13.565569877625, "corona", 1.5, 50, 50, 220, 0)

    setObjectScale( info, 3 )
    setElementCollisionsEnabled( info, false )
    addEventHandler( "onClientMarkerHit", infoMarker, function(element) if element == localPlayer then call(getResourceFromName("helpmanager"),"showHelp") end end)

    local stats = createObject( 1247, 1711.1392822266,-1885.5639648438,13.56750202179, 0,0,180)
    local statsMarker = createMarker( 1711.1392822266,-1885.5639648438,13.56750202179, "corona", 1.5, 50, 50, 220, 180)
    setObjectScale( stats, 3 )
    setElementCollisionsEnabled( stats, false )
    addEventHandler( "onClientMarkerHit", statsMarker, function(element) if element == localPlayer then statsOpened = true guiSetVisible( statsWindow, true ) refreshStats() showCursor(true ) end end)

    local shop = createObject( 1274, 1711.0402832031,-1874.5053710938,13.567526817322, 0,0,180)
    local shopMarker = createMarker( 1711.0402832031,-1874.5053710938,13.567526817322, "corona", 1.5, 50, 220, 50, 200)
    setObjectScale( shop, 3 )
    setElementCollisionsEnabled( shop, false )
    addEventHandler( "onClientMarkerHit", shopMarker, function(element) if element == localPlayer then shopOpened = true guiSetVisible( shopWindow, true ) refreshShop() showCursor(true ) end end)

    for i=1,1 do 
        outputChatBox("[KP] Wprowadzenie znajdziesz pod [F1]",220,50,50)
        outputChatBox("[KP] Wprowadzenie znajdziesz pod [F1]",50,220,50)
        outputChatBox("[KP] Wprowadzenie znajdziesz pod [F1]",50,50,220)
    end

    local snd=playSound3D("http://198.178.123.14:7346", 561.89495849609,-2315.5642089844,3.8515625, true)
    setSoundMaxDistance(snd, 100)
    setElementDimension(snd, 0)
    setElementInterior(snd, 0)
    setSoundVolume(snd, 0.5)
end)





--[[
function onClientColShapeHit( element, matchingDim )
    if element == localPlayer and matchingDim and isPedInVehicle( localPlayer ) == false then
        local iid = getElementData( source, "iid" )
        if iid then
            lastCol = source
            --outputChatBox( "Press X to pick up " .. itemTable[iid][1] .. " (w:" .. itemTable[iid][2] .. ")")
        end
    end
end
addEventHandler( "onClientColShapeHit", root, onClientColShapeHit )

function onClientColShapeLeave( element, matchingDim )
    if element == localPlayer and matchingDim then
        local iid = getElementData( source, "iid" )
        if iid then
            lastCol = nil
        end
    end
end
addEventHandler( "onClientColShapeLeave", root, onClientColShapeLeave )
]]

setTimer( 
function()
    local dim = getElementData( localPlayer, "dimension" ) 
    if dim and dim > 0 then
        guiSetEnabled ( leaveRoomButton, true ) 
    else
        guiSetEnabled ( leaveRoomButton, false )
    end

end, 50, 0 )

roomsOpened = false
bindKey("f2","down",
function( )
    if roomsOpened == true then
        roomsOpened = false
        guiSetVisible( roomWindow, false )
        showCursor(false )
    elseif getElementDimension(localPlayer) == 0 then
        if getElementData( localPlayer, "inSafezone" ) then
            roomsOpened = true
            guiSetVisible( roomWindow, true )
            refreshRooms()
            showCursor(true )
        else
            outputChatBox( "[Minigames] Musisz być w safe-zone!", 225,50,50 )
        end
    end
end)

statsOpened = false
bindKey("f3","down",
function( )
    if statsOpened == true then
        statsOpened = false
        guiSetVisible( statsWindow, false )
        showCursor(false )
    elseif getElementDimension(localPlayer) == 0 then
        if getElementData( localPlayer, "inSafezone" ) then
            statsOpened = true
            guiSetVisible( statsWindow, true )
            refreshStats()
            showCursor(true )
        else
            outputChatBox( "[Minigames] Musisz być w safe-zone!", 225,50,50 )
        end
    end
end )

shopOpened = false
bindKey("f4","down",
function( )
    if shopOpened == true then
        shopOpened = false
        guiSetVisible( shopWindow, false )
        showCursor(false )
    elseif getElementDimension(localPlayer) == 0 then
        if getElementData( localPlayer, "inSafezone" ) then
            shopOpened = true
            guiSetVisible( shopWindow, true )
            refreshShop()
            showCursor(true )
        else
            outputChatBox( "[Minigames] Musisz być w safe-zone!", 225,50,50 )
        end
    end
end)

bindKey("f2","down",
function()
    local dim = getElementDimension(localPlayer)
    if dim ~= 0 and not getElementData( localPlayer, "spectator" ) then
        if lobbys[dim]["leaveable"] then
            executeCommandHandler( "onPlayerSendRequestToLeaveRoom" )
        else
            outputChatBox("You can not leave that room!", 250,50,50)
        end
    end
end)

addCommandHandler( "onPlayerSendRequestToLeaveRoom", 
function ( )
    triggerServerEvent( "onPlayerSendRequestToLeaveRoom", localPlayer )
end )

addEventHandler( "onClientKey", root, 
function(button, por)
    if por == true then
        if not getElementData( localPlayer, "guiCloseBlock" ) or button == "escape" then
            if getElementData(localPlayer,"login") and not isChatBoxInputActive() then
                if button == "escape" or button == "w" or button == "s" or button == "a" or button == "d" then
                    closeAllWindows()
                end
                if button == "escape" then setElementData( localPlayer, "guiCloseBlock", false ) cancelEvent() end
            end
        end
    end
end )

function closeAllWindows()
    triggerEvent( "onCloseAllWindows", root )
    shopOpened = false guiSetVisible( shopWindow, false )
    statsOpened = false guiSetVisible( statsWindow, false )
    roomsOpened = false guiSetVisible( roomWindow, false )
    eqOpened = false guiSetVisible( inventoryWindow, false )
    trShowContracts( false )
    clanShowWindow( false )
    clanShowBizWindow( false )
    onSalonClickZamknij( )
    --closeShop( )
    nbShow( false )
    heistShowEnter( false )
    
    --call(getResourceFromName( "helpmanager" ),"hideHelp")
    showCursor( false )
end

function nonzero(value) if value == 0 then return 1 else return value end end
function refreshStats( )
    local stats = getElementData( localPlayer, "stats")
    guiGridListClear(statsGridlist)
    guiGridListAddRow( statsGridlist, "** * Główne * **")
    guiGridListAddRow( statsGridlist, "  " .. "Zabójstwa: ", stats["kills"])
    guiGridListAddRow( statsGridlist, "  " .. "Zgony: ", stats["deaths"])
    guiGridListAddRow( statsGridlist, "  " .. "K/D: ", stats["kills"] / nonzero(stats["deaths"],1))
    guiGridListAddRow( statsGridlist, "  " .. "Rundy w sumie: ", stats["played"])
    guiGridListAddRow( statsGridlist, "  " .. "Rundy wygrane: ", stats["won"])
    guiGridListAddRow( statsGridlist, "** * Bronie * **")
    for wid,name in pairs(widToName) do
        guiGridListAddRow( statsGridlist, "  " .. name, stats["wstats"][wid])
    end
end

function refreshShop( )
    guiGridListClear( shopGridlist )
    for key,item in ipairs(shopTable[guiComboBoxGetItemText( shopCombobox, guiComboBoxGetSelected( shopCombobox ) ) ] ) do
        local row = guiGridListAddRow( shopGridlist, item[1], item[2] )
        guiGridListSetItemData( shopGridlist, row, 1, key )
    end
end

function refreshRooms()
    lobbys = getElementData( root, "rooms", false )
    local selection = guiGridListGetSelectedItem( roomGridlist )
    guiGridListClear( roomGridlist )
    for index,room in ipairs(lobbys) do
        guiGridListInsertRowAfter( roomGridlist, index, room["name"], #room["players"].."/"..room["slots"], room["status"] )
        local row = guiGridListGetRowCount( roomGridlist )-1
        guiGridListSetItemData( roomGridlist, row, 1, index )
    end
    guiGridListSetSelectedItem( roomGridlist, selection, 1 )
end

--[[
function onClick( button, state )
    if getElementParent( source ) == inventoryWindow then
        if button == "left" then
            local row = guiGridListGetSelectedItem( itemGridlist )+1
            local data = guiGridListGetItemData( itemGridlist, row, 1)

            if source == dropButton then

                triggerServerEvent( "onInventoryAction", localPlayer, "drop", row)
                refreshEQ()
            elseif source == useButton then
                triggerServerEvent( "onInventoryAction", localPlayer, "use", row)
            end
        end
        outputChatBox(tostring(getElementParent( source )))
end]]

addEventHandler( "onClientGUIClick", root, 
function( button, state )
    if getElementParent( source ) == roomWindow then
        if button == "left" then
            if source == joinRoomButton then
                triggerServerEvent( "joinRoom", localPlayer, guiGridListGetItemData( roomGridlist, guiGridListGetSelectedItem( roomGridlist ), 1 ))
                refreshRooms()
            elseif source == leaveRoomButton then
                triggerServerEvent( "onPlayerSendRequestToLeaveRoom", localPlayer)
                refreshRooms()
            end
        end
    elseif getElementParent( source ) == shopWindow then
        if source == buyButton then
            if button == "left" then
                local price = tonumber(guiGridListGetItemText( shopGridlist, guiGridListGetSelectedItem( shopGridlist ), 2))
                local itemId = tonumber(guiGridListGetItemData( shopGridlist, guiGridListGetSelectedItem( shopGridlist ), 1 ))
                local category = guiComboBoxGetItemText( shopCombobox, guiComboBoxGetSelected( shopCombobox ) ) 
                if getPlayerMoney( localPlayer ) >= price then
                    triggerServerEvent( "buyItem", localPlayer, category, itemId)
                end
            end
        end
    end
end)

addEventHandler( "onClientElementDataChange", localPlayer, 
    function( data, oldVal)
        if data == "inventory" then
            refreshEQ()
        end
    end )

addEventHandler( "onClientElementDataChange", root, 
function( data, oldVal)
    if data == "rooms" then
        refreshRooms()
    end
end )

--[[
addCommandHandler( "devmode", 
    function (  )
        setDevelopmentMode( true )
    end)
]]



addEvent( "notif", true )
addEventHandler( "notif", root,
function( text, ntype )
    exports["notif"]:addNotification(text, ntype)
end )

addCommandHandler( "pos", 
function()
    local x,y,z = getElementPosition( localPlayer )
    outputChatBox(x..","..y..","..z)
end )

addEvent( "onGreenZoneActivated", true )
addEventHandler( "onGreenZoneActivated", resourceRoot, 
function()
    local sfx = playSound( "sfx/siren.mp3" )
    setSoundVolume( sfx, 0.3 )
end )



addEventHandler( "onClientJoinLobby", localPlayer, 
function (  )
    closeAllWindows()
end )

addEvent( "setPedCanBeKnockedOffBike",true )
addEventHandler( "setPedCanBeKnockedOffBike", resourceRoot,
function ( bool )
    setPedCanBeKnockedOffBike( localPlayer, bool )
end )

--[[addEventHandler( "onClientPlayerDamage", root,
function ( attacker )
    if isElement(attacker) and getElementType(attacker) == "player" and getElementData( attacker, "canFire") == false then
        if attacker ~= source then
            cancelEvent(  )
            if attacker == localPlayer then
                outputChatBox("Nie możesz tutaj zadawać obrażeń!", 250,50,50)
            end
        end
    end
end )]]

addEvent( "setHeliBladeCollisionsEnabled", true )
addEventHandler( "setHeliBladeCollisionsEnabled", root,
function ( bool )
    setHeliBladeCollisionsEnabled( source, bool )
end )

--[[
addEventHandler( "onClientPlayerWeaponSwitch", root,
function ( prevSlot, curSlot )
    triggerServerEvent( "sendWeaponSwitchInfo", localPlayer, prevSlot, curSlot )
    --outputChatBox("LOCAL CHANGE")
end )
]]

local threeDText = {}
setTimer( 
function (  )
    threeDText = {}
    for k,v in ipairs( getElementsByType( "3dText" ) ) do
        local px,py,pz = getElementPosition( getElementParent( v ) )
        if px and px~=0 then setElementPosition( v, px,py,pz ) end
        local ex, ey, ez = getElementPosition( v )
        local x, y, z = getElementPosition( localPlayer )
        if getElementDimension( v ) == getElementDimension( localPlayer ) and getDistanceBetweenPoints3D( ex, ey, ez, x, y, z ) < getElementData( v, "dist" ) then
            threeDText[#threeDText+1] = v
        end
    end
end, 250, 0 )

addEventHandler( "onClientRender", root, 
function (  )
    for k,v in ipairs( threeDText ) do
        local px,py,pz = getElementPosition( getElementParent( v ) )
        if px and px~=0 then setElementPosition( v, px,py,pz ) end
        
        local text,size,color = getElementData( v, "text" ), getElementData( v, "size" ), getElementData( v, "color" )
        if type( color ) == "table" then
            color = tocolor( color[1], color[2], color[3], color[4] )
        end
        local x,y,z = getElementPosition( v )
        local sx,sy = getScreenFromWorldPosition( x, y, z )
        if sx then
            dxDrawText( text, sx-1, sy-1, nil, nil, tocolor(0,0,0,255), size, "default-bold", "center", "center",false, false, false, false, false )
            dxDrawText( text, sx+1, sy-1, nil, nil, tocolor(0,0,0,255), size, "default-bold", "center", "center",false, false, false, false, false )
            dxDrawText( text, sx-1, sy+1, nil, nil, tocolor(0,0,0,255), size, "default-bold", "center", "center",false, false, false, false, false )
            dxDrawText( text, sx+1, sy+1, nil, nil, tocolor(0,0,0,255), size, "default-bold", "center", "center",false, false, false, false, false )
            dxDrawText( text, sx, sy, nil, nil, color, size, "default-bold", "center", "center",false, false, false, false, false )
        end
    end
end )


create3dText( 544.48077392578,-2330.5754394531,20.361949920654, "There are no easter eggs hidden on this island for sure ;)"        , 30, tocolor( 255, 50, 255, 240 ), 2)
--create3dText( 478.68862915039,-2362.5114746094,4.990930557251,  "Car shop (experimental)."                                          , 25, tocolor( 255, 50, 50, 240 ), 2)
--create3dText( 483.43313598633,-2299.7924804688,3.9529416561127, "You can have fun with random vehicles while you wait for a game!"  , 25, tocolor( 200, 200, 200, 240 ), 2)
create3dText( 535.31433105469,-2257.2788085938,5.2515640258789, "If you have a clan, you can go out to the city to buy businesses!"  , 25, tocolor( 255, 255, 5, 240 ), 2)

create3dText( 322.70251464844,-2343.56640625,1,                 "Mom look, no hands!"                                                 , 5, tocolor( 255, 50, 255, 240 ), 2)
create3dText( 409.91925048828,-2482.6486816406,9.2839412689209, "Ayy lmao"                                                             , 5, tocolor( 50, 255, 50, 240 ), 2)
create3dText( 465.63906860352,-2500.0153808594,57.264839172363, "There are no easter eggs here!"                                       , 15, tocolor( 50, 255, 255, 240 ), 2)

--create3dText( 2490.43359375,-1668.1817626953,16, "[F2] - Room list \n[F5] - Global inventory \n /clan create [name] \n\nYou are currently in the lobby.\nThere you can fight with other gangs and capture areas.", 30, tocolor( 25,255,25, 255 ), 3)
--create3dText( 1932.2708740234,-1141.4768066406,30, "[F2] - Room list \n[F5] - Global inventory \n /clan create [name] \n\nYou are currently in the lobby.\nThere you can fight with other gangs and capture areas.", 30, tocolor( 25,255,25, 255 ), 3)

setPlayerHudComponentVisible( "all", true )
--[[
addEventHandler( "onClientRender", root, 
function (  )
    local bx, by, bz = getPedBonePosition( localPlayer, 3 )
    local sx, sy = getScreenFromWorldPosition( bx, by, bz )
    if not sx then return end
    dxDrawText( math.floor( getElementHealth( localPlayer ) ).."%", sx+3 +160, sy+3, 0, 0, tocolor( 5, 5, 5, 255 ), 2, "default-bold", "left", "top", false, false, false, false, false, -6.01, 0, 0)
    dxDrawText( math.floor( getElementHealth( localPlayer ) ).."%", sx +160, sy, 0, 0, tocolor( 255, 255, 255, 255 ), 2, "default-bold", "left", "top", false, false, false, false, false, -6, 0, 0)
end )
]]

addEventHandler( "onClientVehicleEnter", root, 
function (  )
    local link = nil
    local vol = 75
    if getVehicleName( source ) == "Hermes" then link = "http://us1.internet-radio.com:8101/listen.pls"
    elseif getVehicleName( source ) == "Blista Compact" then link = "http://89.39.189.52:8000/listen.pls" 
    elseif getVehicleName( source ) == "Rhino" then link = "http://142.4.217.133:8386/listen.pls"
    --[[elseif getVehicleName( source ) == "Bike" then link = "http://airspectrum.cdnstream1.com:8018/1606_192.m3u" vol = 50]] end

    if link then
        local memeRI90s = playSound3D( link , -1503.7679443359,-387.15612792969,6.4402613639832, true )
        attachElements( memeRI90s, source )
        setSoundMaxDistance( memeRI90s, vol )
        setElementDimension( memeRI90s, getElementDimension( source ) )
        addEventHandler( "onClientVehicleEnter", source, function (  ) if isElement( memeRI90s ) then destroyElement( memeRI90s ) end end )
        addEventHandler( "onClientVehicleExit", source, function ( pla, seat ) if isElement( memeRI90s ) and seat == 0 then destroyElement( memeRI90s ) end end )
    end
end )
-- "http://192.99.62.212:9774/listen.pls" jap cos
-- "http://89.39.189.52:8000/listen.pls" euroszajs
-- "http://51.15.38.232:8254/stream.m3u" JAP SHIT
-- "http://167.114.210.232:8259/listen.pls" nerd vision
-- http://us1.internet-radio.com:8101/listen.pls
-- http://142.4.217.133:8386/listen.pls death metal

addEventHandler( "onClientDebugMessage", root, 
function ( mes, lvl, file, line )
    triggerServerEvent( "debugclient", localPlayer, file.."::"..line..": "..mes )
end )