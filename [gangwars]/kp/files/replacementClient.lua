local modelReplaces = {
	{fileName="files/playerskins/vclothes", skinID=82},
	{fileName="files/playerskins/grom", skinID=248},
    {fileName="files/playerskins/harley", skinID=63},
	{fileName="files/playerskins/diesel", skinID=16},

	--{fileName="files/vehicles/policels", skinID=596},
	--{fileName="files/vehicles/policeranger", skinID=599},
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
