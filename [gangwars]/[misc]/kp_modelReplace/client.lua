-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local modelReplaces = {
	--{fileName="files/playerskins/vclothes", skinID=82},
	{fileName="files/weapons/ak47", skinID=355},
	{fileName="files/weapons/colt45", skinID=346},
	{fileName="files/weapons/cuntgun", skinID=357},
	{fileName="files/weapons/desert_eagle", skinID=348},
	{fileName="files/weapons/m4", skinID=356},
	{fileName="files/weapons/micro_uzi", skinID=352},
	{fileName="files/weapons/mp5lng", skinID=353},
	{fileName="files/weapons/silenced", skinID=347},
	{fileName="files/weapons/tec9", skinID=372},

	{fileName="files/peds/PV2", skinID=17},

	{fileName="files/weapons/goldendildo", skinID=321},
} 

function skinsLoad() 
	for index,skin in pairs( modelReplaces ) do 
	    txd = engineLoadTXD (skin.fileName .. ".txd" ) 
	    engineImportTXD ( txd, skin.skinID ) 
	    dff = engineLoadDFF ( skin.fileName .. ".dff", 0 ) 
	    engineReplaceModel ( dff, skin.skinID ) 
   	end 
end 
addEventHandler("onClientResourceStart",resourceRoot, skinsLoad)
