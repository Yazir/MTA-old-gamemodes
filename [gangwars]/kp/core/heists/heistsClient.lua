local screenW, screenH = guiGetScreenSize()
local heistCol = nil

addEventHandler("onClientResourceStart", resourceRoot,
function()
    heistWindowEnter = guiCreateWindow((screenW - 448) / 2, (screenH - 313) / 2, 448, 313, "[KP] Heist entrance", false)
    guiWindowSetSizable(heistWindowEnter, false)

    heistLabelEnter = guiCreateLabel(10, 26, 428, 156, "You are about to enter a heist.\nBefore entering though, make sure you have enough weapons (~500 ammo).\n\nGood luck.", false, heistWindowEnter)
    guiLabelSetVerticalAlign(heistLabelEnter, "center")
    heistButtonEnter = guiCreateButton(151, 242, 147, 61, "Dołącz do napadu", false, heistWindowEnter)    
    guiSetVisible( heistWindowEnter, false )

    addEventHandler( "onClientGUIClick", heistButtonEnter,
    function ( but )
    	if but == "left" then
    		triggerServerEvent( "heistRequest", localPlayer, "enter", heistCol )
    	end
    end )
end )

addEvent( "heistOnEnterShow", true )
addEventHandler( "heistOnEnterShow", localPlayer,
function ( col )
	heistCol = col
	heistShowEnter( true )
end )



function heistShowEnter( forced )
	if forced then
		guiSetVisible( heistWindowEnter, true )
		showCursor( true, true )
	else
		guiSetVisible( heistWindowEnter, false )
		showCursor( false )
	end
end