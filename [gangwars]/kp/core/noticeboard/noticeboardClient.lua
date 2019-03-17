local screenW, screenH = guiGetScreenSize()
local nbGangData = {}
local nbBlip = false

addEventHandler("onClientResourceStart", resourceRoot,
    function()
    nbWindowBoard = guiCreateWindow((screenW - 719) / 2, (screenH - 559) / 2, 719, 559, "KP notice board", false)
    guiWindowSetSizable(nbWindowBoard, false)

    nbGridlistBoards = guiCreateGridList(10, 29, 699, 357, false, nbWindowBoard)
    guiGridListAddColumn(nbGridlistBoards, "Name", 0.2)
    guiGridListAddColumn(nbGridlistBoards, "Type", 0.2)
    guiGridListAddColumn(nbGridlistBoards, "Creator", 0.2)
    guiGridListAddColumn(nbGridlistBoards, "Level", 0.2)
    nbLabelInfo = guiCreateLabel(361, 396, 348, 153, "Textinfo", false, nbWindowBoard)
    guiLabelSetHorizontalAlign(nbLabelInfo, "left", true)
    nbButtonTrack = guiCreateButton(10, 406, 109, 49, "Track", false, nbWindowBoard)
    nbButtonRefresh = guiCreateButton(10, 490, 109, 49, "Refresh", false, nbWindowBoard)

    guiSetVisible( nbWindowBoard, false )

    addEventHandler( "onClientGUIClick", nbWindowBoard,
    function ( but )
        if but == "left" then
            local row = guiGridListGetSelectedItem( nbGridlistBoards )
            local index = guiGridListGetItemData( nbGridlistBoards, row, 1 )
            local uid = guiGridListGetItemData( nbGridlistBoards, row, 2 )
            if source == nbButtonTrack and index then
                if tonumber( guiGridListGetItemText( nbGridlistBoards, row, 4 ) ) <= getElementData( localPlayer, "lvl" ) then
                    --triggerServerEvent( "nbRequest", localPlayer, "track", index, uid )
                    local pos = nbGangData[index]["pos"]
                    --outputChatBox( pos[1] .. ", " .. pos[2] .. ", " .. pos[3] )
                    if isElement( nbBlip ) then destroyElement( nbBlip ) end
                    nbBlip = createBlip( pos[1], pos[2], pos[3], 41, 1, 255, 0,0 , 125, 0, 999999 )
                    local marker = createMarker( pos[1], pos[2], pos[3], "checkpoint", 2, 0,0,255, 100, root )
                    setElementParent( marker, nbBlip )
                    outputChatBox( "[NB] Aktywność zaznaczona na mapie, użyj '/nbblip' aby usunąć ten znacznik..", 225,225,25 )
                else
                    outputChatBox( "[NB] Twój poziom nie jest wystarczająco wysoki.", 225,25,25 )
                end
            end
        end
    end )
end )

addCommandHandler( "nbblip",
function (  )
    if isElement( nbBlip ) then
        destroyElement( nbBlip )
        outputChatBox( "[NB] Znacznik usunięty.", 25,225,25 )
    else
        outputChatBox( "[NB] Nie masz żanego znacznika na mapie.", 225,25,25 )
    end
end )

addEventHandler( "onClientColShapeHit", resourceRoot,
function ( el, md )
    local gang = getElementData( localPlayer, "gang" )
    if el == localPlayer and md then
        if getElementData( source, "noticeboard" ) then
            if getElementData( source, "gang" ) == gang then
                triggerServerEvent( "nbRequest", localPlayer, "getData" )
            else
                outputChatBox( "[NB] Ta tablica nie należy do twojej organizacji!", 225,25,25 )
            end
        end
    end
end )

addEvent( "nbOnGetData", true )
addEventHandler( "nbOnGetData", localPlayer, 
function ( data )
    if data then
        nbGangData = data
        guiGridListClear( nbGridlistBoards )
        for i,v in ipairs( nbGangData ) do
            local row = guiGridListAddRow( nbGridlistBoards, v["name"], v["type"], v["creator"], v["level"] )
            guiGridListSetItemData( nbGridlistBoards, row, 1, i)
            guiGridListSetItemData( nbGridlistBoards, row, 2, v["uid"])
            if v["level"] > getElementData( localPlayer, "lvl" ) then
                guiGridListSetItemColor( nbGridlistBoards, row, 4, 255, 50, 50 )
            end
        end
        nbShow( true )
    end
end )

function nbShow( forced )
    if not forced then
        guiSetVisible( nbWindowBoard, false )
        showCursor( false )
    else
        guiSetVisible( nbWindowBoard, true )
        showCursor( true, true )
    end
end