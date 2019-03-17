jobMarkerParent = createElement( "jobMarkerParent" )
addEvent( "onJobInit" )

function createJobMarker( x,y,z, data )
	local job = data["job"]
	local marker = createMarker( x, y, z, "cylinder", 1.5, 200,200,0, 180 )
	setElementData( marker, "jobName", data )
	setElementParent( marker, jobMarkerParent ) -- setElementData( marker, "eventType", "job", false )]
	nbAttachEvent( marker, {name=(job:gsub("^%l", string.upper)), type="Job", creator="Illuminati", level=1, pos = {x,y,z}} )
	if data["blip"] then createBlip( x, y, z, data["blip"], nil, nil,nil,nil,nil,3, 500 ) end

	local text = "Praca: "..job
	if data["gang"] then text = text.."\nOrganizacja: "..data["gang"] end
	create3dText( x,y,z+1.8, text, 25, {255,255,0}, 1.8 )
	return marker
end

local jobPlayersInMarkers = {}

addEventHandler( "onMarkerHit", jobMarkerParent, 
function ( pla, md )
	if md and isElement( pla ) and getElementType( pla ) == "player" then
		local plaJob = getElementData( pla, "job" )
		local markData = getElementData( source, "jobName" )
		if markData["gang"] and getElementData( pla, "gang" ) ~= markData["gang"] then
			outputChatBox( "[Job] To nie praca dla twojej organizacji!",pla, 225,25,25 ) return
		end
		jobPlayersInMarkers[pla] = source
		if plaJob then
			if plaJob == markData["job"] then
				outputChatBox( "[Job] Jesteś już w tym zawodzie.", pla, 0,200,200 )
			else
				outputChatBox( "[Job] Aby zacząć tutaj pracować, musisz wyjśc z aktualnej pracy (/job leave).", pla, 0,200,200 )
			end
		else
			outputChatBox( "[Job] Napisz '/job join' aby zostać: "..markData["job"].."!", pla, 0,200,200 )
		end
	end
end )

addEventHandler( "onMarkerLeave", jobMarkerParent,
function ( pla, md )
	if md and isElement( pla ) and getElementType( pla ) == "player" then
		jobPlayersInMarkers[pla] = nil
	end
end )


addCommandHandler( "job",
function ( pla, cmd, arg, arg2 )
	local plaJob = getElementData( pla, "job" )
	if arg == "leave" then
		if plaJob then
			setElementData( pla, "job", nil )
			outputChatBox( "[Job] Opuściłeś swoją pracę.", pla, 0,255,200 )
		else
			outputChatBox( "[Job] Nie masz pracy którą możesz opuścić!", pla, 225,25,25 )
		end
	elseif arg == "join" then
		local jobMarker = jobPlayersInMarkers[pla]
		if jobMarker then
			if not plaJob then
				local markData = getElementData( jobMarker, "jobName" )
				setElementData( pla, "job", markData["job"] )
				triggerEvent( "onJobInit", pla, markData["job"] )
				outputChatBox( "[Job] Zacząłeś pracę jako: "..markData["job"]..".",pla, 0,255,200 )
			else
				outputChatBox( "[Job] Opuść najpierw aktualną pracę (/job leave)!",pla, 225,25,25 )
			end
		else
			outputChatBox( "[Job] Nie jesteś w żadnym punkcie pracy!",pla, 225,25,25 )
		end
	end
end )

addEventHandler( "onPlayerSpawn", root, 
function (  )
	setTimer( triggerEvent, 2000, 1, "onJobInit", source, getElementData( source, "job" ) )
end )

addEventHandler( "onPlayerGangChange", root,
function (  )
	setElementData( source, "job", nil )
end )