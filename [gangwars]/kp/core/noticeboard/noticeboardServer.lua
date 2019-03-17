--local nbData = {}
local nbJobUid = 0
eventparent = createElement( "eventparent" )

addEvent( "nbRequest", true )
addEventHandler( "nbRequest", root, 
function ( req, arg1, arg2 )
	local pla = client
	local gang = getElementData( pla, "gang" )
	if req == "getData" then
		--triggerClientEvent( client, "nbOnGetData", client, nbData )
		local data = {}
		for k,v in ipairs( getElementChildren( eventparent ) ) do
			local eventType = getElementData( v, "eventType" )
			if eventType == "heist" then
				local heist = heistTable[getElementData( v, "heistName" )]
				if heist["open"] then
					data[#data+1] = {name=heist["name"], type="Heist", creator="Illuminati", level=heist["levelReq"], pos = heist["entrancepos"] }
				end
			elseif eventType == "custom" then
				data[#data+1] = getElementData( v, "data" )
			end
		end
		triggerClientEvent( client, "nbOnGetData", client, data )
	--[[elseif req == "createOffer" then
		if gang then

		end]]
	elseif req == "track" then
		--local job = nbData[arg1]
		if arg1 then
			outputChatBox( "[NB] "..job["name"], pla, 25,225,25 )
		else
			outputChatBox( "[NB] Error: Job is not listed anymore.", pla, 225,25,25 )
		end
	end
end )

function nbAttachEvent( el, data )
	local event = createElement( "attachedjob" )
	setElementParent( event, eventparent )
	setElementData( event, "eventType", "custom" )
	setElementData( event, "data", data )
	return event
end
--[[function nbCreateJob( data )
	if data["type"] == "heist" then
		nbJobUid = nbJobUid + 1
		data["uid"] = nbJobUid
		nbData[#nbData+1] = data
	end
end

setTimer(
function ( )
	if #nbData < 5 then
		local indexed = {}
		for k,v in pairs( heistTable ) do
			indexed[#indexed+1] = v
		end
		local heist = indexed[math.random(1,#indexed)]
		nbCreateJob( {type="heist", name=heist["name"], heist="factory", level=5, creator="Server", pos=heist["entrancepos"]} )
	end
end, 5*1000, 0 )]]

--[[addEventHandler( "onResourceStart", resourceRoot, 
function (  )
	for k,v in pairs( gangTable ) do
		if not nbData[k] then nbData[k] = {} end
	end
end )]]