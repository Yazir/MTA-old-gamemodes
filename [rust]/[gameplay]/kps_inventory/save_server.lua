-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

addEventHandler( "onPlayerLogin", root,
function ( pre, cur )
 	loadPlayer( source )
end )

addEventHandler( "onPlayerQuit", root,
function ()
 	savePlayer( source )
 end )

addEventHandler( "onResourceStart", resourceRoot, 
function ()
	for _,v in ipairs( getElementsByType( "player" ) ) do
		loadPlayer( pla )
	end
end )

addEventHandler( "onResourceStop", resourceRoot,
function ()
	for _,v in ipairs( getElementsByType( "player" ) ) do
		savePlayer( v )
	end
end )

function savePlayer( pla )
	local acc = getPlayerAccount( pla )
	outputDebugString( "set pre" )
	if not isGuestAccount( acc ) then
		local inv = conts[pla]
		setAccountData( acc, "kps_inventory", inv )
		outputDebugString( "set" )
	end
end

function loadPlayer( pla )
	local acc = getPlayerAccount( pla )
	if not isGuestAccount( acc ) then
		local inv = getAccountData( acc, "kps_inventory" )
		outputChatBox( tostring(inv) )
		if inv then
			conts[pla] = inv
			outputChatBox( "this" )
		else
			outputChatBox( "or this" )
			conts[pla] = {rows=6, remove={}, type="inv", items={}}
			giveItem( pla, {item=getItem("stone"),qual=1000,q=1} )
		end
	end
end

outputDebugString( "[KP] template (server.lua) start" )