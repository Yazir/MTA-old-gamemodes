-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local lootPoints, unusedPoints

local POINT_COUNT = 50

local lootTable = {
	{key="ak", perc=0.5, amm=1},
	{key="m4",perc=0.6, amm=1},
	{key="colt",perc=3.5, amm=1},
	{key="cuntgun",perc=3, amm=1},
	{key="mp5",perc=2, amm=1},
	{key="sniper",perc=0.2, amm=1},
	{key="pistolammo",perc=10, amm=24},
	{key="rifleammo",perc=5, amm=24},
	{key="shotgunammo",perc=5, amm=24},
	{key="wood",perc=10, amm=100},
	{key="stone",perc=10, amm=100},
}

local rubbishObj = {2672, 928, 926, 2654, 2968}
function createLootPoint()
	local index = math.random( 1, #unusedPoints )
	local loot = unusedPoints[index]
	local x,y,z = getElementPosition( loot )
	local cont = createContainer( x,y,z, 2, "loot", rubbishObj[math.random(1,#rubbishObj)], {destroyOnEmpty=true} )
	local hasAnyItems,i = false, 0
	--outputChatBox( "created"..index )
	addEventHandler( "onElementDestroy", cont.el, createLootPoint )
	while not hasAnyItems and i<100 do
		i = i+1
		for k,v in ipairs( lootTable ) do
			local item = getItem( v.key )
			local iType = item.type
			if v.perc > math.random(0,10000)/100 then
				hasAnyItems = true
				if iType == "weapon" then
					giveItem( cont, {item=getItem( item.key ), qual=math.random( 100,900 ), clip=math.random( 0,getWeaponProperty( item.wid, "std", "maximum_clip_ammo" ) or 5 ), q=v.amm or 1} )
				elseif iType == "ammo" then
					giveItem( cont, {item=getItem( item.key ),q=math.random( 1, v.amm )} )
				elseif iType == "resource" then
					giveItem( cont, {item=getItem( item.key ),q=math.random( 1, v.amm )} )
				end
			end
		end
	end
end

addEventHandler( "onResourceStart", resourceRoot, 
function ()
	lootPoints = getElementsByType( "loot" )
	unusedPoints = lootPoints
	if not unusedPoints then return end
	if POINT_COUNT == 0 then return end
	local li = 1
	setTimer(
	function ()
		outputChatBox( "create"..li )
		li = li+1
		--[[for i=1,3 do
			local index = math.random( 1, #unusedPoints )
			local x,y,z = getElementPosition( unusedPoints[index] )
			createBlip( x,y,z, 0, 2, 255, 0, 0, 200, 0, 200 )
			table.remove( unusedPoints, index )
		end]]
		if #unusedPoints == 1 then unusedPoints = lootPoints end
		createLootPoint()
	end, 50, POINT_COUNT )
end )

outputDebugString( "[KP] kps_inventory (lootS.lua) start" )