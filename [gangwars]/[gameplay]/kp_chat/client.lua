-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local screenW, screenH = guiGetScreenSize()
local jezusTimer
local jezusHandled

addEvent( "onJezus", true )
addEventHandler( "onJezus", localPlayer,
function ()
	addEventHandler("onClientRender", root, renderJezus)
	jezusHandled = true
	if isTimer( jezusTimer ) then killTimer( jezusTimer ) jezusTiemr = nil end
	jezusTimer = setTimer(
	function ()
		removeEventHandler( "onClientRender", root, renderJezus )
		jezusHandled = false
	end, 1000*60*2, 1 )
end )

function renderJezus()
	dxDrawImage( -200, screenH-screenH*0.9, 750, 750, "jezus.png", 80, 0 )
end