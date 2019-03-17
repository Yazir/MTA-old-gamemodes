local screenW, screenH = guiGetScreenSize(  )
local timeTo = 0

addEventHandler( "onClientRender", root, 
function (  )
	local dim = getElementDimension( localPlayer )
	local x,y,z = getElementPosition( localPlayer )
	if dim>0 and lobbys and lobbys[dim] and lobbys[dim]["type"] == "br" then
		--for i=0,32 do
		--	dxDrawLine3D( lobbys[dim]["areapos"][1] + math.cos(360/32*i)*lobbys[dim]["deadzone"]*3000, lobbys[dim]["areapos"][2] + math.sin(360/32*i)*lobbys[dim]["deadzone"]*3000, z+20, lobbys[dim]["areapos"][1] + math.cos(360/32*i+1)*lobbys[dim]["deadzone"]*3000, lobbys[dim]["areapos"][2] + math.sin(360/32*i+1)*lobbys[dim]["deadzone"]*3000, z+20, tocolor(50,250,50,100), 20, false )
		--end
		local tim = timeTo-getRealTime()["timestamp"]
		if tim > 0 then
			local min = math.floor(tim/60)
			local sec = tim-(min*60)
			dxDrawRectangle( screenW/2-30, 0, 60, 18, tocolor(30,30,30) )
			dxDrawText( zeropad( min )..":"..zeropad( sec ), screenW/2, 0, nil, nil, tocolor(100,220,100), 1, "default", "center", "top" )
		end
	end
end )

addEvent( "brOnReceiveGasTime", true )
addEventHandler( "brOnReceiveGasTime", root,
function ( timToGz )
	timeTo = getRealTime()["timestamp"] + timToGz
end )

function zeropad( string )
	string = tostring( string )
	if string and string.len( string ) < 2 then
		string = "0"..string
	end
	return string
end

lastCol = nil

addEventHandler( "onClientRender", root, 
function( )
	local dim = getElementDimension( localPlayer )
    if lobbys and lobbys[dim] and lobbys[dim]["type"] == "br" then
	    --dxDrawRectangle( screenW * 0.3, screenH * 0.3, screenW * 0.1, screenH * 0.2, atocolor(50,50,100) )
	    --dxDrawRectangle( screenW * 0.3, screenH * 0.3, screenW * 0.1, screenH * 0.03, tocolor(70,70,100) )
	    if isElement(lastCol) and getElementData( lastCol, "iid") then
	        local text = "[x] Pick up "..itemTable[getElementData( lastCol, "iid")]["name"]
	        dxDrawRectangle( screenW * 0.5 - dxGetTextWidth( text, 3, "default-bold" )/2-10, screenH * 0.6, dxGetTextWidth( text, 3, "default-bold" )+20, 45 , tocolor(10,10,10,180) )
	        --dxDrawText( text, screenW * 0.5, screenH * 0.6, nil, nil, tocolor( 60,60,60,150 ), 3.1, "default-bold", "center", nil, nil, nil, nil, nil, nil, nil, nil, nil)
	        dxDrawText( text, screenW * 0.5, screenH * 0.6, nil, nil, tocolor( 220, 220, 220 ), 3, "default-bold", "center", nil, nil, nil, nil, nil, nil, nil, nil, nil)
	    end

	    if lootInTextRange then
			for key,loot in pairs(lootInTextRange) do
				if isElement( loot ) then
		 			local x,y,z = getElementPosition( loot )
				    local px,py,pz = getElementPosition(getLocalPlayer()) 
					--local x,y,z = px+1,py,pz
				    local distance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz ) 
					--	outputChatBox(key .. " " .. #closeItems)
				    if distance < 20 then
				        local sx,sy = getScreenFromWorldPosition ( x, y, z+0.05, 0.06 ) 
					    if sx then
					        dxDrawText ( itemTable[getElementData( loot, "iid")]["name"], sx, sy - 30, sx, sy - 30, tocolor(255,255,255,255-255*(distance/20)), math.min ( 0.7*(150/distance)*0.15,1), "default-bold", "center", "center", false, false, false )
				    	end
			    	end
			   	else
			    	lootInTextRange[key] = nil
			    end
			end
		end
	end
end )

