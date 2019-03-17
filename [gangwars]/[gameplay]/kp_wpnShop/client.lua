-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local shoptype = nil

function initShop( )
	local screenW, screenH = guiGetScreenSize()
	weaponShop = guiCreateWindow((screenW - 618) / 2, (screenH - 485) / 2, 618, 485, "", false)
	guiWindowSetSizable(weaponShop, false)

	shopGridlist = guiCreateGridList(10, 29, 281, 446, false, weaponShop)
	guiGridListAddColumn(shopGridlist, "Weapon", 0.4)
	guiGridListAddColumn(shopGridlist, "Ammo", 0.15)
	guiGridListAddColumn(shopGridlist, "Level", 0.15)
	guiGridListAddColumn(shopGridlist, "Cost", 0.2)

	cashGridlist = guiCreateGridList(301, 29, 307, 372, false, weaponShop)
	guiGridListAddColumn(cashGridlist, "Weapon", 0.5)
	guiGridListAddColumn(cashGridlist, "Ammo", 0.2)
	guiGridListAddColumn(cashGridlist, "Cost", 0.2)

	costLabel = guiCreateLabel(301, 410, 169, 55, "Cost: x", false, weaponShop)
	guiSetFont(costLabel, "default-bold-small")
	guiLabelSetHorizontalAlign(costLabel, "center", false)
	guiLabelSetVerticalAlign(costLabel, "center")
	checkoutButton = guiCreateButton(480, 411, 128, 54, "Checkout", false, weaponShop)
	guiSetVisible( weaponShop, false )
end
addEventHandler( "onClientResourceStart", resourceRoot, initShop)

function openShop()
	guiGridListClear( shopGridlist )
	for i, v in ipairs(itemShopWeapons[shoptype]) do
		local row = guiGridListAddRow(shopGridlist, v["name"], tonumber(v["ammo"]),tonumber(v["level"]), tonumber(v["cost"]) )
		guiGridListSetItemData( shopGridlist, row, 1, i)
	end
	costCountTimer = setTimer( countCost, 50, 0 )
	guiSetVisible( weaponShop, true )
	showCursor( true, true )
end

function closeShop()
	if costCountTimer then killTimer( costCountTimer ) costCountTimer = nil end
	guiSetVisible( weaponShop, false )
	guiGridListClear( cashGridlist )
	showCursor( false )
end
addEvent( "onCloseAllWindows" )
addEventHandler( "onCloseAllWindows", root, closeShop )

function onClientGUIClick( but, stat)
	if guiGetVisible( weaponShop ) then
		if source == shopGridlist then
			local shopRow, shopColumn = guiGridListGetSelectedItem( shopGridlist )
			if shopRow ~= -1 then
				local i = guiGridListGetItemData( shopGridlist, shopRow, 1 )
				if itemShopWeapons[shoptype][i]["level"] <= getElementData( localPlayer, "lvl") then
				local row = guiGridListAddRow(cashGridlist, itemShopWeapons[shoptype][i]["name"], tonumber(itemShopWeapons[shoptype][i]["ammo"]), tonumber(itemShopWeapons[shoptype][i]["cost"]) )
					guiGridListSetItemData( cashGridlist, row, 1, i)
					countCost()
				else
					outputChatBox( "[Item Shop] Your level is not high enough.", 255,0,0 )
				end
			end
		elseif source == cashGridlist then
			local cashRow, cashColumn = guiGridListGetSelectedItem( cashGridlist )
			if cashRow ~= -1 then
				guiGridListRemoveRow( cashGridlist, cashRow )
				countCost()
			end
		elseif source == checkoutButton then
			local checkoutData = {}
			for row=0, guiGridListGetRowCount(cashGridlist)-1 do
				checkoutData[#checkoutData+1] = guiGridListGetItemData( cashGridlist, row, 1)
			end
			triggerServerEvent( "shopCheckout", root, checkoutData,shoptype)
		end
	end
end
addEventHandler( "onClientGUIClick", resourceRoot, onClientGUIClick)

function countCost( )
	local cost = 0
	local price = 0
	for row=0, guiGridListGetRowCount(cashGridlist)-1 do
		price = guiGridListGetItemText( cashGridlist, row, 3)
		cost = cost + price
	end
	if cost > getPlayerMoney( localPlayer ) or cost == 0 then
		guiSetEnabled( checkoutButton, false )
	else
		guiSetEnabled( checkoutButton, true)
	end

	guiSetText( costLabel, "Cost: " .. cost )
end

function onClientMarkerHit( element, md )
	local markerShopType = getElementData( source, "shop")
	if markerShopType and md and element == localPlayer then
		local gang = getElementData( localPlayer, "gang" )
		if gang ~= "civilian" then
			if markerShopType == "spawn" then
				shoptype = getElementData( source, "shop")
				openShop()
			elseif markerShopType == "vip" then
				if getElementData( localPlayer, "vipLevel" ) then
					shoptype = getElementData( source, "shop")
					openShop()
				else
					outputChatBox( "[Item Shop] You are not a patron.", 255,0,0 )
				end
			elseif markerShopType == "police" then
				if gang and gang == "police" then
					shoptype = getElementData( source, "shop")
					openShop()
				end
			end
		else
			outputChatBox( "[Item Shop] You must not be a civilian.", 255,0,0 )
		end
	end
end
addEventHandler( "onClientMarkerHit", resourceRoot, onClientMarkerHit )