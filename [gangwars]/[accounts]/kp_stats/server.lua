-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

function addStat( pla, cat, stat, val )
	if not pla then return end
	local stats = getElementData( pla, "kpStats" )
	if not stats then stats = {} end
	if not stats[cat] then stats[cat] = {} end
	if not stats[cat][stat] then stats[cat][stat] = 0 end
	stats[cat][stat] = stats[cat][stat] + val
	setElementData( pla, "kpStats", stats )
end

addCommandHandler( "stats", 
function ( pla )
	local stats = getElementData( pla, "kpStats" )
	for k,v in pairs( stats ) do
		outputChatBox( "Kategoria: "..k, pla )
		for k2,v2 in pairs( v ) do
			outputChatBox( " ~"..k2..": "..v2, pla )
		end
	end
end )


---- stat adds
-- headshot, bronie, dmg hp, dmg veh
addEventHandler( "onPlayerWasted", root, 
function ( amm, att, wpn, bp )
	local pla = source
	local dim = getElementDimension( pla )
	if dim == 0 and pla ~= att then
		addStat( pla, "Ogólne", "zgony", 1 )
		if isElement( att ) and getElementType( att ) == "player" then
			addStat( att, "Ogólne", "zabójstwa", 1 )
			addStat( att, "Bronie Zab.", getWeaponNameFromID( wpn ), 1 )
		end
	end
end )

addEventHandler( "onPlayerDamage", root, 
function ( att, wpn, bd, loss )
	local pla = source
	local dim = getElementDimension( pla )
	if dim == 0 and pla ~= att then
	--outputChatBox( tostring( loss ) )
		if loss and loss>0 then
			addStat( pla, "Ogólne", "otrzymane obrażenia", loss )
			if isElement( att ) and getElementType( att ) == "player" then
				addStat( att, "Ogólne", "zadane obrażenia", loss )
				addStat( att, "Bronie Obr.", getWeaponNameFromID( wpn ), loss )
			end
		end
	end
end )

outputDebugString( "[KP] kp_stats (server.lua) start" )