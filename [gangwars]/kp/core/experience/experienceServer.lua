function addExp( pla, val )
	if pla and getElementType( pla ) == "player" then
		local multi = 1
		if getElementData( pla, "expMulti", false ) then multi = getElementData( pla, "expMulti", false ) end
		val = val*multi
		local acc = getPlayerAccount( pla )
		setElementData( pla, "exp", getElementData( pla, "exp" ) + val )
		setAccountData( acc, "exp", getElementData( pla, "exp" ) )
		checkExp(pla)
		writeLog("exp", "Player: " .. getPlayerName( pla ) .. "(" .. getAccountName( getPlayerAccount( pla ) ) .. " , " .. getAccountSerial( getPlayerAccount( pla ) ) .. ")" .. " has been given EXP " .. val .. "(" .. getElementData( pla, "exp" ) .. ")" )
		return val
	end
end

function checkExp( pla )
	if not expAtLvl(5) then return end
	local acc = getPlayerAccount( pla )
	local exp = getElementData( pla, "exp" )
	local lvl = getElementData( pla, "lvl" )
	while exp >= expAtLvl(lvl) do
		setElementData( pla, "lvl", lvl+1 )
		lvl = getElementData( pla, "lvl" )
		setAccountData( acc, "lvl", lvl )
	end
end

function addMoney( pla, val, boolBlockMulti, boolBlockAdd )
	local multi = 1
	if getElementData( pla, "moneyMulti", false ) and not boolMulti then multi = getElementData( pla, "moneyMulti", false ) end
	val = val*multi
	if not boolAdd then
		givePlayerMoney( pla, val )
		writeLog("money", "Player: " .. getPlayerName( pla ) .. "(" .. getAccountName( getPlayerAccount( pla ) ) .. " , " .. getAccountSerial( getPlayerAccount( pla ) ) .. ")" .. " has been given MONEY " .. val .. "(" .. getPlayerMoney( pla ) .. ")" )
	end
	return val
end



addCommandHandler( "addexp",
function(pla,cmd,arg, arg2)
	outputChatBox( "Init.", pla )
	if getAccountName(getPlayerAccount( pla )) ~= "Yazir" then return end
	addExp(getPlayerFromName( arg ), tonumber(arg2))
	outputChatBox( "Done.", pla )
end )

addCommandHandler( "resetexp",
function ( pla, cmd, arg )
	outputChatBox( "Init.", pla )
	if getAccountName(getPlayerAccount( pla )) ~= "Yazir" then return end 
	setElementData( getPlayerFromName( arg ), "lvl", 1 ) 
	setElementData( getPlayerFromName( arg ), "exp", 0 )
	savePlayer(getPlayerFromName( arg ))
	outputChatBox( "Done.", pla )
end )