local screenX, screenY = guiGetScreenSize(  )
local hudOriginX, hudOriginY = screenX * 0.9, screenY * 0.15
local backdropSize = screenY*0.165

function startRenderingHud( )
	addEventHandler( "onClientRender", root, 
	function (  )
		dxDrawImage( hudOriginX-backdropSize/2, hudOriginY-backdropSize/2, backdropSize, backdropSize, "files/hud/hudBackdrop.png", 0, 0, 0, tocolor( 0, 0, 0, 100 ) )
		dxDrawCircle( hudOriginX, hudOriginY, screenY*0.085, 3.5, 1,math.rad(0), 359, tocolor( 25, 5, 5, 200 ) )
		local hpR, hpG, hpB = 175, 5, 5
		if getElementData( localPlayer, "inSafezone" ) then hpR, hpG, hpB = 128,255,0 end
		dxDrawCircle( hudOriginX, hudOriginY, screenY*0.085, 7.5, 1,math.rad(0), 361*(getElementHealth( localPlayer )/getPedMaxHealth( localPlayer )), tocolor( 25, 5, 5, 200 ) )
		dxDrawCircle( hudOriginX, hudOriginY, screenY*0.085, 4.85, 1,math.rad(0), 359*(getElementHealth( localPlayer )/getPedMaxHealth( localPlayer )), tocolor( hpR, hpG, hpB, 180 ) )
		if getPedArmor( localPlayer ) > 0 then
			dxDrawCircle( hudOriginX, hudOriginY, screenY*0.109, 7.2,6,math.rad(0), 359*(getPedArmor( localPlayer )/100)+22, tocolor( 8, 8, 8, 200 ) )
			dxDrawCircle( hudOriginX, hudOriginY, screenY*0.109, 5,6,math.rad(0), 359*(getPedArmor( localPlayer )/100), tocolor( 125, 125, 125, 180 ) )
		end
		if getPedAmmoInClip( localPlayer ) > 0 then 
			local ammMax = getWeaponProperty( getPedWeapon( localPlayer ), "std", "maximum_clip_ammo" )
			local ammClip = getPedAmmoInClip( localPlayer )
			dxDrawCircle( hudOriginX, hudOriginY, screenY*0.070, 7, 6, math.rad(0), 359*ammClip/ammMax, tocolor( 5, 25, 5, 150 ) )
			dxDrawCircle( hudOriginX, hudOriginY, screenY*0.070, 4.65, 6, math.rad(0), 359*ammClip/ammMax, tocolor( 5, 175, 5, 180 ) )
		end
		local wepText = getWeaponNameFromID( getPedWeapon( localPlayer ) )
		if getPedTotalAmmo( localPlayer ) > 1 then wepText = wepText.."\n"..getPedAmmoInClip( localPlayer ).."-"..getPedTotalAmmo( localPlayer )-getPedAmmoInClip( localPlayer ) end
		dxDrawText( wepText, hudOriginX+3, hudOriginY+2, nil,nil , tocolor(25,25,25,225), 1.25, "default-bold", "center", "center", false, false, false, false, false , 10, hudOriginX, hudOriginY )
		dxDrawText( wepText, hudOriginX, hudOriginY, nil,nil , tocolor(225,225,225,255), 1.25, "default-bold", "center", "center", false, false, false, false, false , 10, hudOriginX, hudOriginY )

		local lvl = getElementData( localPlayer, "lvl" )
		if lvl then
			local exp = getElementData( localPlayer, "exp", false ) - expAtLvl(lvl-1)
			local maxExp = expAtLvl(lvl) - expAtLvl(lvl-1)
			local percent = exp/maxExp
			dxDrawCircle( hudOriginX, hudOriginY, screenY*0.097, 4,1,math.rad(0), 359*percent, tocolor( 130,20,0, 50 ) )
			dxDrawCircle( hudOriginX, hudOriginY, screenY*0.097, 2,1,math.rad(0), 359*percent, tocolor( 255,151,25, 180 ) )
		end

		--[[local veh = getPedOccupiedVehicle( localPlayer )
						if veh then
							local speed = ( function( x, y, z ) return math.floor( math.sqrt( x*x + y*y + z*z ) * 155 ) end )( getElementVelocity( veh ) )
							dxDrawCircle( hudOriginX, hudOriginY, screenY*0.112, 1, 1,math.rad(0), speed-3, tocolor( 80, 255, 255, 255 ) )
							dxDrawCircle( hudOriginX, hudOriginY, screenY*0.112, 1, 3,math.rad(0), speed, tocolor( 40, 40, 40, 255 ) )
						end]]


		local wanted = getElementData( localPlayer, "wanted" )
		if wanted and wanted>0 then
			dxDrawText( "WANTED:"..wanted, screenX-10-1, 10-1, nil,nil , tocolor( 0, 0, 0, 255 ), 1.5, "default-bold", "right", "top" )
			dxDrawText( "WANTED:"..wanted, screenX-10+1, 10-1, nil,nil , tocolor( 0, 0, 0, 255 ), 1.5, "default-bold", "right", "top" )
			dxDrawText( "WANTED:"..wanted, screenX-10-1, 10+1, nil,nil , tocolor( 0, 0, 0, 255 ), 1.5, "default-bold", "right", "top" )
			dxDrawText( "WANTED:"..wanted, screenX-10+1, 10+1, nil,nil , tocolor( 0, 0, 0, 255 ), 1.5, "default-bold", "right", "top" )
			dxDrawText( "WANTED:"..wanted, screenX-10, 10, nil,nil , tocolor( 25, 25, 255, 200 ), 1.5, "default-bold", "right", "top" )
		end
	end )
end

addEvent( "onLogin", true )
addEventHandler( "onLogin", root, startRenderingHud )
addEventHandler( "onClientResourceStart", resourceRoot, function (  ) if getElementData( localPlayer, "login" ) then startRenderingHud() end end )

function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
	
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
	
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
	
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
	
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.cos( math.rad( i ) ) * ( radius - width )
		local startY = math.sin( math.rad( i ) ) * ( radius - width )
		local endX = math.cos( math.rad( i ) ) * ( radius + width )
		local endY = math.sin( math.rad( i ) ) * ( radius + width )
	
		dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
	end
	
	return true
end

function getPedMaxHealth(ped)
    -- Output an error and stop executing the function if the argument is not valid
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")

    -- Grab his player health stat.
    local stat = getPedStat(ped, 24)

    -- Do a linear interpolation to get how many health a ped can have.
    -- Assumes: 100 health = 569 stat, 200 health = 1000 stat.
    local maxhealth = 100 + (stat - 569) / 4.31

    -- Return the max health. Make sure it can't be below 1
    return math.max(1, maxhealth)
end

addEventHandler( "onClientResourceStart", resourceRoot, 
function (  )
	setPlayerHudComponentVisible( "ammo", false )
	setPlayerHudComponentVisible( "armour", false )
	setPlayerHudComponentVisible( "clock", false )
	setPlayerHudComponentVisible( "health", false )
	setPlayerHudComponentVisible( "money", false )
	setPlayerHudComponentVisible( "weapon", false )
end )

--setPlayerHudComponentVisible( "area_name", false )

addEventHandler( "onClientResourceStop", resourceRoot, 
function (  )
	setPlayerHudComponentVisible( "ammo", true )
	setPlayerHudComponentVisible( "armour", true )
	setPlayerHudComponentVisible( "clock", true )
	setPlayerHudComponentVisible( "health", true )
	setPlayerHudComponentVisible( "money", true )
	setPlayerHudComponentVisible( "weapon", true )
end )

