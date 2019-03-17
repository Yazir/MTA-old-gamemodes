local screenW, screenH = guiGetScreenSize()
local bizData = nil

addEventHandler("onClientResourceStart", resourceRoot,
function()
    clWindow = guiCreateWindow(637, 323, 647, 435, "[KP] CLAN", false)
    guiWindowSetSizable(clWindow, false)

    clTabPanel = guiCreateTabPanel(10, 29, 627, 396, false, clWindow)

    clTabMembers = guiCreateTab("Członkowie", clTabPanel)

    clGridlistMembers = guiCreateGridList(10, 10, 468, 326, false, clTabMembers)
    guiGridListAddColumn(clGridlistMembers, "Konto", 0.2)
    guiGridListAddColumn(clGridlistMembers, "Data dołączenia", 0.2)
    guiGridListAddColumn(clGridlistMembers, "Ranga", 0.2)
    guiGridListAddColumn(clGridlistMembers, "Współucział", 0.2)
    guiGridListAddRow(clGridlistMembers)
    guiGridListSetItemText(clGridlistMembers, 0, 1, "", false, false)
    guiGridListSetItemText(clGridlistMembers, 0, 2, "", false, false)
    guiGridListSetItemText(clGridlistMembers, 0, 3, "", false, false)
    guiGridListSetItemText(clGridlistMembers, 0, 4, "", false, false)
    clButtonInvite = guiCreateButton(488, 20, 129, 40, "Zaproś", false, clTabMembers)
    clButtonKick = guiCreateButton(488, 70, 129, 40, "Wyrzuć", false, clTabMembers)
    clButtonPromote = guiCreateButton(488, 120, 129, 40, "Awansuj", false, clTabMembers)
    clButtonDemote = guiCreateButton(488, 170, 129, 40, "Degradacja", false, clTabMembers)
    clLabelMemInfo = guiCreateLabel(10, 336, 468, 36, "[name]([id])  Members:1/6", false, clTabMembers)
    guiLabelSetVerticalAlign(clLabelMemInfo, "center")

    clTabBusiness = guiCreateTab("Biznesy", clTabPanel)

    clLabelBizInfo = guiCreateLabel(488, 239, 129, 123, "Balance 0$\nOwned a/b\nTreaty 8h", false, clTabBusiness)
    clGridlistBiz = guiCreateGridList(10, 10, 468, 315, false, clTabBusiness)
    --clButtonDeposit = guiCreateButton(488, 70, 129, 40, "Deposit money", false, clTabBusiness)
    guiGridListAddColumn(clGridlistBiz, "Nazwa", 0.2)
    guiGridListAddColumn(clGridlistBiz, "Typ", 0.15)
    guiGridListAddColumn(clGridlistBiz, "Poziom", 0.1)
    guiGridListAddColumn(clGridlistBiz, "Koszt Ulepszenia", 0.15)
    guiGridListAddColumn(clGridlistBiz, "Value", 0.15)
    clButtonBizUpg = guiCreateButton(488, 20, 129, 40, "Ulepsz: cost", false, clTabBusiness)
    clButtonBizSell = guiCreateButton(488, 189, 129, 40, "Sprzedaj: price", false, clTabBusiness)
    clButtonDeposit = guiCreateButton(10, 330, 109, 32, "Wpłać $", false, clTabBusiness)
    clEditDeposit = guiCreateEdit(129, 330, 77, 32, "0", false, clTabBusiness)
    clButtonMarker = guiCreateButton(488, 70, 129, 40, "Zaznacz na mapie", false, clTabBusiness)
    clButtonBizUse = guiCreateButton(488, 120, 129, 40, "Użyj", false, clTabBusiness)

    clTabManagement = guiCreateTab("Zarządzanie", clTabPanel)

    clButtonDisband = guiCreateButton(488, 322, 129, 40, "Rozwiąż", false, clTabManagement)
    clLabelMan = guiCreateLabel(10, 10, 469, 352, "Informacje", false, clTabManagement)
    guiLabelSetHorizontalAlign(clLabelMan, "left", true)
    clButtonChangeColor = guiCreateButton(489, 20, 129, 40, "Zmień kolor", false, clTabManagement)


    clGridlistPlayers = guiCreateGridList(220, 100, 184, 275, false, clWindow)
    guiGridListAddColumn(clGridlistPlayers, "Nazwa", 0.9)


    guiSetVisible( clWindow, false )
    guiSetVisible( clGridlistPlayers, false )

    addEventHandler( "onClientGUIClick", clWindow,
    function ( but, por )
        guiSetVisible( clGridlistPlayers, false )
        if but == "left" then
            if source == clButtonInvite then
                guiSetVisible( clGridlistPlayers, true )
                guiGridListClear( clGridlistPlayers )
                local players = getElementsByType( "player" )
                for k,v in ipairs(players) do
                    if not getElementData( v, "clan" ) then
                        local row = guiGridListAddRow( clGridlistPlayers, getPlayerName( v ) )
                        guiGridListSetItemData( clGridlistPlayers, row, 1, v )
                    end
                end
                guiBringToFront( clGridlistPlayers )
            elseif source == clGridlistPlayers then
                local sel = guiGridListGetSelectedItem( clGridlistPlayers )
                if sel ~= -1 then
                    local invPla = guiGridListGetItemData( clGridlistPlayers, sel, 1 )
                    triggerServerEvent( "clanRequest", localPlayer, "invite", invPla )
                end
            elseif source == clButtonKick then
                local sel = guiGridListGetSelectedItem( clGridlistMembers )
                local data = guiGridListGetItemData( clGridlistMembers, sel, 1 )
                if sel ~= -1 and data then
                    triggerServerEvent( "clanRequest", localPlayer, "kick", data )
                end
            elseif source == clButtonPromote or source == clButtonDemote then
                local val = 1
                if source == clButtonDemote then val = -1 end
                local sel = guiGridListGetSelectedItem( clGridlistMembers )
                local data = guiGridListGetItemData( clGridlistMembers, sel, 1 )
                if sel ~= -1 and data then
                triggerServerEvent( "clanRequest", localPlayer, "promote", data, val )
                end
            elseif source == clButtonDeposit then
                local money = tonumber( guiGetText( clEditDeposit ) )
                if type(money) == "number" then
                    money = math.floor( money )
                    if money > 0 then
                        if getPlayerMoney( localPlayer ) >= money then
                            triggerServerEvent( "clanDeposit", localPlayer, money )
                        else
                            outputChatBox( "[Clan] Nie masz wystarczająco dużo pieniędzy!", 250, 50, 50 )
                        end
                    else
                        outputChatBox( "[Clan] Wartość musi być większa od zera!", 250, 50, 50 )
                    end
                else
                    outputChatBox( "[Clan] Pieniądze muszą być cyfrą!", 250, 50, 50 )
                end
            end
        end
    end )
end )

