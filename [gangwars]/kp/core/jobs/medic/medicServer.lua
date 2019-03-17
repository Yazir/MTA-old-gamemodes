local jobMarker = createJobMarker( 1177.7136230469,-1323.9197998047,13.3, {job="medic", blip=22, gang="civilian"} )

createVehMarker( 1179.2614746094,-1308.5650634766,12.9, {veh=416, job="medic", rz=270} )

addEventHandler( "onJobInit", root, 
function ( job )
	local pla = source
	if job and job == "medic" then
		--outputChatBox( "test" )
		giveWeapon( pla, 14, 1, true )
		saveWeapons( pla )
		setElementModel( pla, 275 )
		loadWeapons( pla )
	end
end )

addEvent( "medicRequest", true )
addEventHandler( "medicRequest", root, 
function ( req, arg1, arg2 )
	if req == "heal" then
		local loss = arg2
		local pla = arg1
		local hp = getElementHealth( pla )
		if hp < 100 then
			if hp+loss > 100 then loss = hp+loss-100 end
			setElementHealth( pla, hp+loss )
			local money = math.floor( loss/4 )
			if getPlayerMoney( pla ) > 10 + money then
				addMoney( pla, -money )
				addMoney( client, money )
				outputChatBox( "[Job:Medic] "..getPlayerName( client ).." uleczył cię za "..money.."$.", pla, 120,250,120 )
				outputChatBox( "[Job:Medic] Uleczyłeś "..getPlayerName( pla ).." za "..money.."$.", client, 120,250,120 )
			end
		end
	end
end )