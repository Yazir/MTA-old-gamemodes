local taserTimers = {}
local wantedCount = {}

addEventHandler( "onClientPlayerDamage", root,
function ( att, wpn, bodypart, loss )
	if not att then return end
	if lobbys[getElementDimension( source )] then return end
	local pla = source
	local gangSource = getElementData( pla, "gang" )
	local gangAttacker = getElementData( att, "gang" )
	local wantedSource = getElementData( pla, "wanted" )
	local wantedAttacker = getElementData( att, "wanted" )
	if gangAttacker ~= "police" and gangSource == "police" then
		if pla == localPlayer then
			if not wantedCount[att] then wantedCount[att] = 0 end
			if wantedCount[att]+loss > 10 then
				triggerServerEvent( "crimeRequest", localPlayer, "warrant", att )
				wantedCount[att], loss = 0, 0
			end
			wantedCount[att] = wantedCount[att] + loss
		end
		if wantedAttacker and wantedAttacker < 4 then
			if att == localPlayer then
	            outputChatBox( "[Police] Atakowanie funkcjonariusza jest karane!", 75,133,220 )
			end
			cancelEvent(  )
		end
	end
	if gangAttacker == "police" and gangSource ~= "police" then
		if wpn == 23 then
			if wantedSource >= 5 then
				setPedWalkingStyle( pla, 120 )
				setPedWeaponSlot( pla, 0 )
				if pla == localPlayer then
					toggleControl( "jump", false )
					toggleControl( "sprint", false )
					toggleControl( "fire", false )
					toggleControl( "crouch", false )
					toggleControl( "aim_weapon", false )
				end
				if taserTimers[pla] then
					if isTimer( taserTimers[pla] ) then killTimer( taserTimers[pla] ) end
					taserTimers[pla] = nil
				end
				taserTimers[pla] = setTimer( 
				function (  )
					setPedWalkingStyle( pla, 0 )
					if pla == localPlayer then
						setPedWeaponSlot( pla, 0 )
						toggleControl( "jump", true )
						toggleControl( "sprint", true )
						toggleControl( "fire", true )
						toggleControl( "crouch", true )
						toggleControl( "aim_weapon", true )
					end
					taserTimers[pla] = nil
				end, 4000, 1 )
				cancelEvent(  )
				return
			else
				cancelEvent(  )
			end
		end
	end
	if gangAttacker == "police" then
		if gangSource == "police" then
			if gangSource == gangAttacker then
                if att == localPlayer then
                    outputChatBox( "[Police] Nie możesz skrzywdzić innego funkcjonariusza!", 75,133,220 )
                end
                cancelEvent(  )
                return
            end
		else
			if wantedSource > 0 then
        		if wpn == 3 then
        			return
        		end
        	end
	        if wantedSource < 2 then
	            if att == localPlayer then
	            	if wpn == 23 then
	                	outputChatBox( "[Police] Paralizator działa jedynie na poszukiwanych graczach!", 75,133,220 )
	            	else
	                	outputChatBox( "[Police] Nie możesz krzywdzić nie poszukiwanych graczy!", 75,133,220 )
	            	end
	            end
	            cancelEvent(  )
	            return
	        end
	   end
    end
end )