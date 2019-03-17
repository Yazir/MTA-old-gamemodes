-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

addEvent( "logReg", true )
addEventHandler( "logReg", root, 
function (login, pwd, logReg)	
	local playerAcc = getAccount( login )
	if logReg == "log" then
		if playerAcc then
			if logIn( source, playerAcc, pwd ) then
				setElementData( source, "login", true )
				loreCheck( source )
				triggerClientEvent( source, "onLogin", resourceRoot)
			else
				triggerClientEvent( source, "loginError", resourceRoot, "Error: Błędne hasło..")
			end
		else
			triggerClientEvent( source, "loginError", resourceRoot, "Error: Konto nie istnieje.")
		end
	elseif logReg == "reg" then
		if addAccount( login, pwd ) then
			playerAcc = getAccount( login )
			logIn( source, playerAcc, pwd )
			setElementData( source, "login", true )
			triggerClientEvent( source, "onLogin", resourceRoot)
			exports.kp:addMoney( source, 80 )
			loreCheck( source )
			outputChatBox( "Przywitajmy "..getPlayerName( client ).." na naszym serwerze!", root, 25,255,25 )
		else
			triggerClientEvent( source, "loginError", resourceRoot, "Error: Konto już istnieje.")
		end
	end
end )

function loreCheck( pla )
	local acc = getPlayerAccount( pla )
	if acc then
		if not getAccountData( acc, "gotLore" ) then
			triggerClientEvent( pla, "getLore", pla )
		end
	end
end

addEvent( "loreRequest", true )
addEventHandler( "loreRequest", root, 
function ( gang )
	local pla = source
	local gt = {grove=true, ballas=true, vagos=true, aztecas=true }
	if not gt[gang] then kickPlayer( pla ) return end
	if not getAccountData( getPlayerAccount( pla ), "gotLore" ) then
		setAccountData( getPlayerAccount( pla ), "gotLore", true )
		exports.kp:gangJoinPlayer( pla, gang )
	end
end )

outputDebugString( "[KP] kp_login (server.lua) start" )