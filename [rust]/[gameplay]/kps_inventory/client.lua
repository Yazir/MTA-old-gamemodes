-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local scx, scy = guiGetScreenSize( )

-- slots options
local slOrig = {x=scx*0.355,y=scy*0.45}
local slSize = scx*0.05
local slGap = scx*0.003

-- crafting options
local crOrig = {x=scx*0.7,y=scy*0.12}
local crSize = {w=scx*0.28,h=scy*0.06}
local crGap = scy*0.0025
local crbSize = crSize.w/10

-- equip bar options
local eqOrigX = slOrig.x-scx*0.335

-- status informations
local stOrig = {x=scx*0.1,y=scy*0.1}
local stSize = {w=scx*0.23,h=scy*0.057}
local stGap = scy*0.007

-- char text options
local ctOrig = {x=scx*0.01,y=scy*0.02}

-- item preview
local ipOrig = {x=slOrig.x,y=scy*0.05}
local ipSize = {w=(slSize+slGap)*6-slGap,h=scy*0.35}

-- storages
local storOrig = {x=scx*0.68,y=scy*0.45}
local storRows = 6
local storGap = stGap*0.2

local rightPane = "storage"

local slots = {}
local slotsData = {}
local contData = {}
local slotIndexedItems = {}
local selSlot
addEventHandler( "onClientResourceStart", resourceRoot,
function ()
	guiWnd = guiCreateWindow( 0, 0, scx, scy, "", false )
	guiWindowSetMovable( guiWnd, false )
	guiWindowSetSizable( guiWnd, false )
	guiSetVisible( guiWnd, false )
	guiSetAlpha( guiWnd, 0 )
	-- inv slots
	for i2=0,4 -1 do
		for i=0,6 -1 do
			local x = slOrig.x+(slSize+slGap)*i
			local y = slOrig.y+(slSize+slGap)*i2
			local but = guiCreateButton( x, y, slSize, slSize, "", false, guiWnd )

			guiSetButtonSlot( but )
		end
	end
	

	-- hotbar
	for i=0,6 -1 do
		local x = slOrig.x+(slSize+slGap)*i
		local y = slOrig.y+(slSize+slGap)*4+slGap*5
		local but = guiCreateButton( x, y, slSize, slSize, "", false, guiWnd )

		guiSetButtonSlot( but )
	end

	-- equip
	for i=0,6 -1 do
		local x = eqOrigX+(slSize+slGap)*i
		local y = slOrig.y+(slSize+slGap)*4+slGap*5
		local but = guiCreateButton( x, y, slSize, slSize, "", false, guiWnd )

		guiSetButtonSlot( but )
	end

	-- storage
	for i2=0,6 -1 do
		for i=0,6 -1 do
			local x = storOrig.x+(slSize+storGap)*i
			local y = storOrig.y+(slSize+storGap)*i2
			local but = guiCreateButton( x, y, slSize, slSize, "", false, guiWnd )

			guiSetButtonSlot( but )
		end
	end
end )

-- mouse hover, pokazanie w ekwipunku, przeladanie
local mhx, mhy
local ipItem
local heldItem
local sI = 1
function guiSetButtonSlot( but )
	local slot = sI
	slots[slot] = but 
	sI=sI+1

	addEventHandler( "onClientMouseEnter", but,
	function ()
		--outputChatBox( slot )
		if slot-36>storRows*6 then return end 
		mhx,mhy = guiGetPosition( but, false )
	end, false )
	addEventHandler( "onClientMouseLeave", but, 
	function ()
		mhx = nil
	end, false )
	addEventHandler( "onClientGUIClick", but, 
	function ( mbut )
		--outputChatBox( "test" )
		if source == but and mbut == "left" then
			if slot-36>storRows*6 then return end 
			--if gr=="stor" and slot>storRows*6 then return end 
			if heldItem then --and (heldItem.slot~=slot or heldItem.gr~=gr) then
				local cont1,cont2
				local slot1,slot2 = heldItem.slot, slot
				if heldItem.slot > 36 then cont1="stor" slot1 = heldItem.slot-36 else cont1="inv" end
				if slot > 36 then cont2 = "stor" slot2=slot-36 else cont2="inv" end
				transferItem( cont1, cont2, slot1, slot2 )
			end
			for _,v in ipairs( slotsData.items ) do
				if v.slot == slot then
					ipItem = v.item
					if heldItem then heldItem = nil
					else heldItem = v end
					break
				else
					ipItem = nil
				end
			end
		end
	end, false )
end

addEventHandler( "onClientClick", root,
function ( mbut, state, absx, absy )
	if absy < slOrig.y then
		if heldItem then
			triggerServerEvent( "onClientItemDrop", localPlayer, heldItem )
			ipItem = nil
			heldItem = nil
		end
	end
end )

