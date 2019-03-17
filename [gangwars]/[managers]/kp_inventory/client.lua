-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

addEventHandler("onClientResourceStart", resourceRoot,
function()
	local screenW, screenH = guiGetScreenSize()
    invWindow = guiCreateWindow((screenW - 769) / 2, (screenH - 607) / 2, 769, 607, "[KP] INVENTORY", false)
    guiWindowSetSizable(invWindow, false)

    invScrollpane = guiCreateScrollPane(10, 33, 471, 564, false, invWindow)
    invDescLabel = guiCreateLabel(501, 156, 248, 431, "", false, invWindow)
    invPreviewImg = guiCreateStaticImage(501, 43, 103, 103, "itemimages/noicon.png", false, invWindow)
    guiSetVisible( invPreviewImg, false )
    invItemNameLabel = guiCreateLabel(609, 58, 135, 88, "Zaznacz przedmiot", false, invWindow)
    guiSetFont(invItemNameLabel, "default-bold-small")
    guiSetProperty(invItemNameLabel, "Font", "default-bold-small")
    invCategoryLabel = guiCreateLabel(609, 43, 135, 15, "", false, invWindow)
    guiSetFont(invCategoryLabel, "default-small")
    guiSetProperty(invCategoryLabel, "Font", "default-small")
    guiSetProperty(invCategoryLabel, "Tooltip", "tooltip text")
    guiLabelSetHorizontalAlign( invDescLabel, "left", true )
    guiLabelSetHorizontalAlign( invItemNameLabel, "left", true )

    invButtonDestroy = guiCreateButton(637, 543, 122, 52, "Zniszcz", false, invWindow)
    guiSetEnabled( invButtonDestroy, false )
    invButtonUse = guiCreateButton(491, 545, 122, 50, "Użyj", false, invWindow)
    guiSetVisible( invWindow, false )

    addEventHandler( "onClientGUIClick", invWindow,
    function ( but, state )
        if state == "up" and but == "left" then
            if invSelectedItem then
                if source == invButtonUse then
                    triggerServerEvent( "invItemAction", localPlayer, invSelectedItem )
                elseif source == invButtonDestroy then
                end
            end
        end
    end )
end)

invSelectedItem = nil
function invRefreshItems(  )
    local inv = getElementData( localPlayer, "globalInv" )
    local column,row = 0,0
    for key,element in ipairs(getElementChildren( invScrollpane )) do 
        destroyElement( element )
    end
    for key,item in pairs(inv) do
        local aItem = itemTable[key]
        if aItem then 
            --outputChatBox(key.." "..item)
            local img = guiCreateStaticImage(10 + column*58, 10 + row*58, 48, 48, "itemimages/"..aItem["image"], false, invScrollpane)
            guiCreateLabel(2, 0, 42, 42, item, false, img)
            setElementData( img, "item", key )
            column = column+1
            addEventHandler( "onClientGUIClick", img,
            function (  )
                guiStaticImageLoadImage( invPreviewImg, "itemimages/"..aItem["image"] )
                guiSetText( invItemNameLabel, aItem["name"] )
                guiSetText( invCategoryLabel, aItem["cat"] )
                guiSetText( invDescLabel, aItem["desc"] )
                guiSetVisible( invPreviewImg, true )
                invSelectedItem = key
            end )
            if column == 7 then column = 0 row = row + 1 end
        end
    end
end

function showInvWindow( bool )
	if bool and not guiGetVisible( invWindow ) then
		guiSetVisible( invWindow, true )
		invRefreshItems()
        showCursor(true, true )
    else
    	guiSetVisible( invWindow, false )
        showCursor( false )
    end
end
addEvent( "onCloseAllWindows", true )
addEventHandler( "onCloseAllWindows", root, showInvWindow )

addCommandHandler( "inv", showInvWindow )
bindKey( "f5", "down", "inv" )