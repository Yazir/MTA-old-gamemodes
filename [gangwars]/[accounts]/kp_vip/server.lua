-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.



function initAccVip ( acc )
	local pla = getAccountPlayer( acc )
	local vipLevel = getAccountData( acc, "vipLevel" )
	local vipTimestamp = getAccountData( acc, "vipTimestamp" )
	if vipTimestamp then
		local curTime = getRealTime()
		local vipTime = getRealTime( vipTimestamp )
		local timeLeft = vipTimestamp - curTime["timestamp"]
		if timeLeft > 0 then
			outputVipTimeLeft( pla, timeLeft )
		else
			outputChatBox( "[Patron] Patron status expired.", pla, 255,161,0 ) -- dark gold
			setAccountData( acc, "vipTimestamp", false )
			setAccountData( acc, "vipLevel", false )
			vipLevel = false
		end

		if vipLevel then
			setElementData( pla, "vipLevel", vipLevel )
			if vipLevel == 1 then
				setElementData( pla, "expMulti", 1.2, false )
				setElementData( pla, "moneyMulti", 1.2, false )
				setElementData( pla, "chatColors", {room="#e39b42", name="#d6be2c", msg="#e5d854"}, false )
			elseif vipLevel == 2 then
				setElementData( pla, "expMulti", 1.5, false )
				setElementData( pla, "moneyMulti", 1.5, false )
				setElementData( pla, "chatColors", {room="#c1793e", name="#e8b03a", msg="#f9f7d9"}, false )
			end
		end
	end
end
addEventHandler( "onPlayerLogin", root, function(_,acc) initAccVip( acc ) end )

addEventHandler( "onResourceStart", resourceRoot, 
function (  )
	for k,v in ipairs( getElementsByType( "player" ) ) do
		if getElementData( v, "login" ) then
			initAccVip( getPlayerAccount( v ) )
		end
	end
end )

local hats = {905,743,928,1240,1238,1254,1371,1598,1736,2114,2226,2316,2803,14705}
addEvent( "onHatEquip" )
addCommandHandler( "hat", 
function ( pla, cmd, arg )
	if not getElementData( pla, "vipLevel" ) then return end
	if not arg then triggerEvent( "onHatEquip", pla ) return end
	arg = tonumber( arg )
	if type( arg ) == "number" and hats[arg] then
		--local x,y,z = getElementPosition( pla )
		local hat = createObject( hats[arg], 0,0,0 )
		exports.bone_attach:attachElementToBone( hat, pla, 1 )
		triggerEvent( "onHatEquip", pla )
		addEventHandler( "onHatEquip", pla,
		function (  )
			if isElement( hat ) then
				exports.bone_attach:detachElementFromBone( hat )
				destroyElement( hat )
			end
		end )
	else
		outputChatBox( "[Hats] There is no hat on that id.", pla, 255,161,0 ) -- dark gold
	end
end )

addCommandHandler( "addvip", 
function ( cmdpla, cmd, plaName, setVipLevel, addTime )
	if not getAccountName( getPlayerAccount( cmdpla ) ) == "Yazir" then return end
	setVipLevel=tonumber( setVipLevel ) addTime=tonumber( addTime )*60*60*24
	if not plaName or not addTime or not addTime then outputChatBox( "Error", cmdpla ) return end

	local pla = getPlayerFromName( plaName )
	if pla then
		local acc = getPlayerAccount( pla )
		local timestamp = getRealTime( )["timestamp"]
		local vipLevel = getAccountData( acc, "vipLevel" )
		local vipTimestamp = getAccountData( acc, "vipTimestamp" )
		if vipLevel then
			if vipTimestamp > timestamp then
				timestamp = vipTimestamp
			end
		end
		timestamp = timestamp+addTime
		setAccountData( acc, "vipLevel", setVipLevel )
		setAccountData( acc, "vipTimestamp", timestamp )
		outputChatBox( "Done.", cmdpla )
	end
end )

addCommandHandler( "vip", 
function ( pla )
	local vipTimestamp = getAccountData( getPlayerAccount( pla ), "vipTimestamp" )
	if vipTimestamp then
		local timeLeft = vipTimestamp - getRealTime()["timestamp"]
		if timeLeft > 0 then
			outputVipTimeLeft( pla, timeLeft )
		end
	end
end )

function outputVipTimeLeft( pla, tl )
	local m = math.floor( ( tl / 60) % 60 )
	local h = math.floor( ( tl / 60 / 60) % 24 )
	local d = math.floor( ( tl / 60 / 60 / 24) )
	outputChatBox( "[Patron] Patron status "..d.." days, "..h.." hours, "..m.." minutes left.", pla, 255,195,0 ) -- gold
end

outputDebugString( "[KP] kp_vip (server.lua) start" )