addEventHandler( "onClientClick", root, 
function ( but )
	if but == "right" and heldItem then
		heldItem = nil
	end
end )

-- item transfer
function transferItem( cont1, cont2, from, to )
	--outputChatBox( from.." "..to )
	triggerServerEvent( "onServerInventoryTransfer", localPlayer, cont1, cont2, from, to ) --fromGr, toGr, amm )
end

local pedPreview, pedPreviewed
function showInventory( bool )
	if bool and not guiGetVisible( guiWnd ) then
		addEventHandler( "onClientRender", root, renderInventory )
		guiSetVisible( guiWnd, true )
		showCursor( true, true )

		-- ped preview
		if exports.object_preview then
			local x1, y1, z1 = getCameraMatrix()
			pedPreviewed = createPed( getElementModel( localPlayer ), x1, y1, z1 )
			pedPreview = exports.object_preview:createObjectPreview( pedPreviewed, 350, 5, 200, -0.13,0.-0.02,0.5,0.9, true, true, true )
		end
	else
		showCursor( false )
		if pedPreview then destroyElement( pedPreview ) end
		if pedPreviewed then destroyElement( pedPreviewed ) end
		if contData then triggerServerEvent( "onPlayerContClose", localPlayer ) contData = nil end
		removeEventHandler( "onClientRender", root, renderInventory )
		guiSetVisible( guiWnd, false )
	end
end

addCommandHandler( "inv", function () if not guiGetVisible( guiWnd ) and getElementData( localPlayer, "login" ) then triggerServerEvent( "onServerInventoryRequest", localPlayer ) else showInventory() end end )
bindKey( "tab", "down", function () executeCommandHandler( "inv" ) end )

