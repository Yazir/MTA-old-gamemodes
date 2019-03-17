-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.
local screenW, screenH = guiGetScreenSize()

addEventHandler( "onClientResourceStart", resourceRoot,
function ()
	wndCases = guiCreateWindow((screenW - 805) / 2, (screenH - 661) / 2, 805, 661, "[KP] Otwieranie skrzynek", false)
	guiWindowSetSizable(wndCases, false)

	imgPoint = guiCreateLabel( 20, 28, 412, 412, "test", false, wndCases ) --412x412
	labItem = guiCreateLabel(10, 450, 785, 96, "Losowany item", false, wndCases)
	guiSetFont(labItem, "sa-gothic")
	guiLabelSetHorizontalAlign(labItem, "center", false)
	guiLabelSetVerticalAlign(labItem, "center")
	butLos = guiCreateButton(10, 599, 157, 52, "Losuj przedmiot", false, wndCases)
	labDost = guiCreateLabel(9, 549, 158, 40, "Dostępnych skrzynek: 10", false, wndCases)
	guiLabelSetHorizontalAlign(labDost, "center", false)
	guiLabelSetVerticalAlign(labDost, "center")
	butDodaj = guiCreateButton(324, 556, 157, 52, "Dodaj do ekwipunku", false, wndCases)
	guiSetVisible( wndCases, false )
	--if getPlayerName( localPlayer ) == "Yazir" then showWheelWnd( true )  end
end )

function showWheelWnd( bool )
	if bool and not guiGetVisible( wndCases ) then
		guiSetVisible( wndCases, true )
		
		spinWheel( 1 )
		addEventHandler( "onClientPreRender", root, renderWheel )
	else
		guiSetVisible( wndCases, false )
		removeEventHandler( "onClientPreRender", root, renderWheel )
	end
end

addCommandHandler( "scase", showWheelWnd, true )
local itemArr = {"uno","dos","tres","quatro","funf","sechs","sieben","acht"}
local angle = 0
local rSpd = 0
local rDec = 25
function renderWheel( td )
	td = td/1000
	local sx,sy = guiGetPosition( wndCases, false )
	sx,sy = sx+197, sy+28
	angle, rSpd = angle+rSpd*td, math.max(0, rSpd-rDec*td)
	local iIndex = math.floor((360-angle)/45)+1
	guiSetText( imgPoint, angle.."\n"..rSpd.."\n"..iIndex )
	if itemArr[iIndex] then guiSetText( labItem, itemArr[iIndex] ) end
	while angle>360 do angle = angle-360 end
	dxDrawImage( sx, sy, 412, 412, "spinning-wheel.png", angle+180, 0, 0, nil, true )
	dxDrawImage( sx+206-16, sy+380-16, 32, 32, "cypel.png", 0, 0, 0, nil, true )
end

local spins = 16
function spinWheel( index )
	angle = (index-1)*45
	rSpd = 25 * (math.sqrt( 28.8*spins )-math.sqrt( 28.8*spins )/650)
end