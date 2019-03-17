-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local proximalPlayers = {}

local TEXT_SCALE = 1
local TEXT_SHADOW_OFFSET = 0.7

local TAG_WIDTH, TAG_HEIGHT = 60, 6
addEventHandler( "onClientRender", root, 
function (  )
	local cx, cy, cz = getCameraMatrix()
	for k,v in ipairs(proximalPlayers) do
		if isElement(v) and getElementData( v, "login" ) then
			local px,py,pz = getPedBonePosition( v, 8 ) pz=pz+0.4
			local dist = getDistanceBetweenPoints3D( px, py, pz, cx, cy, cz )
			local x,y = getScreenFromWorldPosition( px, py, pz)
			if x and dist < 100 and isLineOfSightClear( cx,cy,cz,px,py,pz,true,false,false,true,false,false,false) then 

				local prefix = ""
				local suffix = ""
				local aM = 1
				local r,g,b = 200, 200, 200
				local nameHex = ""
				--if getElementData( v, "vipLevel" ) then nameHex = "#FFD700" end
				local team = getPlayerTeam( v )
				if team then r,g,b = getTeamColor( team ) end
				--if isPedInVehicle( v ) then aM = 0.5 end
				if isPedDucked( v ) then aM = 0.35 end
				--if getElementData( v, "inSafezone" ) then prefix = "*** SAFEZONE ***\n" end
				--if getElementData( v, "wanted" ) > 0 then prefix = prefix.."WANTED: "..getElementData( v, "wanted" ).."\n" end
				if getElementData( v, "vipLevel" )  then prefix = "[Patron]\n" end
				if getElementData( v, "lvl" ) then suffix = suffix.."["..getElementData( v, "lvl" ).."]" end
				--if getPedArmor( v ) > 10 then suffix = suffix.. "\n[".."KEVLAR: "..math.floor(getPedArmor( v )) .."]"  end
				if getElementData( v, "clan" ) then suffix = suffix.."\n"..getElementData( v, "clan" ).."" end

				local text = prefix..nameHex..getPlayerName( v )..suffix
				local textShadow = prefix..getPlayerName( v )..suffix
				local alpha = math.min( 255* (1-dist/100), 255 )*aM
				local size = (1-dist/100)

				if getElementData( v, "wanted" ) > 3 then
					dxDrawImage( x-120/2*size, y-80/2*size -120*size, 120*size, 120*size, "star.png", nil, nil, nil, nil, tocolor(255,255,255,0) )
					dxDrawText( getElementData( v, "wanted" ), x-1, y-2-1 -80*size, nil, nil, tocolor( 10,10,10 ), 2*size, "default", "center", "bottom", false, false, false, false, true, 0, 0, 0 )
					dxDrawText( getElementData( v, "wanted" ), x+1, y-2-1 -80*size, nil, nil, tocolor( 10,10,10 ), 2*size, "default", "center", "bottom", false, false, false, false, true, 0, 0, 0 )
					dxDrawText( getElementData( v, "wanted" ), x-1, y-2+1 -80*size, nil, nil, tocolor( 10,10,10 ), 2*size, "default", "center", "bottom", false, false, false, false, true, 0, 0, 0 )
					dxDrawText( getElementData( v, "wanted" ), x+1, y-2+1 -80*size, nil, nil, tocolor( 10,10,10 ), 2*size, "default", "center", "bottom", false, false, false, false, true, 0, 0, 0 )
					dxDrawText( getElementData( v, "wanted" ), x, y-2 -80*size, nil, nil, tocolor( 255, 255, 255 ), 2*size, "default", "center", "bottom", false, false, false, false, true, 0, 0, 0 )
				end

				dxDrawText( textShadow, x+TEXT_SHADOW_OFFSET, y+TEXT_SHADOW_OFFSET, nil, nil, tocolor( 25, 25, 25, alpha ), size*TEXT_SCALE, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0 )
				dxDrawText( textShadow, x-TEXT_SHADOW_OFFSET, y-TEXT_SHADOW_OFFSET, nil, nil, tocolor( 25, 25, 25, alpha ), size*TEXT_SCALE, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0 )
				dxDrawText( textShadow, x+TEXT_SHADOW_OFFSET, y-TEXT_SHADOW_OFFSET, nil, nil, tocolor( 25, 25, 25, alpha ), size*TEXT_SCALE, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0 )
				dxDrawText( textShadow, x-TEXT_SHADOW_OFFSET, y+TEXT_SHADOW_OFFSET, nil, nil, tocolor( 25, 25, 25, alpha ), size*TEXT_SCALE, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0 )
				dxDrawText( text, x, y, nil, nil, tocolor( r, g, b, alpha ), size*TEXT_SCALE, "default-bold", "center", "top", false, false, false, true, true, 0, 0, 0 )

				--local barscale, width, height = size, 30,6
				--[[dxDrawLine( x-width/2*size-2, y+1.5 +4, x+width/2*size+2, y+1.5 +4, tocolor( 30,30,30, alpha ), width*3*size )
				--dxDrawLine( x-32, y +3, x+32, y+3, tocolor( 0,0,0, alpha ), 4 )
				dxDrawLine( x-width/2*size, y +3 +4, x+width/2*size*math.min(1*getPedArmor( v )/100,1), y+3 +4, tocolor( 160, 160, 160, alpha ), width*size )
				dxDrawLine( x-width/2*size, y +4, x+width/2*size*math.min(1*getElementHealth( v )/100,1), y +4, tocolor( 150, 0, 0, alpha ), width*size )
				dxDrawLine( x-width/2*size-2, y+1.5 +4, x+width/2*size+2, y+1.5 +4, tocolor( 30,30,30, alpha ), 1 )]]
				
				local armorPerc = getPedArmor( v )/100
				local hpPerc = getElementHealth( v )/100
				local x,y = x-(TAG_WIDTH/2)*size, y+4
				local tsox = 2
				local hpR, hpG, hpB = 240, 0, 0
				if getElementData( v, "inSafezone" ) then hpR, hpG, hpB = 128,255,0 end

				if armorPerc*100 > 5 then
					dxDrawLine( x-(tsox)*size, y-(TAG_HEIGHT*2)*size, x+(TAG_WIDTH+tsox)*size, y-(TAG_HEIGHT*2)*size, tocolor( 5, 5, 5, 255*size*aM ), (TAG_HEIGHT+tsox)*size )
					dxDrawLine( x, y-(TAG_HEIGHT*2)*size, x+(TAG_WIDTH*armorPerc)*size, y-(TAG_HEIGHT*2)*size, tocolor( 225, 225, 225, 200*size*aM ), (TAG_HEIGHT)*size )
				end
				dxDrawLine( x-(tsox)*size, y-(TAG_HEIGHT*3.5)*size, x+(TAG_WIDTH+tsox)*size, y-(TAG_HEIGHT*3.5)*size, tocolor( 5, 5, 5, 255*size*aM ), (TAG_HEIGHT+tsox)*size )
				dxDrawLine( x, y-(TAG_HEIGHT*3.5)*size, x+(TAG_WIDTH*hpPerc)*size, y-(TAG_HEIGHT*3.5)*size, tocolor( hpR, hpG, hpB, 200*size*aM ), (TAG_HEIGHT)*size )
				
			end
		end
	end
end, nil, "low" )

