-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.


conts = {}
local oCon = {}
local contColParent = createElement( "contColParent" )

addEvent( "onServerInventoryRequest", true )
addEventHandler( "onServerInventoryRequest", root, 
function ( stor )
	if stor and isElement( stor ) and getElementType( stor ) == "colshape" and isElementWithinColShape( client, stor ) then oCon[client]=conts[stor]
	else oCon[client]=nil end
	local peq = conts[client]

	--[[for iName,toRemove in pairs( peq.remove ) do
			local setForRemoval = {}
			for iIndex,v2 in ipairs( peq.items ) do
				if v2.item.key == iName then
					if v2.q >= toRemove then
						peq.items[iIndex].q = v2.q-toRemove
						outputChatBox( "removed "..iName.." at "..iIndex.." in q of "..toRemove.."  now "..v2.q-toRemove )
						if peq.items[iIndex].q <= 0 then
							setForRemoval[#setForRemoval+1] = iIndex
						end
						break
					else
						peq.items[iIndex].q = v2.q-v2.q
						if peq.items[iIndex].q <= 0 then
							setForRemoval[#setForRemoval+1] = iIndex
						end
					end
				else
				end
			end
			table.sort( setForRemoval, function(a,b) return a<b end )
			for _,v in ipairs( setForRemoval ) do
				table.remove( peq.items, v )
			end
			peq.remove = {}
			countItems( peq )
		end]]

	local purge
	for _,_ in pairs( peq.remove ) do
		purge = true
		break
	end
	if purge then
		local trialByExecution = {}
		for k,v in ipairs( peq.items ) do
			local remSum = peq.remove[v.item.key]
			if remSum then
				local ammRemove = math.min( remSum, v.q )
				peq.items[k].q = v.q - ammRemove
				peq.remove[v.item.key] = remSum - ammRemove
				if peq.items[k].q == 0 then
					trialByExecution[#trialByExecution+1] = k
				end
				if peq.remove[v.item.key]<=0 then
					peq.remove[v.item.key] = nil
				end
			end
		end
		peq.remove = {}
		table.sort( trialByExecution, function(a,b) return a>b end )
		for _,v in ipairs( trialByExecution ) do
			table.remove( peq.items, v )
		end
		--countItems( peq )
		--outputChatBox( "test" )
	end

	triggerClientEvent( client, "onClientInventoryReceive", client, peq, oCon[client] )
end )

function giveItem( el, data )
	local cont
	if isElement( el ) then
		if not conts[el] then conts[el] = { } end
		cont = conts[el]
	else
		cont = el
	end

	-- wyszukiwanie slota
	local usedSlots = {}
	local freeSlot
	if not cont.items then cont.items = {}
	else for _,v in pairs( cont.items ) do usedSlots[v.slot] = true end end
	for i=1,6*cont.rows do if not usedSlots[i] then freeSlot = i break end end
	if not freeSlot then return false end

	local index = #cont.items+1
	cont.items[index] = data
	cont.items[index].slot = freeSlot
	if not cont.items[index].q then cont.items[index].q = 1 end

	countItems( cont )
	--for k,v in params do conts[index][k] = v end
end

function countItems( cont )
	cont.count = {}
	for _,v in ipairs( cont.items ) do
		if not cont.count[v.item.key] then cont.count[v.item.key] = 0 end
		cont.count[v.item.key] = cont.count[v.item.key] + v.q
	end
end

function createLoot( x,y,z )
	local colShape = createColSphere( x,y,z, 2 )
	setElementParent( colShape, contColParent )

	local obj = createObject( 2969, x,y,z )
	setObjectScale( obj, 2 )
	--[[conts[cont] = {
				{slot=3,item="wood", q=225},
				{slot=7,item="ak", q=1, qual=563},
				["rows"] = 2,
			}]]
	conts[colShape] = {rows=3, type="loot"}
	giveItem( colShape, {item=getItem("ak"),qual=666, clip=3} )
	giveItem( colShape, {item=getItem("ak"),qual=500, clip=3} )
	giveItem( colShape, {item=getItem("ak"),qual=450, clip=3} )
	giveItem( colShape, {item=getItem("wood"),q=550} )
	giveItem( colShape, {item=getItem("wood"),q=550} )
	giveItem( colShape, {item=getItem("stone"),q=450} )
	giveItem( colShape, {item=getItem("stone"),q=450} )
	giveItem( colShape, {item=getItem("stone"),q=450} )
	giveItem( colShape, {item=getItem("stone"),q=450} )

	attachElements( obj, colShape )
	--[[addEventHandler( "onColShapeHit", colshape,
	function (el,md)
		if md and isElement( el ) and getElementType( el ) == "player" then
			sendContainerDataToPlayer( el, conts[cont] )
		end
	end)]]
end
createLoot( -2002.7692871094, -73.03589630127, 35.171875-0.75 )
createLoot( -2010.3052978516, -65.965629577637, 35.171875-0.75 )
createLoot( -1999.1589355469, -62.623886108398, 35.3203125-0.75 )


addEvent( "onServerInventoryTransfer", true )
addEventHandler( "onServerInventoryTransfer", root,
function ( cont1, cont2, slot1, slot2 )
	if cont1==cont2 and slot1==slot2 then return end
	-- kon1 kon2 slot1 slot2
	local pla = client
	local tab1, tab2

	-- sprawdzanie z jakiego typu kontenera pochodzi item( klient daje inv/stor ), jednocześnie do lokalnych wrzucane są tabele kontenerów
	if cont1=="stor" then tab1=oCon[pla]
	else
		tab1=conts[pla]
		if tab1.selItem and (tab1.selItem.slot == slot1 or tab1.selItem.slot == slot2) then
			onPlayerSlotChange( pla )
		end
	end
	if cont2=="stor" then tab2=oCon[pla]
	else
		tab2=conts[pla]
		if tab2.selItem and (tab2.selItem.slot == slot1 or tab2.selItem.slot == slot2) then
			onPlayerSlotChange( pla )
		end
	end
	--outputChatBox( cont1.." "..cont2 )

	-- sprawdzanie na którym indexie jest dany slot
	local index1, index2
	for i,v in ipairs( tab1.items ) do
		if v.slot == slot1 then
			index1=i
			break
		end
	end

	if tab2 then
		--outputChatBox( "test" )
		for i,v in ipairs( tab2.items ) do
			if v.slot == slot2 then
				index2=i
				break
			end
		end
	end
	--outputChatBox( tostring(index1).." "..tostring(index2) )

	local item1, item2 = tab1.items[index1], tab2.items[index2]
	-- działanie
	if index1 then
		if index2 then -- kiedy zamieniamy 2 przedmioty miejscami lub łączyny
			local max = item1.item.max
			if item1.item == item2.item and max > 1 then
				if item2.q + item1.q > max then -- jeśli suma jest większa niż maksymalny stack
					item1.q = item1.q+item2.q-max
					item2.q = max
				else -- jeżeli nie jest
					item2.q = item2.q+item1.q
					table.remove( tab1.items, index1 )
				end
			else -- jeżeli trzeba zamienić miejscami
				--[[tab2[#tab2+1]		= tab1[index1]
				tab2[#tab2].slot	= slot1
				tab1[#tab1+1]		= tab2[index2]
				tab1[#tab1].slot	= slot2
				table.remove( tab1, index1 )
				table.remove( tab2, index2 )]]
				item1.slot = slot2
				item2.slot = slot1
				table.insert( tab1.items, item2 )
				table.insert( tab2.items, item1 )
				if index1>index2 then
					table.remove( tab1.items, index1 )
					table.remove( tab2.items, index2 )
				else
					table.remove( tab2.items, index2 )
					table.remove( tab1.items, index1 )
				end
			end
		else -- kiedy chcemy przerzucić item na pusty slot
			--tab2[#tab2+1] = tab1[index1]
			--tab2[#tab2].slot = slot2
			local item = item1
			item.slot = slot2
			table.insert( tab2.items, item1 )
			table.remove( tab1.items, index1 )

			if tab1 ~= tab2 then countItems( tab1 ) countItems( tab2 ) end
			--conts[pla][#conts[pla]+1] = tab1[index1]	
			--table.remove(conts[pla],index1)
		end
	end

	local blockSendingStorage = false
	if tab1.destroyOnEmpty and (#tab1.items or 0) <= 0 then destroyContainer( tab1 ) blockSendingStorage = true end 
	if tab2.destroyOnEmpty and (#tab2.items or 0) <= 0 then destroyContainer( tab2 ) blockSendingStorage = true end 

	local isStorTrans
	for k,v in pairs( oCon ) do
		if v == tab1 or v==tab2 then
			isStorTrans = true
			if blockSendingStorage then oCon[k] = nil end
			triggerClientEvent( k, "onClientInventoryReceive", k, conts[k], oCon[k] )
		end
	end
	if not isStorTrans then
		if blockSendingStorage then oCon[pla] = nil end
		triggerClientEvent( pla, "onClientInventoryReceive", pla, conts[pla], oCon[pla] )
	end
end )

addEvent( "onPlayerContClose", true )
addEventHandler( "onPlayerContClose", root,
function ()
	oCon[client] = nil
end )

addEvent( "onClientItemDrop", true )
addEventHandler( "onClientItemDrop", root, 
function ( itemToDrop )
	local pla = client
	local cont
	if itemToDrop.slot > 36 then
		cont = oCon[pla]
	else
		cont = conts[pla]
	end

	local index
	for i,v in ipairs( cont.items ) do
		if v.slot == itemToDrop.slot then
			index = i
			itemToDrop = v
			break
		end
	end

	if index then
		local nCont
		if oCon[pla] and oCon[pla].type == "trash" then
			nCont = oCon[pla]
		else
			local x,y,z = getElementPosition( pla )
			nCont = createContainer( x,y,z-0.6, 6, "trash", 928, {destroyOnEmpty=true} )
		end
		giveItem( nCont, itemToDrop )
		table.remove( cont.items, index )
		oCon[pla] = nCont
		triggerClientEvent( pla, "onClientInventoryReceive", pla, conts[pla], oCon[pla] )
	end

end )

function createContainer( x,y,z, rows, type, model, data )
	local col = createColSphere( x, y, z, 2 )
	local obj = createObject( model or 928, x, y, z )
	conts[col] = {rows=rows or 1, remove={}, type=type or loot}
	conts[col].el = col
	conts[col].obj = obj
	setElementParent( col, contColParent )
	if data then
		for k,v in pairs( data ) do
			conts[col][k] = v
		end
	end
	addEventHandler( "onElementDestroy", col,
	function()
		if isElement( conts[col].obj ) then destroyElement( conts[col].obj ) end
		conts[col] = nil
	end )
	return conts[col], col
end

function destroyContainer( cont )
	if not cont then return end
	local el = cont.el
	if isElement( el ) then
		destroyElement( el )
		conts[el] = nil
	end
end
	--triggerClientEvent( client, "onClientInventoryReceive", client, conts[pla], oCon[pla] )
	
	--[[local peq = con[client]
			if fromSlot>36 then fromItem=playerOpencon[client][fromIndex] else fromItem=peq[]
			local fromItem, toItem = peq[fromIndex], peq[toIndex]
			if fromItem then
				if toSlot>36 then toSlot=toSlot-36  end
				fromItem.slot = toSlot
				--fromItem.gr = toGr
				if toItem then
					if fromSlot>36 then fromSlot=fromSlot-36 end
					local max = getItem( toItem.item ).max
					if fromItem.item == toItem.item and max > toItem.q then
						if fromItem.q + toItem.q > max then
							fromItem.slot = fromSlot
							--fromItem.gr = fromGr
							fromItem.q = fromItem.q + toItem.q - max
							toItem.q = max
						else
							toItem.q = fromItem.q + toItem.q
							table.remove( peq, fromIndex )
						end
					else
						toItem.gr = fromGr
						toItem.slot = fromSlot
					end
				end
				if not isCont then oCon[client] = nil end
				triggerClientEvent( client, "onClientInventoryReceive", client, peq, oCon[client] )
	end
end )]]

function onPlayerSlotChange( pla, slot )
	local peq = conts[pla]
	if peq and peq.selItem then
		--outputChatBox( peq.selItem.item.type )
		if peq.selItem.item.type == "weapon" then
			takeAllWeapons( pla )
		end
		local ret if peq.selItem and peq.selItem.slot == slot then ret = true end
		peq.selItem = nil
		if ret then return end
	end
	if slot then
		for k,v in pairs( peq.items ) do
			if v.slot == slot then
				if v.item.type == "weapon" then
					local ammCount = peq.count[v.item.ammoType] or 0
					local ammSet = math.max( ammCount+v.clip, 0 )
					--outputChatBox( ammCount )
					giveWeapon( pla, v.item.wid, 1, true )
					setWeaponAmmo( pla, v.item.wid, ammSet, v.clip )
					peq.selItem = peq.items[k]
				end
				break
			end
		end
	end
end


addEvent( "onServerInventorySelect", true )
addEventHandler( "onServerInventorySelect", root,
function (...) onPlayerSlotChange( client, ... ) end )

-- bronie, przeładowanie

addEvent( "onPlayerWeaponReload" )
addEventHandler( "onPlayerWeaponReload", root, 
function (  )
	local pla = source
	local peq = conts[pla]
	reloadPedWeapon( pla )
	if peq.selItem and peq.selItem.item.type == "weapon" and peq.count[peq.selItem.item.ammoType] then
		local ammType = peq.selItem.item.ammoType
		local ammCount = ( type(peq.count[ammType])=="number" and peq.count[ammType] or 0 )
		--outputChatBox( ammCount )
		local ammClip = peq.selItem.clip
		local ammClipMax = getWeaponProperty( peq.selItem.item.wid, "std", "maximum_clip_ammo" ) --getPedStat( pla, peq.selItem.item.wid-22+69 )
		if ammCount > 0 then
			local clip = math.min( math.max( ammCount-ammClip, 0 ), ammClipMax )
			peq.remove[ammType] = (peq.remove[ammType] or 0) + clip - ammClip --ammClipMax - ammClip
			peq.count[ammType] = peq.count[ammType] - clip + ammClip --ammClipMax + ammClip
			outputChatBox( peq.remove[ammType] )
			peq.selItem.clip = clip
			--outputChatBox( peq.selItem.clip.."  "..clip )
			--setWeaponAmmo( pla, getPedWeapon( pla ), 1, clip )
			setWeaponAmmo( pla, peq.selItem.item.wid, peq.count[ammType]+clip, clip )
			triggerClientEvent( pla, "onClientReceiveSelectedItem", pla, peq.selItem, peq.count )
		end
		--peq.count[peq.selItem.item.ammoType] = peq.count[peq.selItem.item.ammoType]-1
		--if not peq.remove[peq.selItem.item.ammoType] then peq.remove[peq.selItem.item.ammoType] = 0 end
		--peq.remove[peq.selItem.item.ammoType] = peq.remove[peq.selItem.item.ammoType]+1
		--outputChatBox( peq.count[peq.selItem.item.ammoType] )
	end
end )

addEventHandler( "onPlayerWeaponFire", root,
function ( wpn, ex, ey, ez, el, sx, sy, sz )
	local pla = source
	local peq = conts[pla]

	if peq.selItem.clip > 0 then 
		peq.selItem.clip = peq.selItem.clip-1
		triggerClientEvent( pla, "onClientReceiveSelectedItem", pla, peq.selItem, peq.count )
	end
	if peq.selItem.clip <= 0 then
		triggerEvent( "onPlayerWeaponReload", pla )
		--outputChatBox( "test" )
	end

	--if peq.selItem and peq.selItem.item.type == "weapon" then
	--	peq.selItem.clip = peq.selItem.clip-1
	--end
end )

outputDebugString( "[KP] kps_inventory (server.lua) start" )
--[[
-----------------------------------------
local ekwipunki = {
	g1 = { s1 = { id=2, ammo=5 }, s2 = { id=53, spoil=5 }, s3 = { id=0 }, s4 = { id=0 }
	},
	k1 = { s1 = { id=67, ammo=5 }, s2 = { id=342, spoil=5 }, s3 = { id=0 }, s4 = { id=0 }
	}
}

local parametry = { p1="id", p2="stack", p3="spoil", p4="ammo"}

local pierwszyWolny = 0
local pierwszyStak = 0

local kompatybil = 0

function nos ( pla, nazwa, eq1, slot, eq2)
	kompatybil = 0
	for i=1,100
		for i2=1,4 do
			if ekwipunki[eq2]["s" .. pierwszyWolny][parametry["p" .. i2] ] == ekwipunki[eq1]["s" .. slot][parametry["p" .. i2] ] and i2 ~= 2 then
				kompatybil = kompatybil + 1
			end
		end
		if kompatybil == 4 then
				pierwszyStak = i
			break
		end
	if ekwipunki[eq2]["s" .. i]["id"] == 0 then
		pierwszyWolny = i
		outputChatBox (pierwszyWolny)
		break
	end
	end
	for i3=1,4 do
		ekwipunki[eq2]["s" .. pierwszyWolny][parametry["p" .. i3] ] = ekwipunki[eq1]["s" .. slot][parametry["p" .. i3] ]
		ekwipunki[eq1]["s" .. slot][parametry["p" .. i3] ] = ""
	end
end

addCommandHandler ( "nos", nos)
]]
