function addWanted( pla, val )
	local wanted = getElementData( pla, "wanted" )
	if not wanted then wanted = 0 end
	if wanted > 250 then return end
	playSoundFrontEnd( pla, 15 )
	setElementData( pla, "wanted", wanted+val )
end

function finePlayer( pla, finer )
	local wanted = getElementData( pla, "wanted" )
	if wanted > 0 then
		local amm = math.floor(-1.5*wanted)
		addMoney( pla, amm )
		outputChatBox( "[Crime] Zostałeś złapany i straciłeś "..math.abs( amm ).."$!", pla, 204,40,105 )
		if finer then
			local finerAmm = math.floor( math.abs( amm*0.8 ) )
			addMoney( finer, finerAmm )
			outputChatBox( "[Crime] Złapałeś poszukiwanego i zdobyłeś "..finerAmm.."$!", finer, 50,132,255 )
		end
		
		setElementData( pla, "wanted", 0 )
	end
end

addEventHandler( "onPlayerDamage", root, 
function ( att, wpn, bd, loss )
	--outputChatBox( getPlayerName( source ).." "..tostring(att).." "..tostring(bd).." "..tostring(loss) )
	local pla = source
	local dim = getElementDimension( pla )
	if not lobbys[dim] and isElement( att ) and getElementType( att ) == "player" then
		local gang1 = getElementData( pla, "gang" )
		local gang2 = getElementData( att, "gang" )
		local wanted = getElementData( pla, "wanted" )
		--if gang1 == "police" and gang2 ~= "police" then
		--	outputChatBox( "test" )
		--	addWanted( att, 1 )
		if gang2 == "police" then
			if wanted > 0 then
				if wpn == 3 then
					finePlayer( pla, att )
				end
			end
		end
	end
end )

addEvent( "crimeRequest", true )
addEventHandler( "crimeRequest", root, 
function ( req, arg1 )
	local pla = client
	if req == "warrant" then
		addWanted( arg1, 1 )
	end
end )

setTimer( 
function (  )
	for k,v in ipairs( getElementsByType( "player" ) ) do
		local wanted = getElementData( v, "wanted" )
		if wanted and wanted > 0 then
			setElementData( v, "wanted", wanted-1 )
		end
	end
end, 1000*60*3, 0 )