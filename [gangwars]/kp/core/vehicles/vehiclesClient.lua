local sX, sY = guiGetScreenSize()

function createGUISalon()
	if not guis then
	guis = {}
	guis[1] = guiCreateWindow((sX - 380)*0.05, (sY - 380)/2, 380, 380, "[KP] Vehicle shop", false)
	guis[2] = guiCreateGridList(10, 23, 360, 310, false, guis[1])
	guis[3] = guiGridListAddColumn(guis[2], "Vehicle", 0.45)
	guis[4] = guiGridListAddColumn(guis[2], "Cost", 0.2)
	guis[7] = guiGridListAddColumn(guis[2], "Patron?", 0.2)
	guis[5] = guiCreateButton(10, 340, 80, 30, "Close", false, guis[1])
	guis[6] = guiCreateButton(290, 340, 80, 30, "Buy", false, guis[1])
	
	addEventHandler("onClientGUIClick", guis[5], onSalonClickZamknij, false)
	addEventHandler("onClientGUIClick", guis[6], onSalonClickKup, false)

	addEvent( "onSalonVehiclePreview" )
	addEventHandler( "onClientGUIClick", guis[2],
	function ( but )
		if but == "left" then
			local sel = guiGridListGetSelectedItem( guis[2] )
			if sel > 0 then
				triggerEvent( "onSalonVehiclePreview", localPlayer )
				setElementFrozen( localPlayer, true )
				local veh = createVehicle( guiGridListGetItemData( guis[2], sel, 1 ), 833.91558837891,-2059.8625488281,12.476685523987, 0,0,185 )
				local vehShowRotTimer = setTimer(
				function (  )
					local rx,ry,rz = getElementRotation( veh )
					setElementRotation( veh, 0, 0, rz+0.4 )
				end, 50, 0 )
				setCameraMatrix( 830.55450439453,-2067.2778320313,14 , 833.91558837891,-2059.8625488281,12.476685523987 )
				addEventHandler( "onSalonVehiclePreview", localPlayer, 
				function (  )
					if isElement( veh ) then destroyElement( veh ) end
					if isTimer( vehShowRotTimer ) then killTimer( vehShowRotTimer ) end
				end )
			end
		end
	end )
	
	end
	guiGridListClear(guis[2])
	guiSetVisible(guis[1], true)
	showCursor(true)
end

addEvent("pokazGUISalonu", true)
addEventHandler("pokazGUISalonu", getRootElement(),
function(pojazdy)
createGUISalon()
	for i,v in pairs(pojazdy) do
	local name = getVehicleNameFromModel(i)
		if name then --istnieje taki pojazd
			local row = guiGridListAddRow(guis[2], getVehicleNameFromModel(i), v[1], zwrocPoziomPatrona(v[2]))
			guiGridListSetItemData(guis[2], row, 1, i)
		end
	end
end)

function zwrocPoziomPatrona( poziom )
	if 		poziom == 0 then return "Nie"
	elseif 	poziom == 1 then return "Donator"
	elseif 	poziom == 2 then return "Patron" end
end


function onSalonClickZamknij()
	if guis and guiGetVisible( guis[1] ) then 
		triggerEvent( "onSalonVehiclePreview", localPlayer )
		setCameraTarget( localPlayer, localPlayer )
		guiSetVisible(guis[1], false)
		showCursor(false)
		setElementFrozen( localPlayer, false )
	end
end

function onSalonClickKup()
local row, column = guiGridListGetSelectedItem(guis[2])
	if row ~= -1 then
	local id = guiGridListGetItemData(guis[2], row, guis[3])
		if id then
			triggerServerEvent("kupPojazdSalon", localPlayer, id)
		end
	end
end

addEvent("potwierdzKupnoPojazduPrywatnego", true)
addEventHandler("potwierdzKupnoPojazduPrywatnego", getRootElement(),
function()
	onSalonClickZamknij()
end)

--[[
	Oznaczenia pojazdow od gracza (widoczne na mapie F11)
--]]

addEvent("zwrocPojazdyGracza", true)
addEventHandler("zwrocPojazdyGracza", getRootElement(),
function(pojazdy)
blipy = {}
	for i,v in pairs(pojazdy) do
		if isElement(v) then
			local blip = createBlipAttachedTo(v, 0, 1, 100,100,100,175, 0, 500)
			table.insert(blipy, blip)
		end
	end
end)

addEventHandler( "onClientPlayerSpawn", localPlayer, 
function (  )
	if blipy then
		for i,v in pairs(blipy) do
			if isElement(v) then
				destroyElement(v)
			end
		end
	end
	triggerServerEvent("pobierzPojazdyGracza", localPlayer)
end )



--[[
local vehicles = { }
function vehicles.onRender()
    local x, y, z = getElementPosition(getLocalPlayer())
    for k, v in pairs(getElementsByType("vehicle")) do
        local x2, y2, z2 = getElementPosition(v)
        if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then
            if getElementData(v, "pojazd:wlasciciel") ~= nil then
                local sx, sy = getScreenFromWorldPosition(x2, y2, z2+1)
                if sx and sy then
                    dxDrawText(getElementData(v, "pojazd:wlasciciel"), sx, sy, sx, sy-10, tocolor(0, 0, 0, 255), 0.5, "default", "center")
                    dxDrawText(getElementData(v, "pojazd:wlasciciel"), sx+2, sy-2, sx, sy, tocolor(255, 255, 255, 255), 0.5, "default", "center")
                end
            end
        end
    end
end
addEventHandler("onClientRender", getRootElement(), vehicles.onRender) ]]