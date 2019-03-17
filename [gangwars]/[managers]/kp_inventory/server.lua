-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

function takeItemGlobalInv(pla, item)
	local inv = getElementData(pla,"globalInv")
	table.remove(inv,item)
	setElementData( pla, "globalInv", inv )
end

function giveItemGlobalInv(pla, item)
	if pla then
		local inv = getElementData( pla,"globalInv" )
		if not inv[item] then inv[item] = 0 end
		inv[item] = inv[item]+1
		setElementData( pla, "globalInv", inv )
		writeLog("inventory", "Player: " .. getPlayerName( pla ) .. "(" .. getAccountName( getPlayerAccount( pla ) ) .. " , " .. getAccountSerial( getPlayerAccount( pla ) ) .. ")" .. " has been given Item:" .. item .. "(" .. inv[item] .. ")" )
	end
end

--[[
addCommandHandler( "item", 
function ( pla, cmd, arg )
	if not getElementData(pla,"globalInv") then setElementData(pla,"globalInv",{}) end
	giveItemGlobalInv( pla, arg)
end )

addCommandHandler( "clear", 
function ( pla, cmd, arg )
	setElementData(pla,"globalInv",{})
end )
]]

addEventHandler( "invItemAction", root,
function ( item )
	local inv = getElementData( source, "globalInv" )
	if inv and inv[item] then
		local aItem = itemTable[item]
		if inv[item] - aItem["destroy"] >= 0 then
			inv[item] = inv[item] - aItem["destroy"]
			if aItem["use"] == "skin" then
				exports.kp:saveWeapons( source )
				setElementData( source, "skin", aItem["skinID"] )
				setElementModel( source, aItem["skinID"] )
				exports.kp:loadWeapons( source )
			end
		exports.kp:writeLog("inventory", "Player: " .. getPlayerName( source ) .. "(" .. getAccountName( getPlayerAccount( source ) ) .. " , " .. getAccountSerial( getPlayerAccount( source ) ) .. ")" .. " used " .. item)
		end
		setElementData( source, "globalInv", inv )
	end
end )

addCommandHandler( "giveitem",
function ( pla, cmd, arg1, arg2 )
	local forPla = getPlayerFromName( arg1 )
	if forPla and arg2 then
		if not getElementData(forPla,"globalInv") then setElementData(forPla,"globalInv",{}) end
		giveItemGlobalInv( forPla, arg2)
		outputChatBox( "Item given to " .. arg1, pla )
	end
end, true )

outputDebugString( "[KP] kp_inventory (server.lua) start" )