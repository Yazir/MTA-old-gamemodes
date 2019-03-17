

--[[
property: The property you want to set the value of:
"weapon_range" - float
"target_range" - float - Max targeting range
"accuracy" - float
"damage" - int - Note: Changing the standard M4 stat will change how much damage vehicle guns (e.g: Rustler) do.
"maximum_clip_ammo" - int
"move_speed" - float - How fast player can move with weapon
"flags" - int - (specify a flag to toggle it on/off) See Weapon Flags
"flag_aim_no_auto" - bool - Disable auto up/down for non-aimed firing
"flag_aim_arm" - bool - Uses other arm for aiming
"flag_aim_1st_person" - bool - Uses 1st person aim
"flag_aim_free" - bool - Can only use free aiming
"flag_move_and_aim" - bool - Can move and aim at same time
"flag_move_and_shoot" - bool - Can move and fire at same time
"flag_type_throw" - bool - Is a throwing weapon
"flag_type_heavy" - bool - Can't jump
"flag_type_constant" - bool - Fires every frame within loop (ie paint spray)
"flag_type_dual" - bool - Can use 2x guns at same time
"flag_anim_reload" - bool - Weapon has reload anims
"flag_anim_crouch" - bool - Has crouching anims
"flag_anim_reload_loop" - bool - Loop from end of reload to fire loop start
"flag_anim_reload_long" - bool - Force a longer reload time
"flag_shot_slows" - bool - Slows down (area effect)
"flag_shot_rand_speed" - bool - Random speed (area effect)
"flag_shot_anim_abrupt" - bool - Force the anim to finish player after aim/fire rather than blending out (area effect)
"flag_shot_expands" - bool - Expands (area effect)
"anim_loop_start" - float - Start of aimed firing animation loop
"anim_loop_stop" - float - End of aimed firing animation loop (Reduce to increase firing rate)
"anim_loop_bullet_fire" - float - Time in aimed firing animation when weapon should be fired (Must be between Start and End)
"anim2_loop_start" - float - Start of non-aimed firing animation2 loop
"anim2_loop_stop" - float - End of non-aimed firing animation2 loop
"anim2_loop_bullet_fire" - float - Time in non-aimed firing animation2 when weapon should be fired (Must be between Start and End)
"anim_breakout_time" - float - Time after which player can break out of attack and run off
]]

addEventHandler( "onPlayerDamage", root, 
function ( attacker, weapon, bodypart, loss )
	if attacker and getElementData( attacker, "headshotMulti" ) and bodypart == 9 then
		playSoundFrontEnd( attacker, 29 )
		--playSoundFrontEnd( attacker, 17 )
		playSoundFrontEnd( attacker, 43 )
		local helmet = getElementData( source, "helmet" )
		bonusDmg = loss * getElementData( attacker, "headshotMulti" ) - loss
		if helmet > 0 and weapon ~= 34 then
			bonusDmg = 0
			if helmet > 0 then
				setElementData( source, "helmet", helmet-1 )
				helmet = helmet-1
				--outputDebugString("Remove helmet point")
				if helmet == 0 then
					triggerEvent( "onPlayerHelmetDestroy", source )
					--outputDebugString("DESTROY helmet")
				end
			end
		end
		if weapon == 34 then bonusDmg = 666 end
		
		local hp = getElementHealth( source )
		if hp-loss-bonusDmg <= 0 then
			killPed( source, attacker, weapon, bodypart )
		else
			setElementHealth( source, hp-bonusDmg )
		end
		--outputChatBox("Damage: " .. loss .. " Headshot Damage: " .. bonusDmg )
	end
end )

--[[
addEventHandler( "onPlayerWeaponFire", root,
function ( wep, eX, eY, eZ, hitE, sX, sY, sZ )
	local amm = getPedTotalAmmo( source )
	local clip = getPedAmmoInClip( source )
	outputChatBox( tostring( amm ) )
	takeWeapon( source, wep, amm )
	giveWeapon( source, wep, amm-1, true )
end ) 
]]

--[[
addEvent( "onSlotInfo", true )
addEventHandler( "onSlotInfo", resourceRoot,
    function ( slotinfo )
        for _,player in ipairs(getElementsByType("player")) do
            local slotServer = getPedWeaponSlot(player)
            local slotClient = slotinfo[player]
            if slotServer ~= slotClient then
                setPedWeaponSlot( player, 0 )
                setPedWeaponSlot( player, slotServer )
                outputDebugString( "onSlotInfo"
                            .. " client:" .. tostring(getPlayerName(client))
                            .. " player:" .. tostring(getPlayerName(player))
                            .. " slotServer:" .. tostring(slotServer)
                            .. " slotClient:" .. tostring(slotClient)
                                )
            end
        end
    end
)
]]