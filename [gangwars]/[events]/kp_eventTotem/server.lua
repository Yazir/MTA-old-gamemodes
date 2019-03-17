-- Author: Yazir, for: mtakp.pl
-- If you want to use that coed, atleast give credits.
local MIN_PLAYERS = 6
local gangTable = nil
local totem = {}

addEventHandler( "onResourceStart", resourceRoot, 
function (  )

	totem.col = createColSphere( 1832,-1682,13, 2 )
	totem.object = createObject( 2993, 1832,-1682,13 ) setElementParent( totem.col, totem.object ) attachElements( totem.object, totem.col )
	totem.blip = createBlip( 1832,-1682,13, 53, nil, nil, nil, nil, nil, 10, 1800 ) setElementParent( totem.blip, totem.col )
	totem.state = "dropped"
	totem.owner = nil
	totem.lastOwner = nil
	totem.gang = nil
	totem.lastPos = {}

	addEvent( "onPlayerJoinLobby" )
	addEvent( "onPlayerEnterSafezone" )
	addEventHandler( "onColShapeHit", totem.col, 
	function ( el, md )
		local gang = getElementData( el, "gang" )
		gangTable = exports.kp:getGangTable()
		if isElement( el ) and getElementType( el ) == "player" and md and gang and gangTable[gang] and gangTable[gang]["perms"]["totem"] then
			if not isPedDead( el ) and not isPedInVehicle( el ) then
				if totem.state == "dropped" and totem.lastOwner ~= el then
					if #getElementsByType( "player" ) >= MIN_PLAYERS then
						--if getElementData( el, "gang" ) == "nomad" then
							exports.bone_attach:attachElementToBone( totem.object, el, 1, 0,0,0.1 )
							totem.owner = el
							totem.state = "held"
							totem.lastPos = {getElementPosition( el )}
							totem.gang = getElementData( el, "gang" )
							totem.timer = setTimer( 
							function ( )
								local x,y = getElementPosition( el )
								if getDistanceBetweenPoints2D( x,y, totem.lastPos[1], totem.lastPos[2] ) > 1 then
									exports.kp:addMoney( el, 5 )
									exports.kp:addExp( el, 2 )
									exports.kp:addWanted( el, 1 )
									playSoundFrontEnd( el, 1 )
								end
							end, 1000*10, 0 )
							totem.timer2 = setTimer( 
							function ( )
								local veh = getPedContactElement( totem.owner )
								if isElement( veh ) and getElementType( veh ) == "vehicle" then
									totemDrop( totem.owner ) return
								end
								totem.lastPos = {getElementPosition( el )}
							end, 1000, 0 )

							outputChatBox( "[Totem] Totem został wzięty przez gracza "..getPlayerName( el ).."!", root, 225,225,50 )
							addEventHandler( "onPlayerQuit", el, totemDrop )
							addEventHandler( "onPlayerSpawn", el, totemDrop )
							addEventHandler( "onPlayerWasted", el, totemDrop )
							addEventHandler( "onPlayerJoinLobby", el, totemDrop )
							addEventHandler( "onPlayerEnterSafezone", el, totemDrop )
							addEventHandler( "onPlayerVehicleEnter", el, totemDrop )
							addEventHandler( "onPlayerLeaveGangArea", el, totemDrop )
						--else
						--	outputChatBox( "[Totem] Musisz być odludkiem by móc podnieść totem.", el, 225,225,50 )
						--end
					else
						outputChatBox( "[Totem] Musi być co najmniej "..MIN_PLAYERS.." graczy online.", el, 225,225,50 )
					end
				end
			end
		end
	end )
end )

function totemDrop( pla )
	outputConsole( "drop" )
	if source and isElement( source ) and getElementType( source ) then pla = source end
	if totem.owner == pla then
		if isTimer( totem.timer ) then killTimer( totem.timer ) totem.timer = nil end
		if isTimer( totem.timer2 ) then killTimer( totem.timer2 ) totem.timer2 = nil end
		if isTimer( totem.timer3 ) then killTimer( totem.timer3 ) totem.timer3 = nil end
		totem.lastOwner = pla
		setTimer( 
		function (  )
			totem.lastOwner = nil
		end, 5000, 1 )
		exports.bone_attach:detachElementFromBone( totem.object )
		totem.state = "dropped"
		local pos = totem.lastPos
		setElementPosition( totem.object, pos[1], pos[2], pos[3]-0.1 )
		outputChatBox( "[Totem] Totem został porzucony przez gracza "..getPlayerName( pla ).."!", root, 190,190,50 )
	end
	removeEventHandler( "onPlayerQuit", pla, totemDrop )
	removeEventHandler( "onPlayerSpawn", pla, totemDrop )
	removeEventHandler( "onPlayerWasted", pla, totemDrop )
	removeEventHandler( "onPlayerJoinLobby", pla, totemDrop )
	removeEventHandler( "onPlayerEnterSafezone", pla, totemDrop )
	removeEventHandler( "onPlayerVehicleEnter", pla, totemDrop )
	removeEventHandler( "onPlayerLeaveGangArea", pla, totemDrop )
end

addEventHandler( "onPlayerQuit", root, 
function (  )
	if #getElementsByType( "player" ) and #getElementsByType( "player" ) < MIN_PLAYERS and totem.owner then
		totemDrop( totem.owner )
	end
end )

outputDebugString( "[KP] kp_eventTotem (server.lua) start" )