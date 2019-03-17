widToName = {
	[30] = "Kałasznikow",
	[31] = "M4",
	--[4] = "Knife",
	[9] = "Piła mechaniczna",
	[22] = "Colt",
	[24] = "Deagle",
	[25] = "Strzelba",
	[26] = "Strzelba krótkolufowa",
	[27] = "Strzelba bojowa",
	[28] = "Uzi",
	[32] = "Tec-9",
	[29] = "MP5",
	[33] = "Karabin wyborowy",
	[34] = "Karabin snajperski",
	[16] = "Granat",
	[18] = "Koktajl mołotowa",
	[39] = "C4",
	--[1] = "Brassknuckle",
	[23] = "Colt z tłumikiem",
	--[37] = "Flamethrower",
}

itemTable = {
	-- name, weight, usage, param1(wid), param2(ammo), model
	{name=widToName[30], weight=5, usage="equip", wid=30, ammo=30, model=355, sort="UZBROJENIE"},
	{name=widToName[31], weight=6, usage="equip", wid=31, ammo=50, model=356, sort="UZBROJENIE"},
	--{widToName[4], 2, "equip", 4,1, 335, nil, nil, sort="Weapons"},
	{name=widToName[9], weight=5, usage="equip", wid=9, ammo=1, model=341, sort="UZBROJENIE"},
	{name=widToName[22], weight=2, usage="equip", wid=22, ammo=34, model=346, sort="UZBROJENIE"},
	{name=widToName[24], weight=3, usage="equip", wid=24, ammo=14, model=348, sort="UZBROJENIE"},
	{name=widToName[25], weight=5, usage="equip", wid=25, ammo=8, model=349, sort="UZBROJENIE"},
	{name=widToName[26], weight=3, usage="equip", wid=26, ammo=10, model=350, sort="UZBROJENIE"},
	{name=widToName[27], weight=8, usage="equip", wid=27, ammo=7, model=351, sort="UZBROJENIE"},
	{name=widToName[28], weight=3, usage="equip", wid=28, ammo=50, model=352, sort="UZBROJENIE"},
	{name=widToName[32], weight=3, usage="equip", wid=32, ammo=50, model=372, sort="UZBROJENIE"},
	{name=widToName[29], weight=4, usage="equip", wid=29, ammo=30, model=353, sort="UZBROJENIE"},
	{name=widToName[33], weight=5, usage="equip", wid=33, ammo=16, model=357, sort="UZBROJENIE"},
	{name=widToName[34], weight=6, usage="equip", wid=34, ammo=4, model=358, sort="UZBROJENIE"},
	{name=widToName[16], weight=4, usage="equip", wid=16, ammo=2, model=342, sort="UZBROJENIE"},
	{name=widToName[18], weight=4, usage="equip", wid=18, ammo=3, model=344, sort="UZBROJENIE"},
	{name=widToName[39], weight=4, usage="equip", wid=39, ammo=1, model=363, sort="UZBROJENIE"},
	--{widToName[1], 2, "equip", 1, 1, 331, nil, nil, sort="Weapons"},
	{name=widToName[23], weight=2, usage="equip", wid=23, 32, model=347, sort="UZBROJENIE"},
	--{widToName[37], 2, "equip", 37, 50, 361, nil, nil, sort="Weapons"},

	-- name, weight, usage, hp, time, model
	{name="Bandage", weight=2, usage="heal", hp=30, time=25, model=1575, sort="LECZNICZE"},
	{name="Morphine", weight=2, usage="heal", hp=50, time=20, model=1578, sort="LECZNICZE"},
	--{"Adrenaline", 4, "heal", 25, 5, 1577, sort="Weapons"},
	--{"Painkillers", 3, "heal", 75, 30, 1950, sort="Weapons"},
	--{"Blood Pack", 2, "heal", 100, 60, 1580, sort="Weapons"},
	--{"Stapler", 1, "heal", 10, 1, 1579, sort="Weapons"},
	{name="Medic Kit", weight=1, usage="heal", hp=80, time=45, model=1576, sort="LECZNICZE"},

	-- name, weight, usage, kevlar amm
	{name="Kevlar", weight=5, usage="kevlar", kevlarAmm=20, model=373, sort="OCHRONA"},
	{name="Kevlar+", weight=5, usage="kevlar", kevlarAmm=25, model=373, sort="OCHRONA"},

	-- name, weight, usage, hits taken
	{name="Nazi helmet", weight=5, usage="helmet", hits=3, model=2053, sort="OCHRONA"},
	{name="US helmet", weight=5, usage="helmet", hits=4, model=2052, sort="OCHRONA"},

	{name="Signal ammo pack", weight=3, usage="ammoSignal", ammoCount=5, model=2061, sort="DODATKOWE"},
}

vehicleIDS = {
    602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585, 405, 587,
    409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529,
    581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 552, 431,
    438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 528, 428, 523, 470, 598, 499, 588, 609, 403, 498, 514,
    524, 423, 414, 578, 443, 515, 406, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 582, 413, 440, 536,
    575, 534, 567, 535, 576, 412, 402, 542, 603, 475, 568, 557, 424, 471, 504, 495, 457, 539, 483,
    508, 571, 500, 444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489,
    505, 479, 442, 458
}

shopTable = {
	["Weapon skins"] = {
		--{"AK-47 | Dragon Penis", 6969, "wepskin"},
	},
	["Player skins"] = {
		{"(F)Harley Quinn", 5000, "pedskin", "skinHarley"},
		--{"(F)Chicago Bull", 550, "pedskin", 64},
		{"(M)Clothes-V", 2500, "pedskin", "skinGtav"},
	},
	["CJ clothes"] = {
		--{"Gimp mask", 50, "cjclothing"},
	},
}


--{61.036643981934,-209.74468994141,2.5670046806335},



function expAtLvl( lvl )
	if lvl == 0 then return 0
	elseif lvl == 1 then return 50
	else return math.floor(lvl *50*(1+lvl/8)+50)
	end
end

function lerp(a, b, t)
    return a * (1-t) + (b*t)
end

function bizCostAtLevel( lvl )
	return 1500 + 750 * lvl
end

function clMaxMembers( bizModf )
	if type( bizModf ) == "string" then bizModf = fromJSON( bizModf ) end
	if type( bizModf ) ~= "table" then bizModf = {} end
	if not bizModf["brothel"] then bizModf["brothel"] = 0 end
	return 4 + 2*tonumber( bizModf["brothel"] )
end

function clMaxBiz( bizModf )
	if type( bizModf ) == "string" then bizModf = fromJSON( bizModf ) end
	if type( bizModf ) ~= "table" then bizModf = {} end
	if not bizModf["crib"] then bizModf["crib"] = 0 end
	return 3 + math.floor( 1.5*tonumber( bizModf["crib"] ) )
end

function clBizPrice( bizModf, level )
	if type( bizModf ) == "string" then bizModf = fromJSON( bizModf ) end
	if type( bizModf ) ~= "table" then bizModf = {} end
	if not bizModf["count"] then bizModf["count"] = 0 end
	return 500 + (bizModf["count"])*750 + 100*(2^level)
end

function table.count( table )
	local count = 0
	for k,v in pairs( table ) do
		count = count+1
	end
	return count
end

function create3dText( x,y,z,text,dist,color,size )
    local element = createElement( "3dText" )
    setElementPosition( element, x,y,z )
    setElementData( element, "text", text )    
    setElementData( element, "dist", dist )    
    setElementData( element, "color", color )
    setElementData( element, "size", size )
    return element
end