addCommandHandler( "clan",
function ( cmd, fnc, arg )
    if getElementData( localPlayer, "clan" ) and not fnc then
        clanShowWindow( )
    elseif fnc == nil then
        outputChatBox( "[Clan] Nie masz klanu. Dołącz lub stwórz własny klan poprzez komendę '/clan create [name]' .", 250, 50, 50 )
    elseif fnc == "create" then
        if not getElementData( localPlayer, "clan" ) then
            if arg then
                triggerServerEvent( "clanRequest", localPlayer, "create", arg )
            else
                outputChatBox( "[Clan] Musisz podać nazwę klanu.", 250, 50, 50 )
            end
        else
            outputChatBox( "[Clan] Już posiadasz klan!", 250, 50, 50 )
        end
    elseif fnc == "clear" then
        triggerServerEvent( "clanRequest", localPlayer, "clear")
    elseif fnc == "join" then
        if arg then
            triggerServerEvent( "clanRequest", localPlayer, "join", arg )   
        else
            outputChatBox( "[Clan] Musisz podać nazwę klanu!", 250, 50, 50 )
        end
    end
end )


addEvent( "clanReceiveData", true )
addEventHandler( "clanReceiveData", root,
function ( data, biz )
    if data then
        bizData = biz
        local members = fromJSON( data["members"] )
        guiSetText( clButtonBizUpg, "Upgrade" )
        guiGridListClear( clGridlistMembers )
        local memCount = 0
        for k,v in pairs(members) do
            memCount = memCount + 1
            local row = guiGridListAddRow( clGridlistMembers, k, "", v["rank"] )
            guiGridListSetItemData( clGridlistMembers, row, 1, k )
            guiGridListSetItemColor( clGridlistMembers, row, 1, 110,160,110 )
        end
        bizModf = fromJSON( data["bizModf"] )
        guiSetText( clLabelBizInfo, "Bilans "..data["balance"].."$\nBiznesy: ".. bizModf["count"] .. "/" .. clMaxBiz( bizModf ) )
        guiSetText( clLabelMemInfo, data["name"] .. ", Członkowie: "..memCount.."/"..clMaxMembers( data["bizModf"] ) )
        guiGridListClear( clGridlistBiz )
        if biz then
            for k,v in ipairs( biz ) do
                local row = guiGridListAddRow( clGridlistBiz, v["name"], v["bizType"], v["level"], bizCostAtLevel( v["level"] ), "-" )
                guiGridListSetItemData( clGridlistBiz, row, 1, v["id"] )
                guiGridListSetItemData( clGridlistBiz, row, 2, k )
                if v["ready"] then
                    guiGridListSetItemColor( clGridlistBiz, row, 1, 50, 255, 50 )
                else
                    guiGridListSetItemColor( clGridlistBiz, row, 1, 200, 50, 50 )
                    guiGridListSetItemText( clGridlistBiz, row, 1, "("..v["timer"].."min) ".. v["name"], false, false )
                end
            end
        end
    else
        outputChatBox( "[Clan] CL-Error-1 occured: Could not load clan data!", 250, 50, 50 )
    end
end )