lootInTextRange = {}
setTimer( 
function()
	local dim = getElementDimension( localPlayer )
	local x,y,z = getElementPosition( localPlayer )
	if dim>0 and lobbys and lobbys[dim] and lobbys[dim]["type"] == "br" then
		lootInTextRange = {}
	    local lootInRange = {}
	    for key,loot in ipairs(closeItems) do
	    	if isElement(loot) then
		    	local x,y,z = getElementPosition( localPlayer )
				local xl,yl,zl = getElementPosition( loot )
				if getDistanceBetweenPoints2D( x, y, xl, yl ) < 50 then
					lootInTextRange[#lootInTextRange+1] = loot
				end

		        if isElementWithinColShape( localPlayer, loot ) and isPedInVehicle( localPlayer ) == false then 
		            lootInRange[#lootInRange+1] = loot
		            --lastCol = loot
		        end
	    	end
	    end
	    if #lootInRange ~= 0 then
	        local closest = nil
	        local dist = 666
	        local x,y = getElementPosition( localPlayer )
	        for key,loot in ipairs(lootInRange) do
	            local x2,y2 = getElementPosition( loot )
	            local curDist = getDistanceBetweenPoints2D( x,y,x2,y2)
	            if dist > curDist then
	                closest = loot
	                dist = curDist
	            end
	        end
	        lastCol = closest
	        return
	    end
	    lastCol = nil
	 end
end, 50, 0 )

closeItems = {}
setTimer( 
function()
	local dim = getElementDimension( localPlayer )
	local x,y,z = getElementPosition( localPlayer )
	if dim>0 and lobbys and lobbys[dim] and lobbys[dim]["type"] == "br" then
	    local x,y = getElementPosition( localPlayer )
	    closeItems = {}
	    for key,loot in ipairs(getElementsByType( "colshape", root)) do
	        local x2,y2 = getElementPosition( loot )
	        if getElementData(loot, "loot") and getDistanceBetweenPoints2D( x,y, x2,y2 ) < 100 then 
	            closeItems[#closeItems+1] = loot
	        end
	    end
	end
end, 1000, 0 )

bindKey("x","down",
function ( key, keystate )
	local dim = getElementDimension( localPlayer )
	local x,y,z = getElementPosition( localPlayer )
	if lobbys[dim] and lobbys[dim]["type"] == "br" then
	    if isElement(lastCol) and isElementWithinColShape( localPlayer, lastCol ) and isPedInVehicle( localPlayer ) == false and isPedDead( localPlayer )==false then 
	        triggerServerEvent( "onPickupRequest", localPlayer, lastCol)
	        lastCol = nil
	    end
	end
end)

eqOpened = false
bindKey("h","down",
function ( )
    if eqOpened then
        eqOpened = false
        guiSetVisible( inventoryWindow, false )
        showCursor(false )
    elseif lobbys and lobbys[getElementDimension(localPlayer)] and lobbys[getElementDimension(localPlayer)]["type"]=="br" then
        eqOpened = true
        guiSetVisible( inventoryWindow, true )
        refreshEQ()
        showCursor(true )

    end
end)

function refreshEQ ( )
	local invSort = {}
    guiGridListClear( itemGridlist )
    local inventory = getElementData( localPlayer, "inventory")
    for k,v in ipairs(inventory) do
    	if not invSort[itemTable[v]["sort"]] then invSort[itemTable[v]["sort"]] = {} end
    	invSort[itemTable[v]["sort"]][#invSort[itemTable[v]["sort"]]+1] = {v,k}
    end
    table.sort( invSort )
    for k,v in pairs( invSort ) do
        local row = guiGridListAddRow( itemGridlist, k)
        guiGridListSetItemColor( itemGridlist, row, 1, 150, 150, 150, 200 )
        --guiSetFont( row, "default-bold" )
        --guiSetEnabled( row, false )
        for k2,v2 in ipairs( v ) do
        	local row2 = guiGridListAddRow( itemGridlist, "  "..itemTable[v2[1]]["name"], itemTable[v2[1]]["weight"] )
        	guiGridListSetItemData( itemGridlist, row2, 1, v2[2] )
        end
    end

    guiSetText( slotsLabel, "Slots: " .. getElementData( localPlayer, "slots") .. "/" .. getElementData( localPlayer, "maxSlots") )
    --[[for key,item in ipairs(inventory) do
        guiGridListInsertRowAfter( itemGridlist, guiGridListGetRowCount( itemGridlist ), itemTable[item]["name"], itemTable[item]["weight"])
        local row = guiGridListGetRowCount( itemGridlist )-1
        guiGridListSetItemData( itemGridlist, row, 1, item )
        --outputChatBox(item)
    end]]
end

addEventHandler( "onClientGUIClick", root, 
function( button, state )
    if getElementParent( source ) == inventoryWindow then
        local item = guiGridListGetItemData( itemGridlist, guiGridListGetSelectedItem( itemGridlist ), 1 )
        if button == "left" and item then
            if source == dropButton then
                triggerServerEvent( "onInventoryAction", localPlayer, "drop", item)
            elseif source == useButton then
                triggerServerEvent( "onInventoryAction", localPlayer, "use", item)
            end
        elseif button == "right" and item then
            triggerServerEvent( "onInventoryAction", localPlayer, "drop", item)
        end
	end
end)

addEventHandler( "onClientGUIDoubleClick", root, 
function( button, state )
    if getElementParent( source ) == inventoryWindow then
        if source == itemGridlist then
            local item = guiGridListGetItemData( itemGridlist, guiGridListGetSelectedItem( itemGridlist ), 1 )
            if button == "left" and item then
                triggerServerEvent( "onInventoryAction", localPlayer, "use", item)
            end
        end
    end 
end )

--[[
addEventHandler( "onClientPlayerWasted", localPlayer, 
function ( killer )
	setElementData( localPlayer, "spectating", true )
	addEventHandler( "onClientRender", root, 
	function (  )
		local x,y,z = getElementPosition( killer )
		local cx,cy,cz,clx,cly,clz = getCameraMatrix()
		setCameraMatrix(x, y, z+100, x, y, z )
	end )
end )
]]

--[[
addEventHandler( "onClientElementStreamIn", root,
function (  )
	if getElementType( source ) == "player" then
		givePedWeapon( source, 1, 9999)
		givePedWeapon( source, 2, 9999)
		givePedWeapon( source, 3, 9999)
		givePedWeapon( source, 4, 9999)
		givePedWeapon( source, 5, 9999)
		givePedWeapon( source, 6, 9999)
		givePedWeapon( source, 7, 9999)
		givePedWeapon( source, 8, 9999)
		givePedWeapon( source, 9, 9999)
		givePedWeapon( source, 22, 9999)
		givePedWeapon( source, 23, 9999)
		givePedWeapon( source, 24, 9999)
		givePedWeapon( source, 25, 9999)
		givePedWeapon( source, 26, 9999)
		givePedWeapon( source, 27, 9999)
		givePedWeapon( source, 28, 9999)
		givePedWeapon( source, 29, 9999)
		givePedWeapon( source, 32, 9999)
		givePedWeapon( source, 30, 9999)
		givePedWeapon( source, 31, 9999)
		givePedWeapon( source, 33, 9999)
		givePedWeapon( source, 34, 9999)
		givePedWeapon( source, 35, 9999)
		givePedWeapon( source, 36, 9999)
		givePedWeapon( source, 37, 9999)
		givePedWeapon( source, 38, 9999)
		givePedWeapon( source, 16, 9999)
		givePedWeapon( source, 17, 9999)
		givePedWeapon( source, 18, 9999)
		givePedWeapon( source, 39, 9999)
		givePedWeapon( source, 41, 9999)
		givePedWeapon( source, 42, 9999)
		givePedWeapon( source, 43, 9999)
		givePedWeapon( source, 10, 9999)
		givePedWeapon( source, 11, 9999)
		givePedWeapon( source, 12, 9999)
		givePedWeapon( source, 14, 9999)
		givePedWeapon( source, 15, 9999)
		givePedWeapon( source, 46, 9999)
		givePedWeapon( source, 40, 9999)
	end
end )]]
