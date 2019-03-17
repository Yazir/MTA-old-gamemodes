-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

function getSpawnPos()
	local rand = math.random(1,4)
	local x,y
	local boxSize = 2900
	if rand == 1 then 		x,y = -boxSize, math.random(-boxSize,boxSize)
	elseif rand == 2 then 	x,y = math.random(-boxSize,boxSize), -boxSize
	elseif rand == 3 then 	x,y = boxSize, math.random(-boxSize,boxSize)
	else 					x,y = math.random(-boxSize,boxSize), boxSize
	end return x,y	
end

function spawn(pla)
	local x,y = getSpawnPos()
	spawnPlayer(pla, x, y, 800, 0, 0, 0, 0)
	setCameraTarget( pla, pla )
	fadeCamera( pla, true )
	giveWeapon(pla, 46)
end

addCommandHandler("spawn", spawn)
addEventHandler("onPlayerLogin", root, function() spawn(source) end)
addEventHandler("onPlayerWasted", root, function() setTimer(spawn, 5000, 1, source) end)

---1099.4284667969, -1644.4700927734, 75.772399902344 safezone przy sf

outputDebugString("[KP] kps_core (server.lua) start")

