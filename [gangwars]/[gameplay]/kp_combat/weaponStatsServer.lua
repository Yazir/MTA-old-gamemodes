addEventHandler( "onResourceStart", resourceRoot,
function (  )
	setWeaponProperty( "ak-47", "std", "weapon_range", 160)
	setWeaponProperty( "ak-47", "std", "accuracy", 30) --0.35
	setWeaponProperty( "ak-47", "std", "move_speed", 1.4)	
	setWeaponProperty( "ak-47", "std", "maximum_clip_ammo", 35)
	setWeaponProperty( "ak-47", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "ak-47", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "ak-47", "std", "anim_loop_stop", 0.34)
	setWeaponProperty( "ak-47", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "ak-47", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "ak-47", "std", "damage", 49)

	setWeaponProperty( "m4", "std", "weapon_range", 175)
	setWeaponProperty( "m4", "std", "accuracy", 30) --0.4
	setWeaponProperty( "m4", "std", "move_speed", 1.2)	
	setWeaponProperty( "m4", "std", "maximum_clip_ammo", 45)
	setWeaponProperty( "m4", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "m4", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "m4", "std", "anim_loop_stop", 0.35)
	setWeaponProperty( "m4", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "m4", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "m4", "std", "damage", 45)

	setWeaponProperty( "colt 45", "std", "weapon_range", 75)
	setWeaponProperty( "colt 45", "std", "accuracy", 0.5)
	setWeaponProperty( "colt 45", "std", "maximum_clip_ammo", 16)
	setWeaponProperty( "colt 45", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "colt 45", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "colt 45", "std", "anim_loop_stop", 0.35)
	setWeaponProperty( "colt 45", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "colt 45", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "colt 45", "std", "damage", 42)

	setWeaponProperty( "tec-9", "std", "weapon_range", 55)
	setWeaponProperty( "tec-9", "std", "accuracy", 0.4)
	setWeaponProperty( "tec-9", "std", "maximum_clip_ammo", 30)
	setWeaponProperty( "tec-9", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "tec-9", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "tec-9", "std", "anim_loop_stop", 0.28)
	setWeaponProperty( "tec-9", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "tec-9", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "tec-9", "std", "damage", 22)

	setWeaponProperty( "uzi", "std", "weapon_range", 45)
	setWeaponProperty( "uzi", "std", "accuracy", 0.45)
	setWeaponProperty( "uzi", "std", "maximum_clip_ammo", 50)
	setWeaponProperty( "uzi", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "uzi", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "uzi", "std", "anim_loop_stop", 0.265)
	setWeaponProperty( "uzi", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "uzi", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "uzi", "std", "damage", 19)

	setWeaponProperty( "silenced", "std", "weapon_range", 80)
	setWeaponProperty( "silenced", "std", "accuracy", 0.6)
	setWeaponProperty( "silenced", "std", "move_speed", 1.9)	
	setWeaponProperty( "silenced", "std", "maximum_clip_ammo", 12)
	setWeaponProperty( "silenced", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "silenced", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "silenced", "std", "anim_loop_stop", 0.45)
	setWeaponProperty( "silenced", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "silenced", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "silenced", "std", "damage", 45)
	--setWeaponProperty( "silenced", "std", "flag_type_dual", true)

	setWeaponProperty( "silenced", "poor", "weapon_range", 30)
	setWeaponProperty( "silenced", "poor", "accuracy", 1.5)
	setWeaponProperty( "silenced", "poor", "move_speed", 2.5)	
	setWeaponProperty( "silenced", "poor", "maximum_clip_ammo", 4)
	setWeaponProperty( "silenced", "poor", "anim_loop_start", 0.2)
	setWeaponProperty( "silenced", "poor", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "silenced", "poor", "anim_loop_stop", 0.55)
	setWeaponProperty( "silenced", "poor", "flag_aim_no_auto", true)
	setWeaponProperty( "silenced", "poor", "flag_move_and_shoot", true)
	setWeaponProperty( "silenced", "poor", "damage", 5)

	setWeaponProperty( "deagle", "std", "weapon_range", 80)
	setWeaponProperty( "deagle", "std", "accuracy", 1.1)
	setWeaponProperty( "deagle", "std", "move_speed", 2.4)	
	setWeaponProperty( "deagle", "std", "maximum_clip_ammo", 7)
	setWeaponProperty( "deagle", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "deagle", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "deagle", "std", "anim_loop_stop", 0.9)
	setWeaponProperty( "deagle", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "deagle", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "deagle", "std", "damage", 125)

	setWeaponProperty( "shotgun", "std", "weapon_range", 50)
	setWeaponProperty( "shotgun", "std", "accuracy", 1.25)
	setWeaponProperty( "shotgun", "std", "move_speed", 1.7)	
	setWeaponProperty( "shotgun", "std", "maximum_clip_ammo", 0)
	setWeaponProperty( "shotgun", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "shotgun", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "shotgun", "std", "anim_loop_stop", 1.3)
	setWeaponProperty( "shotgun", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "shotgun", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "shotgun", "std", "damage", 20)

	setWeaponProperty( "rifle", "std", "weapon_range", 180)
	setWeaponProperty( "rifle", "std", "accuracy", 0.3)
	setWeaponProperty( "rifle", "std", "move_speed", 1.6)	
	setWeaponProperty( "rifle", "std", "maximum_clip_ammo", 16)
	setWeaponProperty( "rifle", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "rifle", "std", "anim_loop_bullet_fire", 0.45)
	setWeaponProperty( "rifle", "std", "anim_loop_stop", 0.65)
	setWeaponProperty( "rifle", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "rifle", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "rifle", "std", "damage", 95)

	setWeaponProperty( "sniper", "std", "weapon_range", 240)
	setWeaponProperty( "sniper", "std", "accuracy", 0.1)
	setWeaponProperty( "sniper", "std", "move_speed", 1)	
	setWeaponProperty( "sniper", "std", "maximum_clip_ammo", 4)
	setWeaponProperty( "sniper", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "sniper", "std", "anim_loop_bullet_fire", 0.9)
	setWeaponProperty( "sniper", "std", "anim_loop_stop", 2)
	setWeaponProperty( "sniper", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "sniper", "std", "flag_move_and_shoot", false)
	setWeaponProperty( "sniper", "std", "flag_shot_anim_abrupt", true)
	setWeaponProperty( "sniper", "std", "damage", 140)

	setWeaponProperty( "mp5", "std", "weapon_range", 80)
	setWeaponProperty( "mp5", "std", "accuracy", 1)
	setWeaponProperty( "mp5", "std", "move_speed", 1.5)	
	setWeaponProperty( "mp5", "std", "maximum_clip_ammo", 30)
	setWeaponProperty( "mp5", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "mp5", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "mp5", "std", "anim_loop_stop", 0.30)
	setWeaponProperty( "mp5", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "mp5", "std", "flag_move_and_shoot", true)
	setWeaponProperty( "mp5", "std", "flag_shot_anim_abrupt", true)
	setWeaponProperty( "mp5", "std", "damage", 40)

	setWeaponProperty( "combat shotgun", "std", "damage", 35)
	setWeaponProperty( "combat shotgun", "std", "accuracy", 0.9)

	setWeaponProperty( "sawed-off", "std", "weapon_range", 35)
	setWeaponProperty( "sawed-off", "std", "accuracy", 0.8)
	setWeaponProperty( "sawed-off", "std", "move_speed", 1.5)	
	setWeaponProperty( "sawed-off", "std", "maximum_clip_ammo", 4)
	setWeaponProperty( "sawed-off", "std", "anim_loop_start", 0.2)
	setWeaponProperty( "sawed-off", "std", "anim_loop_bullet_fire", 0.2)
	setWeaponProperty( "sawed-off", "std", "anim_loop_stop", 0.4)
	setWeaponProperty( "sawed-off", "std", "flag_aim_no_auto", true)
	setWeaponProperty( "sawed-off", "std", "flag_shot_anim_abrupt", true)
	setWeaponProperty( "sawed-off", "std", "damage", 12)

	--setWeaponProperty( "ak-47", "pro", "flags", 0x000004)
	--setWeaponProperty( "ak-47", "pro", "flags", 0x000800)
	--setWeaponProperty( "ak-47", "pro", "flag_type_constant", false)
	--setWeaponProperty( "ak-47", "pro", "flag_type_dual", false)
end )