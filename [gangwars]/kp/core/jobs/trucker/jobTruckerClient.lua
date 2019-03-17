local screenW, screenH = guiGetScreenSize()
local mx,my,mz = 2183.8078613281,-2279.7033691406,13.546875
local trTruckModels = {[403]=true,[515]=true,[514]=true}
local trContractsData = data


addEventHandler("onClientResourceStart", resourceRoot,
function()
    trWindowContract = guiCreateWindow((screenW - 608) / 2, (screenH - 502) / 2, 608, 502, "[KP] Truck Contracts", false)
    guiWindowSetSizable(trWindowContract, false)

    trGridlistContract = guiCreateGridList(10, 45, 468, 447, false, trWindowContract)
    --guiGridListAddColumn(trGridlistContract, "#", 0.05)
    guiGridListAddColumn(trGridlistContract, "Load", 0.23)
    guiGridListAddColumn(trGridlistContract, "Cost", 0.1)
    guiGridListAddColumn(trGridlistContract, "Payment", 0.15)
    guiGridListAddColumn(trGridlistContract, "Experience", 0.15)
    guiGridListAddColumn(trGridlistContract, "Distance", 0.15)
    guiGridListAddColumn(trGridlistContract, "Illegal", 0.15)
    trButtonAccept = guiCreateButton(488, 45, 110, 50, "Accept contract", false, trWindowContract)
    trButtonCancel = guiCreateButton(488, 105, 110, 50, "Decline contract", false, trWindowContract)
    trButtonBonus = guiCreateButton(490, 165, 108, 50, "Claim bonus", false, trWindowContract)    
    guiSetVisible( trWindowContract, false )
    addEventHandler( "onClientGUIClick", trWindowContract,
    function ( )
        local row = guiGridListGetSelectedItem( trGridlistContract )
        if row ~= -1 then
            if source == trButtonAccept and not getElementData( localPlayer, "trTrucking" ) then
                triggerServerEvent( "trContractsClicked", localPlayer, "accept", guiGridListGetItemData( trGridlistContract, row, 1 ) )
                trShowContracts(true)
            end
        end
        if source == trButtonBonus and getElementData( localPlayer, "trBonus") then
            triggerServerEvent( "trContractsClicked", localPlayer, "bonus" )
            guiSetEnabled( trButtonBonus, false )
        end
        if source == trButtonCancel and getElementData( localPlayer, "trTrucking" ) then
            triggerServerEvent( "trContractsClicked", localPlayer, "cancel" )
            guiSetEnabled( trButtonCancel, false )
            guiSetEnabled( trButtonAccept, true )
        end
    end )

    addEventHandler( "onClientMarkerHit", root,
    function ( el, md )
        local dim = getElementDimension( localPlayer )
        if md and el == localPlayer and dim == 0 then
            local data = getElementData( source, "trContractData" )
            if data then
                trContractsData = data
                if getElementData( localPlayer, "job" ) == "trucker" then
                    local veh = getPedOccupiedVehicle( localPlayer )
                    if veh and trTruckModels[getElementModel( veh )] and getPedOccupiedVehicleSeat( localPlayer ) == 0 then
                        trShowContracts( true )
                        if isPedInVehicle( el ) then
                            setElementVelocity( getPedOccupiedVehicle( el ), 0, 0, 0 )
                        end
                    else
                        triggerEvent( "notif", resourceRoot, "You need a truck that can take a trailer.", "error")
                    end
                else
                    triggerEvent( "notif", resourceRoot, "You are not a trucker!", "error")
                end
            end
        end
    end )
end )

trContractOpened = false
function trShowContracts( bool )
    if bool then
        trContractOpened = true
        guiSetVisible( trWindowContract, true )
        showCursor( true )
        trRefreshContracts( )
        if getElementData( localPlayer, "trBonus") then
            guiSetEnabled( trButtonBonus, true )
            triggerEvent( "notif", resourceRoot, "Take your bonus payment or else you will lose it.", "warning")
           -- outputChatBox("asd")
        else
            guiSetEnabled( trButtonBonus, false )
        end

        if getElementData( localPlayer, "trTrucking" ) then
            guiSetEnabled( trButtonAccept, false )
            guiSetEnabled( trButtonCancel, true )
        else
            guiSetEnabled( trButtonAccept, true )
            guiSetEnabled( trButtonCancel, false )
        end
    else
        trContractOpened = false
        guiSetVisible( trWindowContract, false )
        showCursor( false )
    end
end
addEventHandler( "trContractTaken", localPlayer, function() trShowContracts(false) end )

function trRefreshContracts( )
    guiGridListClear( trGridlistContract )
    local x,y,z = getElementPosition( localPlayer )
    for key,contract in pairs( trContractsData ) do
        local row = guiGridListAddRow( trGridlistContract, contract["name"], contract["cost"], contract["money"].." (+"..contract["bonusMoney"]..")", contract["xp"].." (+"..contract["bonusXP"]..")", contract["dist"], boolReturn(contract["illegal"],"yes","no") )
        guiGridListSetItemData( trGridlistContract, row, 1, contract["key"] )
        guiGridListSetItemColor( trGridlistContract, row, 2, 200, 50, 50 )
        guiGridListSetItemColor( trGridlistContract, row, 3, 50, 200, 50 )
        guiGridListSetItemColor( trGridlistContract, row, 4, 125, 125, 255 )
       -- outputChatBox(_)
    end
end

function boolReturn( val, yes, no )
    if val then
        return yes
    else
        return no
    end
end

