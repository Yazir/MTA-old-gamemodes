-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

addEventHandler( "onClientPlayerDamage", root, 
function ( veh, wpn, bd, loss )
	local pla = source
	--outputConsole( tostring( att ) )
	local gang1 = getElementData( pla, "gang" )
	local gang2 = nil

	if isElement( veh ) and getElementType( veh ) == "vehicle" then
		local doit = false
		local att = getVehicleOccupant( veh )
		if att then gang2 = getElementData( att, "gang" ) end
		
		if att and ( gang1 == "civilian" or gang2 == "civilian" or getElementData( att, "inSafezone" ) or getElementData( pla, "inSafezone" ) ) then doit = true end
		if gang2 == "police" and getElementData( pla, "wanted" ) < 5 then doit = true end
		if gang1 == gang2 then doit = true end
		if not doit then return end
		if wpn == 49 then
			local vx,vy = getElementVelocity( veh )
			setElementVelocity( veh, -vx+0.5/4, -vy/4, 0.15 )
			local rx, ry = getVehicleTurnVelocity( veh )
			setVehicleTurnVelocity( veh, rx, ry, math.random(-100,100)/800 )
			--setElementVelocity( veh, -vx+0.5/4, -vy/4, 0.1 )
			--setVehicleTurnVelocity( veh, math.rad(math.random(360)), math.rad(math.random(360)), math.rad(math.random(-900,900)) )
			--setVehicleTurnVelocity( veh, 0,0, math.rad(math.random(-900,900)) )
			--setElementHealth( veh, 10000 )
		elseif wpn == 50 then
			setElementVelocity( veh, math.random(-100,100)/500, math.random(-100,100)/500, 0.2 )
		end
		cancelEvent(  )
	end
end )


addEventHandler( "onClientVehicleDamage", root, 
function ( att, wpn, loss, dx,dy,dz, tyre )
	local veh = source
	for k,v in pairs( getVehicleOccupants( veh ) ) do
		if isPedDoingGangDriveby( v ) then
			local hp = getElementHealth( v )
			if hp-loss/10 > 0 then
				setElementHealth( v, hp-loss/10 )
			else
				if localPlayer == v  then
					triggerServerEvent( "combatRequest", localPlayer, "killme", att, wpn )
				end
			end
		end
	end
end )

--[[function clip ( cmd, arg )
    setFogDistance(1)
    setFarClipDistance( tonumber( arg ) )
end
addCommandHandler( "clip", clip )]]

--[[addCommandHandler( "meatspin",
function ()
 	local rx, ry = getVehicleTurnVelocity( veh )
	setVehicleTurnVelocity( veh, rx, ry, math.random(-100,100)/800 )
 end )]]

