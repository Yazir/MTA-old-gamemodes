local screenX,screenY = guiGetScreenSize(  )
--[[
addCommandHandler( "wep",
function ( cmd, arg )
	setElementData( localPlayer, "wepskin", arg )
	engineImportTXD(wepSkins[arg][1], 355)
	engineReplaceModel(wepSkins[arg][2],355)
end )

wepTable = {
	{"ak1","ak74"},
	{"ak2","akm"},
	{"ak3","aks74u"},
}

wepSkins = {}

function loadTheSkins()
	for i, skin in ipairs(wepTable) do
		wepSkins[skin[1] ] = {}
		wepSkins[skin[1] ][1] = engineLoadTXD("skins/weapons/"..skin[2]..".txd")
		wepSkins[skin[1] ][2] = engineLoadDFF("skins/weapons/"..skin[2]..".dff", 0)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,loadTheSkins)
]]

--[[
addEventHandler( "onClientPlayerWeaponFire", root,
function ( wep, amm, ammClip, sourcex,sourcey,sourcez,el,hitx,hity,hitz )
	if source == localPlayer then
		--setCameraMatrix(sx,sy,sz, x,y,z+1)
		--setCameraTarget( localPlayer )
		--getCameraTarget( player thePlayer )
		local cx,cy,cz,clx,cly,clz = getCameraMatrix()
		local crZ = getPedCameraRotation( localPlayer )
		outputChatBox( crZ )
		local lookX, lookY = math.cos( 114 )*100, math.sin( 114 )*100
		local X, Y, Z = getElementPosition( localPlayer ) 

		local screenX, screenY, screenZ = getWorldFromScreenPosition( screenX/2, screenY/2, 50 )
		setCameraTarget( X + screenX, Y + screenY, 5)
	end
	if getElementData( source, "explosiveBullets") then
		createExplosion( sourcex,sourcey,sourcez, 12, true, 0.2, true )
		--local x,y,z, lx,ly,lz = getCameraMatrix()
		--setCameraMatrix(x, y, z, lx, ly, lz+0.1 )
	end
end )

function sendinfo()
    local slotinfo = {}
    for i,player in ipairs(getElementsByType("player")) do
        slotinfo[player] = getPedWeaponSlot(player)
    end
    triggerServerEvent("onSlotInfo", resourceRoot, slotinfo)
end
setTimer(sendinfo,1000,0)
]]

function renderDebug(  )
	for i,plr in ipairs(getElementsByType("player")) do
		if not isElement( plr ) then return end
	    for slot=0,12 do
	        weap = getPedWeapon(plr,slot)
	        ammo = getPedAmmoInClip(plr,slot)
	        ammoTot = getPedTotalAmmo( plr, slot )
	        dxDrawText( slot .. " " .. getPlayerName( plr ) .. " (D".. getElementDimension( plr ) .. ") " .. tostring(weap) .. " " .. tostring(ammo) .. "/" .. tostring(ammoTot), 230 + i * 180, slot*15, tocolor( 255, 255, 255, 150 ), 0.5 )
	    end
	end
end

local isWpnDebug = false
addCommandHandler( "wpndebug", 
function ( )
	if not isWpnDebug then addEventHandler( "onClientRender", root, renderDebug ) isWpnDebug = true outputChatBox( "ON" )
	else removeEventHandler( "onClientRender", root, renderDebug ) isWpnDebug = false end
end )