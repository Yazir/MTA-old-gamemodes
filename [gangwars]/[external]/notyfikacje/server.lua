-- skrypt napisal DeMoNeK_
-- server site

function createNotification(player, demon, text, czas) 
	if isElement(player) and getElementType(player) == "player" and type(text) == "string" then 
		triggerClientEvent(player, "onClientAddNotification", player, demon, text, czas)
		return true 
	else 
		return false
	end
end

addCommandHandler( "notif",
function ( pla, cmd, arg )
	createNotification( pla, "info", "Quick fox jumped over the lazy dog. Quick fox jumped over the lazy dog. Quick fox jumped over the lazy dog. Quick fox jumped over the lazy dog. Quick fox jumped over the lazy dog.", 10 )
end )