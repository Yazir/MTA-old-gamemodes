local screenW,screenH = guiGetScreenSize(  )
local lvl = -1
local exp = -1
local maxExp = -1
local percent = -1

addEventHandler( "onClientRender", root,
function (  )
	if lvl ~= -1 then
		local h,m = getTime(  )
		local text = zeropad(h)..":"..zeropad(m).." | "..getPlayerMoney( localPlayer ).."$".." | LVL:".. lvl .. " XP:" .. exp .. "/" .. maxExp .. " (" .. percent .. "%)"
		dxDrawText( text, screenW*0.004+2, screenH*0.996+2, nil, nil, tocolor( 0,0,0, 150 ), 1.65, "default", "left", "bottom" )
		dxDrawText( text, screenW*0.004, screenH*0.996, nil, nil, tocolor( 225,225,225, 240 ), 1.65, "default", "left", "bottom" )
	end
end )


function updateExpText()
	setTimer( 
	function (  )
		lvl = getElementData( localPlayer, "lvl", false )
		exp = getElementData( localPlayer, "exp", false ) - expAtLvl(lvl-1)
		maxExp = expAtLvl(lvl) - expAtLvl(lvl-1)
		percent = math.floor(exp/maxExp * 100)
	end, 100, 0 )
end
addEvent( "onLogin", true )
addEventHandler( "onLogin", root, updateExpText)
addEventHandler( "onClientResourceStart", resourceRoot, function() if getElementData( localPlayer, "login" ) then updateExpText() end end )