-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.
local screenW, screenH = guiGetScreenSize()


addEventHandler("onClientResourceStart", resourceRoot,
function()
    wndStats = guiCreateWindow((screenW - 795) / 2, (screenH - 595) / 2, 795, 595, "[KP] STATS", false)
    guiWindowSetSizable(wndStats, false)

    tabpanStats = guiCreateTabPanel(10, 29, 775, 556, false, wndStats)

    guiSetVisible( wndStats, false )
end)

local tabs = {}
function refreshStats(  )
	for k,v in pairs( tabs ) do guiDeleteTab( v, tabpanStats ) tabs[k]=nil end
	local stats = getElementData( localPlayer, "kpStats" )
	if type( stats ) ~= "table" then return end
	for k,v in pairs( stats ) do
		local index = #tabs+1
		tabs[index] = guiCreateTab( k, tabpanStats )
		local i = 1
		for k2,v2 in pairs( v ) do
			guiCreateLabel( 10, 16*i, 600, 30, k2:gsub("^%l", k2.upper)..": "..v2, false, tabs[index] )
			i=i+1
		end
	end
end

function showStats( bool )
	if bool then
		guiSetVisible( wndStats, true )
		showCursor( true, true )
		refreshStats( )
	else
		guiSetVisible( wndStats, false )
		showCursor( false )
	end
end
addEvent( "onCloseAllWindows" )
addEventHandler( "onCloseAllWindows", root, showStats )

addCommandHandler( "sgui",
function (  )
	showStats( true )
end )