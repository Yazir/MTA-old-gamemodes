-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

addCommandHandler("pos",
function ()
 	outputChatBox(table.concat({getElementPosition(localPlayer)},", "))
end)

addEventHandler("onClientResourceStart", root,
function ()
	setFarClipDistance( 1250 )
	setFogDistance( 250 )
end)