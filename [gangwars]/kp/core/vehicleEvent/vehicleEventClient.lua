--[[local screenW, screenH = guiGetScreenSize()
local eventVeh = nil


function vehEventJoin( element, dim )
	if element == localPlayer and getElementData(  source, "event" ) then
		eventVeh = getElementData( source, "event")
		vehEventRenderSwitch( true )
	end
end
addEventHandler( "onClientColShapeHit", root, vehEventJoin )


function vehEventLeave( element, dim )
	if element == localPlayer and getElementData( source, "event" ) then
		eventVeh = nil
		vehEventRenderSwitch( false )
	end
end
addEventHandler( "onClientColShapeLeave", root, vehEventLeave )


function vehEventTrackingOff()
	eventVeh = nil
end
addEvent( "vehEventTrackingOff", true)
addEventHandler( "vehEventTrackingOff", root, vehEventTrackingOff )

function onClientRender( )
	if eventVeh ~= nil then
		local index = 1
		dxDrawRectangle( screenW * 0.3, screenH * 0.04, screenW * 0.4, screenH * 0.02, white )
		for key, faction in pairs(factions) do
			if faction["vehEvent"] == true then
				--outputChatBox(key)
				local factionTickets = getElementData( eventVeh, key)
				if factionTickets then
					dxDrawImage( screenW * (0.3 + (0.4 * factionTickets/180) ), screenH * 0.035, 42, 42, "files/patches/"..key..".png")
				end

			end
		end
	end
end
addEventHandler( "onClientRender", root, onClientRender )

function onClientVehicleStartEnter(player, seat, door )
	if player == localPlayer then
		local faction = getElementData( source, "faction")
		if faction then
			if faction == getElementData( player, "faction") then
			
			else
				outputChatBox( "#9A1428That vehicle doesn't belong to your faction!",nil,nil,nil,true)
				cancelEvent(  )
			end
		end
	end
end
addEventHandler( "onClientVehicleStartEnter", root, onClientVehicleStartEnter )

function onClientVehicleEnter( player, seat)	
	if player == localPlayer then
		local factionID = getElementData( source, "faction")
		if factionID then
			local faction = factions[factionID]
			if faction then
				if factionID == getElementData( player, "faction") then
					local garages = getElementsByType( "garage" )
					for key,garage in ipairs(garages) do
						if getElementData( garage, "faction") == factionID then
							local x,y,z = getElementPosition( garage )
							local blip = createBlip( x,y,z, 41, 2, nil, nil, nil, nil, -50)
							setElementData( blip, "garage", true)
						end
					end
					outputChatBox( "Take that vehicle to the position marked on your PDA map.", 255, 51, 204 )
				end
			end
		end
	end
end
addEventHandler( "onClientVehicleEnter", root, onClientVehicleEnter )

function onVehicleDelivered(  )
	local blips = getElementsByType( "blip" )
	for key,blip in ipairs(blips) do
		if getElementData( blip, "garage") == true then
			destroyElement( blip )
		end
	end
end
addEvent( "onVehicleDelivered", true )
addEventHandler( "onVehicleDelivered", root, onVehicleDelivered )
addEventHandler( "onClientVehicleExit", root, onVehicleDelivered )

local handled = false
function vehEventRenderSwitch ( data )
outputChatBox( "sw" )
	if data then
		if not handled then
			addEventHandler( "onClientRender", root, vehEventRenderScore )
			handled = true
		end
	else
		removeEventHandler( "onClientRender", root, vehEventRenderScore )
		handled = false
	end
end

function vehEventRenderScore(  )
	if vehEvent then
outputChatBox( "ren" )
		local text = ""
		for k,v in pairs( clientGangTable ) do
			if getElementData( vehEvent, k ) then
				text = text.." "..k..": "..getElementData( vehEvent, k )
			end
		end
		dxDrawText(text, screenW*0.5, screenH*0.1, nil, nil, tocolor( 160, 160, 160 ), 2, "default-bold", "center", "center" )
	end
end 
]]