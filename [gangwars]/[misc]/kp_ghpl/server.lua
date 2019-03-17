-- wybuch

function narkoWybuchSerwer2 ( typ )
	local x,y,z = getElementPosition(client)
	createExplosion ( x,y,z, typ, client )
end 


addEvent( "narkoWybuchSerwer", true )
addEventHandler( "narkoWybuchSerwer", root, narkoWybuchSerwer2)


--- Ogien

function narkoOgienSerwer2 ( )
	local x,y,z = getElementPosition(client)
	triggerClientEvent( getElementsByType ( "player" ), "narkoOgienKlient", root, x, y, z, rx, ry, rz )
end 


addEvent( "narkoOgienSerwer", true )
addEventHandler( "narkoOgienSerwer", root, narkoOgienSerwer2)

--- Sraczka

function narkoSraczkaSerwer2 ( x, y, z, rx, ry, rz )
	local x,y,z = getElementPosition(client)
	local rx, ry, rz = getElementRotation(client)
	triggerClientEvent( getElementsByType ( "player" ), "narkoSraczkaKlient", root, x, y, z, rx, ry, rz )
end


addEvent( "narkoSraczkaSerwer", true )
addEventHandler( "narkoSraczkaSerwer", root, narkoSraczkaSerwer2)



--- Siury

function narkoSiurySerwer2 ( x, y, z, rx, ry, rz )
	local x,y,z = getElementPosition(client)
	local rx, ry, rz = getElementRotation(client)
	triggerClientEvent( getElementsByType ( "player" ), "narkoSiuryKlient", root, x, y, z, rx, ry, rz )
end


addEvent( "narkoSiurySerwer", true )
addEventHandler( "narkoSiurySerwer", root, narkoSiurySerwer2)


--- Krew z odbytu

function narkoKrewOdbytSerwer2 ( x, y, z, rx, ry, rz )
	local x,y,z = getElementPosition(client)
	local rx, ry, rz = getElementRotation(client)
	triggerClientEvent( getElementsByType ( "player" ), "narkoKrewOdbytKlient", root, x, y, z, rx, ry, rz )
end


addEvent( "narkoKrewOdbytSerwer", true )
addEventHandler( "narkoKrewOdbytSerwer", root, narkoKrewOdbytSerwer2)


--- Krew z siuraka

function narkoKrewSiurakSerwer2 ( x, y, z, rx, ry, rz )
	local x,y,z = getElementPosition(client)
	local rx, ry, rz = getElementRotation(client)
	triggerClientEvent( getElementsByType ( "player" ), "narkoKrewSiurakKlient", root, x, y, z, rx, ry, rz )
end


addEvent( "narkoKrewSiurakSerwer", true )
addEventHandler( "narkoKrewSiurakSerwer", root, narkoKrewSiurakSerwer2)







outputDebugString( "[KP] ghpl server (server.lua) start" )
