-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local modelReplaces = {
	--{fileName="files/playerskins/vclothes", skinID=82},
	{fileName="files/weapons/ak47", skinID=355},
	{fileName="files/weapons/desert_eagle", skinID=348},
	{fileName="files/weapons/mp5lng", skinID=353},

	{fileName="files/peds/sas", skinID=108, roz="txd"},
	{fileName="files/peds/sas1", skinID=108, roz="dff"},
	{fileName="files/peds/sas", skinID=109, roz="txd"},
	{fileName="files/peds/sas2", skinID=109, roz="dff"},
	{fileName="files/peds/sas", skinID=110, roz="txd"},
	{fileName="files/peds/sas3", skinID=110, roz="dff"},
	{fileName="files/peds/sas", skinID=111, roz="txd"},
	{fileName="files/peds/sas4", skinID=111, roz="dff"},
	{fileName="files/peds/sas", skinID=112, roz="txd"},
	{fileName="files/peds/sas5", skinID=112, roz="dff"},
	{fileName="files/peds/sas", skinID=113, roz="txd"},
	{fileName="files/peds/sas6", skinID=113, roz="dff"},
} 

function skinsLoad() 
	for index,skin in pairs( modelReplaces ) do
		if skin.roz == "txd" or not skin.roz then 
	    	txd = engineLoadTXD (skin.fileName .. ".txd" ) 
	    	engineImportTXD ( txd, skin.skinID )
	    end
	    if skin.roz == "dff" or not skin.roz then
		    dff = engineLoadDFF ( skin.fileName .. ".dff", 0 ) 
		    engineReplaceModel ( dff, skin.skinID )
		end
   	end 
end 
addEventHandler("onClientResourceStart",resourceRoot, skinsLoad)