setTimer( 
function (  )
	proximalPlayers = {}
	local cx, cy, cz = getCameraMatrix()
	local dim = getElementDimension( localPlayer )
	local players = getElementsByType( "player" )
	for k,v in ipairs(players) do
		if not getElementData( v, "blockNametag" ) then
			if v ~= localPlayer then
				local px,py,pz = getPedBonePosition( v, 8 ) pz=pz+0.4
				local dist = getDistanceBetweenPoints3D( px, py, pz, cx, cy, cz )
				if dist < 150 then
					proximalPlayers[#proximalPlayers+1] = v
				end
			end
		end
	end
end, 1000, 0 )

function onClientResourceStart ( )
    local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
    for key, player in ipairs ( players ) do       -- for all the players in the table
        setPlayerNametagShowing ( player, false )  -- turn off their nametag
    end
end
addEventHandler ( "onClientResourceStart", resourceRoot, onClientResourceStart )

function onClientPlayerJoin ( )
      -- Whoever joins the server should also have their nametags deactivated
	setPlayerNametagShowing ( source, false )
end
addEventHandler ( "onClientPlayerJoin", root, onClientPlayerJoin )

function rgb2hex(r,g,b)
	
	local hex_table = {[10] = 'A',[11] = 'B',[12] = 'C',[13] = 'D',[14] = 'E',[15] = 'F'}
	
	local r1 = math.floor(r / 16)
	local r2 = r - (16 * r1)
	local g1 = math.floor(g / 16)
	local g2 = g - (16 * g1)
	local b1 = math.floor(b / 16)
	local b2 = b - (16 * b1)
	
	if r1 > 9 then r1 = hex_table[r1] end
	if r2 > 9 then r2 = hex_table[r2] end
	if g1 > 9 then g1 = hex_table[g1] end
	if g2 > 9 then g2 = hex_table[g2] end
	if b1 > 9 then r1 = hex_table[b1] end
	if b2 > 9 then r2 = hex_table[b2] end
	return "#" .. r1 .. r2 .. g1 .. g2 .. b1 .. b2

end