local cSoundsEnabled = true
local reloadSoundEnabled = true
local explosionEnabled = false

function mgReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("files/sfx/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("files/sfx/reload/mg_clipin.wav", x,y,z)
	end, 1250, 1)
end

function tec9Reload(x,y,z)
	local sound = playSound3D("files/sfx/weapon/tec-9.wav", x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("files/sfx/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("files/sfx/reload/mg_clipin.wav", x,y,z)
	end, 1000, 1)
end

function pistolReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
	setTimer(function()
		local relSound = playSound3D("files/sfx/reload/pistol_reload.wav", x,y,z)
	end, 500, 1)
end

function shotgunReload(x,y,z)
	setTimer(function()
		local relSound = playSound3D("files/sfx/reload/shotgun_reload.wav", x,y,z)
		local shellSound = playSound3D("files/sfx/reload/shotgun_shell.wav", x,y,z)
	end, 500, 1)
end

local wepSounds = {
	[31]={"m4.wav", 		{ "mg_clipin.wav", 		500 },					180},
	[22]={"pistole.wav",	{ "pistol_reload.wav", 	500 },					80},
	[24]={"deagle.wav", 	{ "pistol_reload.wav", 	500 },					130},
	[25]={"shotgun.wav", 	{ "shotgun_reload.wav", 500 },					120},
	[26]={"shotgun.wav", 	{ "shotgun_reload.wav", 500 },					120},
	[27]={"shotgun.wav", 	{ "shotgun_reload.wav", 500 },					120},
	[28]={"uzi.wav", 		{ "tec-9.wav", 			500 },					80},
	[29]={"mp5.wav", 		{ "tec-9.wav", 			500 },					95},
	[32]={"tec-9.wav", 		{ "tec-9.wav", 			500 },					80},
	[30]={"ak.wav", 		{ "mg_clipin.wav", 		500 },					220},
	[33]={"sniper.wav", 	{ "mg_clipin.wav", 		500 },					250},
}

addEventHandler( "onClientPlayerWeaponFire", root,
function ( wpn, amm, ammInClip, hx, hy, hz, el, sx, sy, sz )
	if getElementDimension( source ) == getElementDimension( localPlayer ) and wepSounds[wpn] then
		--local x,y,z = getElementPosition( source )
		local sound = playSound3D( "files/sfx/weapon/"..wepSounds[wpn][1], sx, sy, sz )
		setSoundMaxDistance( sound, wepSounds[wpn][3] )
		setElementDimension( sound, getElementDimension( localPlayer ) )
		if ammInClip == 0 then
			setTimer(
			function (  )
				local relSound =playSound3D( "files/sfx/reload/"..wepSounds[wpn][2][1], sx, sy, sz )
				setSoundMaxDistance( relSound, 15 )
				setSoundVolume( relSound, 0.3 )
			end, wepSounds[wpn][2][2], 1 )
		end
	end
end )

--[[
function playSounds(weapon, ammo, ammoInClip)
	if(cSoundsEnabled)then
		local x,y,z = getElementPosition(source)
		local sound = nil
		if weapon == 31 then --m4
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/m4.wav", x,y,z)
			else
				sound = playSound3D("sounds/weapon/m4.wav", x,y,z)
				setSoundMaxDistance(sound, 180)
			end
		elseif weapon == 22 then --pistol
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/pistole.wav", x,y,z)
			else
				sound = playSound3D("sounds/weapon/pistole.wav", x,y,z)
				setSoundMaxDistance(sound, 80)
			end
		elseif weapon == 24 then --deagle
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/deagle.wav", x,y,z)
			else
				sound = playSound3D("sounds/weapon/deagle.wav", x,y,z)
				setSoundMaxDistance(sound, 130)
			end
		elseif weapon == 25 or weapon == 26 or weapon == 27 then --shotguns
			if(weapon == 25)then
				sound = playSound3D("sounds/weapon/shotgun.wav", x,y,z)
				setSoundMaxDistance(sound, 120)
				shotgunReload(x,y,z)
			else
				sound = playSound3D("sounds/weapon/shotgun.wav", x,y,z)
				shellSound = playSound3D("sounds/reload/shotgun_shell.wav", x,y,z)
				setSoundMaxDistance(sound, 15)
			end
		elseif weapon == 28 then --uzi
			if(ammoInClip == 0)then						
				mgReload("sounds/weapon/uzi.wav", x,y,z)
			else
				sound = playSound3D("sounds/weapon/uzi.wav", x,y,z)
				setSoundMaxDistance(sound, 80)
			end
		elseif weapon == 29 then --mp5
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/mp5.wav", x,y,z)
			else
				sound = playSound3D("sounds/weapon/mp5.wav", x,y,z)
				setSoundMaxDistance(sound, 95)
			end
		elseif weapon == 32 then --tec-9
			if(ammoInClip == 0)then						
				tec9Reload(x,y,z)
			else
				sound = playSound3D("sounds/weapon/tec-9.wav", x,y,z)
				setSoundMaxDistance(sound, 80)
			end
		elseif weapon == 30 then --ak
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/ak.wav", x,y,z)
			else
				sound = playSound3D("sounds/weapon/ak.wav", x,y,z)
				setSoundMaxDistance(sound, 220)
			end
		elseif weapon == 33 or weapon == 34 then --snipers
			sound = playSound3D("sounds/weapon/sniper.wav", x,y,z)
			setSoundMaxDistance(sound, 250)
		end
		setElementDimension( sound, getElementDimension( source ) )
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), playSounds)
--]]
 -- Prze³adowanie


