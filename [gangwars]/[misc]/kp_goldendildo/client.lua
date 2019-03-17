-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

addEventHandler( "onClientVehicleDamage", root,
function (att, wpn)
	local veh = source
	if wpn == 10 then
		local x,y,z = getElementPosition( veh )
		if getElementHealth( att ) < 90 then return end
		playSound3D( "imgay.mp3", x,y,z )
		setElementHealth( att, getElementHealth( att )*0.98-1 )
		setTimer( 
		function ()
			local vx,vy = getElementVelocity( veh )
			setElementVelocity( veh, -vx+0.5/4, -vy/4, 0.25 )
			local rx, ry = getVehicleTurnVelocity( veh )
			setVehicleTurnVelocity( veh, rx, ry, math.random(-100,100)/100 )
		end, 1250, 1)
	end
end )