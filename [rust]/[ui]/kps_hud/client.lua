-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.
local scx, scy = guiGetScreenSize(  )

local infoPos = {x=scx*0.8255, y=scy*0.8380, w=scx*0.1464,h=scy*0.0370, gap=scy*0.003, color=tocolor(69, 73, 61, 200)}
local innerPos = {
	[1] = { color=tocolor(50,180,50, 200), multi=1 },
	[2] = { color=tocolor(17,122,162, 200), multi=1 },
	[3] = { color=tocolor(255,165,0, 200), multi=1 },
}

function startRenderingHud( )
	addEventHandler( "onClientRender", root, 
	function (  )

		innerPos[1].multi = getElementHealth( localPlayer )/getPedMaxHealth( localPlayer )
		--outputChatBox( innerPos[1].multi )
		for i=0,3 -1 do
			dxDrawRectangle(infoPos.x, infoPos.y+(infoPos.h+infoPos.gap)*i, infoPos.w, infoPos.h, infoPos.color, false)
       		dxDrawRectangle( infoPos.x+infoPos.w*0.15, infoPos.y+(infoPos.h+infoPos.gap)*i+4, (infoPos.w-infoPos.w*0.17)*innerPos[i+1].multi, infoPos.h-8, innerPos[i+1].color, false )
       	end
        --dxDrawRectangle(1615, 909, 246, 33, tocolor(255, 255, 255, 255), false)
		--[[dxDrawRectangle( screenX*0.84, screenY*0.835, screenX*0.148, screenY*0.135, tocolor( 85,85,85,15 ) )
		dxDrawRectangle( screenX*0.865, screenY*0.84, screenX*0.12*hpM, screenY*0.035, tocolor( 85,225,85,125 ) )
		dxDrawRectangle( screenX*0.865, screenY*0.885, screenX*0.12*1, screenY*0.035, tocolor( 225,85,85,125 ) )
		dxDrawRectangle( screenX*0.865, screenY*0.93, screenX*0.12*1, screenY*0.035, tocolor( 85,85,225,125 ) )]]

	end, false, "low" )
end

addEvent( "onLogin", true )
addEventHandler( "onLogin", root, startRenderingHud )
addEventHandler( "onClientResourceStart", resourceRoot, function (  ) if getElementData( localPlayer, "login" ) then startRenderingHud() end end )

--[[function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
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
end]]

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
	setPlayerHudComponentVisible( "radar", false )
	setPlayerHudComponentVisible( "area_name", false )
end )
	setPlayerHudComponentVisible( "radar", false ) -- nie chce działać pod handlerem


addEventHandler( "onClientResourceStop", resourceRoot, 
function (  )
	setPlayerHudComponentVisible( "ammo", true )
	setPlayerHudComponentVisible( "armour", true )
	setPlayerHudComponentVisible( "clock", true )
	setPlayerHudComponentVisible( "health", true )
	setPlayerHudComponentVisible( "money", true )
	setPlayerHudComponentVisible( "weapon", true )
	setPlayerHudComponentVisible( "radar", true )
end )