-----
addEventHandler("onClientExplosion", getRootElement(), function(x,y,z, theType)
	if(explosionEnabled)then
		if(theType == 0)then--Grenade
			local explSound = playSound3D("files/sfx/explosion1.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		elseif(theType == 4 or theType == 5 or theType == 6 or theType == 7)then --car, car quick, boat, heli
			local explSound = playSound3D("files/sfx/explosion3.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		end
	end
end)

--[[
--window etc.
local screenX, screenY = guiGetScreenSize()
function optionsWindow()
		
	cSoundsWindow = guiCreateWindow(screenX-220, screenY-200, 200, 150, "Sons personalizados - Opções", false)
	checkBoxEnableCSounds = guiCreateCheckBox(10, 20, 200, 20, "Ativar sons de disparo", cSoundsEnabled, false, cSoundsWindow)
	checkBoxEnableRelSounds = guiCreateCheckBox(10, 50, 200, 20, "Ativar sons de recarga", reloadSoundEnabled, false, cSoundsWindow)
	checkBoxEnableExplSounds = guiCreateCheckBox(10, 80, 200, 20, "Ativar sons de explosão", explosionEnabled, false, cSoundsWindow)
	btnCloseCSoundsWindow = guiCreateButton(10, 110, 280, 30, "Close", false, cSoundsWindow)
	
	addEventHandler("onClientGUIClick", checkBoxEnableCSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableCSounds))then
				cSoundsEnabled = true
			else
				cSoundsEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", checkBoxEnableRelSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableRelSounds))then
				reloadSoundEnabled = true
			else
				reloadSoundEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", checkBoxEnableExplSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableExplSounds))then
				explosionEnabled = true
			else
				explosionEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", btnCloseCSoundsWindow, closeCSoundsWindow, false)
	
	guiSetVisible(cSoundsWindow, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), optionsWindow)

function closeCSoundsWindow()
	if(guiGetVisible(cSoundsWindow))then
		guiSetVisible(cSoundsWindow, false)
		showCursor(false)
	else
		guiSetVisible(cSoundsWindow, true)
		showCursor(true)
	end	
end
addCommandHandler("csound", closeCSoundsWindow)

]]