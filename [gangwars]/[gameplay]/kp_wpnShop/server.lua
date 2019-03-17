-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

function shopCheckout(data, shoptype )
	if shoptype == "vip" and not getElementData( client, "vipLevel" )  then exports.kp:writeLog( "cheats:file-modify", "Client: "..getAccountName( getPlayerAccount( client ) ).."("..getPlayerSerial( client )..")" ) kickPlayer( client, nil, "Cheat attempt. This action has been logged." ) return end
	local cost = 0
	for i, v in ipairs(data) do
		cost = cost + itemShopWeapons[shoptype][v]["cost"]
	end
	if cost <= getPlayerMoney( client ) then
		for i, v in ipairs(data) do
			giveWeapon( client, itemShopWeapons[shoptype][v]["wid"], itemShopWeapons[shoptype][v]["ammo"])
		end
		setPlayerMoney( client, getPlayerMoney( client ) - cost )
		exports.kp:saveWeapons( client )
	end
end
addEvent( "shopCheckout", true )
addEventHandler( "shopCheckout", resourceRoot, shopCheckout )

addEventHandler( "onResourceStart", resourceRoot,
function (  )
	local marker = createMarker( 2442.6520996094,-1965.4682617188,12.5, "cylinder", 2, 50, 250, 50, 200 ) setElementData( marker, "shop", "spawn" )
    createBlip( 2442.6520996094,-1965.4682617188,12.5 , 18, 2, nil,nil,nil,nil,5, 1000 ) exports.kp_safezones:createSafezone( 2442.6520996094,-1965.4682617188, 35 )
    local marker = createMarker( 1366.2739257813,-1279.7294921875,12.5, "cylinder", 2, 50, 250, 50, 200 ) setElementData( marker, "shop", "spawn" )
    createBlip( 1366.2739257813,-1279.7294921875,12.5 , 18, 2, nil,nil,nil,nil,5, 1000 ) exports.kp_safezones:createSafezone( 1366.2739257813,-1279.7294921875, 35 )
    local marker = createMarker( 1180.3195800781,-2036.9656982422,68.6, "cylinder", 2, 50, 250, 50, 200 ) setElementData( marker, "shop", "vip" )
    createBlip( 1180.3195800781,-2036.9656982422,68.4 , 18, 2, nil,nil,nil,nil,5, 1000 ) exports.kp_safezones:createSafezone( 1180.3195800781,-2036.9656982422, 5 )
    local marker = createMarker( 1549.7429199219,-1680.9947509766,12.5, "cylinder", 2, 50, 250, 50, 200 ) setElementData( marker, "shop", "police" )
end )

outputDebugString( "[KP] kp_wpnshop (server.lua) start" )