function clanShowWindow( bool )
    if type(bool) ~= "boolean" then if guiGetVisible( clWindow ) then bool = false else bool = true end end
    if bool and getElementData(localPlayer, "clan") then
        triggerServerEvent( "clanRequest", localPlayer, "data" )
        guiSetVisible( clWindow, true )
        showCursor( true )
    else
        guiSetVisible( clWindow, false)
        showCursor( false )
    end
end
bindKey("f6", "down", clanShowWindow)

-- biz
addEvent( "onMapMark" )
addEventHandler( "onClientResourceStart", resourceRoot,
function (  )
    bizWindowBuy = guiCreateWindow((screenW - 292) / 2, (screenH - 126) / 2, 292, 126, "[KP] BUSINESS", false)

    bizLabelInfo = guiCreateLabel(10, 25, 266, 50, "Business name: bizname\nBusiness type: biztype\nClan owner: bizclan", false, bizWindowBuy)
    guiLabelSetHorizontalAlign(bizLabelInfo, "left", true)
    bizButtonBuy = guiCreateButton(184, 79, 98, 37, "Buy", false, bizWindowBuy)
    if getPlayerName( localPlayer ) == "Yazir" then
        bizButtonDelete = guiCreateButton(10, 79, 98, 37, "remove", false, bizWindowBuy)
        addEventHandler( "onClientGUIClick", bizButtonDelete, 
        function (  )
            triggerServerEvent( "bizRemove", localPlayer, openBizId )    
            clanShowBizWindow( false )
        end )
    end
    guiSetVisible( bizWindowBuy, false )
    addEventHandler( "onClientGUIClick", bizWindowBuy,
    function ( but )
        if but == "left" then
            if source == bizButtonBuy then
                triggerServerEvent( "buyBizRequest", localPlayer, bizData["id"] )
            end
        end
    end )

    addEventHandler( "onClientGUIClick", clWindow,
    function ( but )
        if but == "left" then
            local sel = guiGridListGetSelectedItem( clGridlistBiz )
            if source == clButtonBizUpg then
                if sel ~= -1 then
                    local id = guiGridListGetItemData( clGridlistBiz, sel, 1 )
                    if id then
                        triggerServerEvent( "clBizAction", localPlayer, "upgrade", id )
                    end
                else
                    outputChatBox( "[Clan] Musisz zaznaczyć biznes!", 250, 50, 50 )
                end
            elseif source == clGridlistBiz then
                if sel ~= -1 then
                    guiSetText( clButtonBizUpg, "Ulepszenie: " .. guiGridListGetItemText( clGridlistBiz, sel, 4 ) .. "$" )
                end
            elseif source == clButtonMarker then
                if sel ~= -1 then
                    triggerEvent( "onMapMark", localPlayer )
                    local data = bizData[guiGridListGetItemData( clGridlistBiz, sel, 2 )]
                    local pos = fromJSON( data["pos"] )
                    local blip = createBlip( pos[1], pos[2], pos[3], 41, 1, 0,0,0,255, 500, 99999 )
                    addEventHandler( "onMapMark", localPlayer, function (  ) if isElement( blip ) then destroyElement( blip ) end end )
                else
                    triggerEvent( "onMapMark", localPlayer )
                end
            elseif source == clButtonBizUse then
                local id = guiGridListGetItemData( clGridlistBiz, sel, 1 )
                if id then
                triggerServerEvent( "clBizAction", localPlayer, "use", id )
                end
            end
        end
    end )
end )

function clanShowBizWindow( data )
    local bool = false
    if type(data) == "table" then bool = true bizData = data end
    if bool then
        openBizId = data["id"]
        guiSetVisible( bizWindowBuy, true )
        showCursor( true )
        if not data["clan"] then data["clan"] = "Brak właściciela" guiSetEnabled( bizButtonBuy, false ) else guiSetEnabled( bizButtonBuy, true ) end 
        guiSetText( bizLabelInfo, "Nazwa: "..data["name"] .." ("..data["clan"]..")".."\nTyp:"..data["bizType"].."\nCost: "..clBizPrice( bizModf, data["level"] ) )
    else
        guiSetVisible( bizWindowBuy, false )
        showCursor( false )
    end
end
addEvent( "bizWindowOpen", true )
addEventHandler( "bizWindowOpen", localPlayer, clanShowBizWindow )