addEvent( "onClientInventoryReceive", true )
addEventHandler( "onClientInventoryReceive", localPlayer,
function ( data, cont )
	slotsData = data
	heldItem = nil
	contData = cont
	if cont then
		rightPane = "storage"
		storRows = cont.rows
		for i,v in ipairs( cont.items ) do
			v.slot = 36+v.slot
			slotsData.items[#slotsData.items+1] = v
		end
	else
		rightPane = "crafting"
		storRows = 0
	end

	slotIndexedItems = {}
	for k,v in ipairs( slotsData.items ) do
		slotIndexedItems[v.slot] = v
	end

	if not guiGetVisible( guiWnd ) then
		showInventory( true )
	end
end )

-- kolizje z obiektem kontenera i obsłużenie go
local openCol
local contCols, colRenderHandled = {}
addEventHandler( "onClientColShapeHit", getElementsByType( "contColParent" )[1],
function ( el, md )
	if md and el == localPlayer then
		contCols[source] = true
		if not colRenderHandled then
			addEventHandler( "onClientRender", root, renderOpenInfo )
			colRenderHandled = true
		end
	end
end )

addEventHandler( "onClientColShapeLeave", getElementsByType( "contColParent" )[1],
function ( el, md )
	if md and el == localPlayer then
		contCols[source] = nil
		if colRenderHandled then
			removeEventHandler( "onClientRender", root, renderOpenInfo )
			colRenderHandled = false
		end
	end
end )

setTimer( 
function ()
	local colDist, col = 9999, nil
	local x,y,z = getElementPosition( localPlayer )
	local removeIndexes = {}
	for k,v in pairs( contCols ) do
		if isElement( k ) then
			local cx,cy,cz = getElementPosition( k )
			local dist = getDistanceBetweenPoints3D( x,y,z, cx,cy,cz )
			if colDist > dist then
				col, colDist = k, dist
			end
		else
			removeIndexes[#removeIndexes+1] = k
		end
	end
	for _,v in ipairs( removeIndexes ) do
		contCols[v] = nil
	end
	openCol = col
end, 50, 0 )

addEvent( "onClientReceiveSelectedItem", true )
addEventHandler( "onClientReceiveSelectedItem", localPlayer, 
function ( selItem, count )
	slotIndexedItems[selItem.slot] = selItem
	slotsData.count = count
end )

function renderOpenInfo()
	if not guiGetVisible( guiWnd ) and openCol then
		local x,y,z = getElementPosition( openCol )
		local x,y = getScreenFromWorldPosition( x, y, z+0.5 )
		if not x then return end
		dxDrawText( "Open\nPress [E]", x, y, nil, nil, nil, 2, "default-bold", "center", "center" )
	end
end

addCommandHandler( "open",
function ()
	if openCol and not guiGetVisible( guiWnd ) then
		triggerServerEvent( "onServerInventoryRequest", localPlayer, openCol )
	elseif guiGetVisible( guiWnd ) then
		executeCommandHandler( "inv" )
	end
end )
bindKey( "e", "down", "open" )


-- wybieranie przedmiotów
local sendRequestForType = {weapon=true}
function selectSlot( id )
	if selSlot == id+24 then selSlot=nil 
	else selSlot = id+24 end
	--if not slotIndexedItems[selSlot] then return end
	--if not sendRequestForType[slotIndexedItems[selSlot].item.type] then return end
	triggerServerEvent( "onServerInventorySelect", localPlayer, selSlot )
end
addCommandHandler( "slot1", function () selectSlot( 1 )  end )
addCommandHandler( "slot2", function () selectSlot( 2 )  end )
addCommandHandler( "slot3", function () selectSlot( 3 )  end )
addCommandHandler( "slot4", function () selectSlot( 4 )  end )
addCommandHandler( "slot5", function () selectSlot( 5 )  end )
addCommandHandler( "slot6", function () selectSlot( 6 )  end )
bindKey( "1", "down", "slot1" )
bindKey( "2", "down", "slot2" )
bindKey( "3", "down", "slot3" )
bindKey( "4", "down", "slot4" )
bindKey( "5", "down", "slot5" )
bindKey( "6", "down", "slot6" )

-- funkcja do renderowania pojedyńczego przedmiotu
function renderSingleItem( slot )
	local v = slotIndexedItems[slot]
	if not v then return end
	local x,y = guiGetPosition( slots[v.slot], false )
	local img = v.item.img
	dxDrawImage( x, y, slSize, slSize, img )
	if v.qual then
		dxDrawRectangle( x, y+slSize, slSize*0.05, -slSize*v.qual/1000, tocolor( 50, 200, 50, 200 ) )
	end
	if v.q and v.q>1 then
		dxDrawText( "x"..v.q, x+slSize-1, y+slSize-1, nil, nil, tocolor(200,200,200,200), 1.2, "default-bold", "right", "bottom" )
	end
	if v.item.type=="weapon" then
		local ammType = v.item.ammoType
		local ammCnt = slotsData.count[ammType]
		if not ammCnt then ammCnt = 0 end
		if ammCnt then
			local curAmm = v.clip
			dxDrawText( v.clip.."/"..ammCnt, x+slSize-1, y+slSize-1, nil, nil, tocolor(200,200,200,200), 1.2, "default-bold", "right", "bottom" )
		end
	end
end

-- render hotbar
addEventHandler( "onClientRender", root, 
function ()
	-- hotbar
	if not getElementData( localPlayer, "login" ) then return end
	for i=0,6 -1 do
		local r,g,b,a = 200,200,200,55
		if selSlot==i+25 then r,g,b,a = 125, 125, 225,120 end
		local x = slOrig.x+(slSize+slGap)*i
		local y = slOrig.y+(slSize+slGap)*4+slGap*5
		dxDrawRectangle( x, y, slSize, slSize, tocolor( r,g,b,a ) )
		renderSingleItem( 25+i )
	end
end, false, "low" )

function renderInventory( )
	dxDrawRectangle( 0, 0, scx, scy, tocolor( 100,100,100,150 ) )

	-- mouse hover show
	if mhx then
		dxDrawRectangle( mhx, mhy, slSize, slSize, tocolor( 200,200,200,55 ) )
	end

	-- inv slots
	dxDrawText( "INVENTORY", slOrig.x+2, slOrig.y, nil, nil, tocolor(0,0,0,200), 2, "default-bold", "left", "bottom" )
	dxDrawText( "INVENTORY", slOrig.x, slOrig.y-2, nil, nil, tocolor(255,255,255,200), 2, "default-bold", "left", "bottom" )
	for i=0,6 -1 do
		for i2=0,4 -1 do
			local x = slOrig.x+(slSize+slGap)*i
			local y = slOrig.y+(slSize+slGap)*i2
			dxDrawRectangle( x, y, slSize, slSize, tocolor( 200,200,200,55 ) )
		end
	end


	if rightPane == "storage" then
		-- storage
		dxDrawText( "STORAGE", storOrig.x+2, storOrig.y-(slSize+storGap)+slSize, nil, nil, tocolor(0,0,0,200), 2, "default-bold", "left", "bottom" )
		dxDrawText( "STORAGE", storOrig.x, storOrig.y-(slSize+storGap)+slSize, nil, nil, tocolor(255,255,255,200), 2, "default-bold", "left", "bottom" )
		for i=0,6 -1 do
			for i2=0,storRows -1 do
				local x = storOrig.x+(slSize+storGap)*i
				local y = storOrig.y+(slSize+storGap)*i2
				dxDrawRectangle( x, y, slSize, slSize, tocolor( 200,200,200,55 ) )
			end
		end
	elseif rightPane == "crafting" then
		-- crafting
		dxDrawText( "BLUEPRINTS", crOrig.x+crSize.w+2, crOrig.y-crbSize, nil, nil, tocolor(0,0,0,200), 2, "default-bold", "right", "bottom" )
		dxDrawText( "BLUEPRINTS", crOrig.x+crSize.w, crOrig.y-crbSize-2, nil, nil, tocolor(255,255,255,200), 2, "default-bold", "right", "bottom" )
		local color
		for i=0,10 -1 do
			if i%2 == 0 then color = tocolor( 200, 200, 200, 55 )
			else color = tocolor( 180, 180, 180, 55 ) end
			dxDrawRectangle( crOrig.x+crbSize*i, crOrig.y-crbSize-crGap, crbSize, crbSize, color )
		end

		for i=0,11 -1 do
			if i%2 == 0 then color = tocolor( 200, 200, 200, 55 )
			else color = tocolor( 180, 180, 180, 55 ) end
			dxDrawRectangle( crOrig.x, crOrig.y+(crSize.h+crGap)*i, crSize.w, crSize.h, color )
		end
	end

	-- equip
	for i=0,6 -1 do
		local x = eqOrigX+(slSize+slGap)*i
		local y = slOrig.y+(slSize+slGap)*4+slGap*5
		dxDrawRectangle( x, y, slSize, slSize, tocolor( 200,200,200,55 ) )
	end

	-- status text
	for i=0,11 -1 do
		if i%2 == 0 then color = tocolor( 200, 200, 200, 10 )
		else color = tocolor( 160, 160, 160, 10 ) end
		local x = stOrig.x
		local y = stOrig.y+(stSize.h+stGap)*i
		dxDrawRectangle( x, y, stSize.w, stSize.h, color )
	end

	-- item draw
	for _,v in ipairs( slotsData.items ) do
		--if not slots[v.slot] then return end
		--local x,y = guiGetPosition( slots[v.gr][v.slot], false )
		if (v.slot<25 or v.slot>30) then --25 do 30 to hotbar
			--if v.slot>36 then outputChatBox( "test" ) end
			renderSingleItem( v.slot )
		end
	end

	-- char
	local text = getPlayerName( localPlayer )
	dxDrawText( text, ctOrig.x+2, ctOrig.y+2, nil, nil, tocolor(0,0,0,200), 2, "default-bold", "left", "top" )
	dxDrawText( text, ctOrig.x, ctOrig.y, nil, nil, tocolor(255,255,255,200), 2, "default-bold", "left", "top" )

	-- ip item preview
	if ipItem then
		dxDrawRectangle( ipOrig.x, ipOrig.y, ipSize.w, ipSize.h, tocolor( 200,200,200,55 ) )
		local img = ipItem.img
		dxDrawImage( ipOrig.x+ipSize.w-(ipSize.h*0.2)*2, ipOrig.y+ipSize.h*0.05, ipSize.h*0.35, ipSize.h*0.35, img )
		dxDrawText( ipItem.name, ipOrig.x+ipSize.h*0.03+2, ipOrig.y+ipSize.h*0.03+2, nil, nil, tocolor(0,0,0,200), 1.9, "default-bold", "left", "top" )
		dxDrawText( ipItem.name, ipOrig.x+ipSize.h*0.03, ipOrig.y+ipSize.h*0.03, nil, nil, tocolor(255,255,255,200), 1.9, "default-bold", "left", "top" )

		dxDrawText( ipItem.desc, ipOrig.x+ipSize.h*0.04+1, ipOrig.y+ipSize.h*0.13+1, ipOrig.x+ipSize.w*0.7+1, 400, tocolor(0,0,0,200), 1.5, "default", "left", "top", true, true )
		dxDrawText( ipItem.desc, ipOrig.x+ipSize.h*0.04, ipOrig.y+ipSize.h*0.13, ipOrig.x+ipSize.w*0.7, 400, tocolor(255,255,255,200), 1.5, "default", "left", "top", true, true )
	end

	-- debug
	--for i,v in ipairs( slots ) do
	--	--if not slots[v.slot] then return end
	--	--local x,y = guiGetPosition( slots[v.gr][v.slot], false )
	--	local x,y = guiGetPosition( v, false )
	--	dxDrawText( i, x, y, nil, nil, nil, nil, "default", "left", "top" )
	--end

	-- hover item
	if heldItem then
		local mx,my = getCursorPosition(  )
		local item = heldItem.item
		dxDrawImage( mx*scx-slSize/1.1/2, my*scy-slSize/1.1/2, slSize/1.1, slSize/1.1, item.img, 0, 0, 0, tocolor( 150,150,150,200 ), true )
	end
end