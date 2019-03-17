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
			outputChatBox( "Welcome to die, "..getPlayerName( client ).."!", root, 25,255,25 )
		else
			triggerClientEvent( source, "loginError", resourceRoot, "Error: Konto już istnieje.")
		end
	end
end )

outputDebugString( "[KP] kps_login (server.lua) start" )