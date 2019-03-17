addEventHandler( "onClientPlayerDamage", root,
function ( att, wpn, bodypart, loss )
    if isElement( att ) and getElementType( att ) then
    
        local pla = source
        local dim = getElementDimension( pla )
        if dim ~= 0 then return end

        local job1 = getElementData( pla, "job" )
        local job2 = getElementData( att, "job" )
        if job2 == "medic" then
        	if wpn == 14 then
        		local hp = getElementHealth( pla )
        		if hp < 100 then
        			--setElementHealth( pla, hp )
                    if att == localPlayer then
                        triggerServerEvent( "medicRequest", localPlayer, "heal", pla, loss*8 )
                    end
                end
        	end
       		cancelEvent(  )
        end
    end
end )