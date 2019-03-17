-- Author: Yazir, for: mtakp.pl
-- If you want to use that coed, atleast give credits.

removeWorldModel( 5422, 9999, 0, 0, 0 )
removeWorldModel( 5856, 9999, 0, 0, 0 )
removeWorldModel( 6400, 9999, 0, 0, 0 )

local pns = {
	{2064.0908203125,-1831.4816894531,13.546875},
	{1025.0168457031,-1023.3884277344,32.1015625},
	{487.57061767578,-1741.5740966797,11.136850357056},
}

local parent = createElement( "pnsparent" )
addEventHandler( "onResourceStart", resourceRoot, 
function (  )
	for i,v in ipairs( pns ) do
		local marker = createMarker( v[1], v[2], v[3], "corona", 4.0, 170, 20, 20, 200, root )
		createBlip( v[1], v[2], v[3]+1, 63, 1, 255, 0, 0, 255, -100, 1000.0 )
		setElementParent( marker, parent )
	end
end )

addEventHandler( "onMarkerHit", parent, 
function ( el, md )
	if md and isElement( el ) and getElementType( el ) == "vehicle" then
		local pla = getVehicleOccupant( el )
		if pla then
			local hp = getElementHealth( el )
			if hp < 950 then
				local money = getPlayerMoney( pla )
				local cost = math.floor( ( 1000-hp ) / 50 )
				if money > cost then
					exports.kp:addMoney( pla, -cost )
					fixVehicle( el )
					setElementFrozen( el, true )
					fadeCamera( pla, false )
					setTimer(
					function (  )
						fadeCamera( pla, true )
						setElementFrozen( el, false )
						outputChatBox( "[PNS] Pojazd naprawiony za "..cost.."$.", pla, 50, 235, 50 )
					end, 1500, 1 )
				else
					outputChatBox( "[PNS] Nie masz "..cost.."$ aby naprawić pojazd.", pla, 50, 235, 50 )
				end
			end
		end
	end
end )

outputDebugString( "[KP] kp_pns (server.lua) start" )