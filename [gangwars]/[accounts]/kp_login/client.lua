-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.
local screenW, screenH = guiGetScreenSize()

addEvent( "onLogin", true )

addEventHandler( "onClientResourceStart", resourceRoot, 
function ( )
    if not getElementData( localPlayer, "login" ) then
        setTimer( startLogin, 1500, 1 )
    end
end )

function startLogin( )
    if getElementData( localPlayer, "login") == false then
        --loginWindow = guiCreateWindow(screenW/2-164, screenH/2, 329,167, "Login", false)
        loginWindow = guiCreateStaticImage( screenW/2-164, screenH/2-83, 329,167, "bodylogin.png", false )
        loginLabel = guiCreateLabel(25, 3, 120,33, "Login", false, loginWindow) guiLabelSetColor( loginLabel, 139, 26, 30 ) guiLabelSetHorizontalAlign( loginLabel, "center" )
        passwordLabel = guiCreateLabel(185, 3, 120, 33, "Password", false, loginWindow) guiLabelSetColor( passwordLabel, 139, 26, 30 ) guiLabelSetHorizontalAlign( passwordLabel, "center" )
        loginEdit = guiCreateEdit(25, 32, 120,33, "", false, loginWindow) guiSetAlpha( loginEdit, 0.5 ) guiEditSetCaretIndex( loginEdit, 1 )
        passwordEdit = guiCreateEdit(185, 31, 120, 33, "", false, loginWindow) guiSetAlpha( passwordEdit, 0.5 )
        guiSetFont(loginLabel, "default-bold-small")
        guiLabelSetVerticalAlign(loginLabel, "center")
        guiSetFont(passwordLabel, "default-bold-small")
        guiLabelSetVerticalAlign(passwordLabel, "center")
        --registerButton = guiCreateButton(10, 122, 136, 35, "Register", false, loginWindow)
        registerButton = guiCreateStaticImage( 32, 86, 120, 46, "buttonreg.png", false, loginWindow ) guiSetAlpha( registerButton, 0.05 )
        --loginButton = guiCreateButton(174, 122, 136, 35, "Login", false, loginWindow)
        loginButton = guiCreateStaticImage( 177, 86, 120, 46, "buttonlogin.png", false, loginWindow ) guiSetAlpha( loginButton, 0.05 )
        errorLabel = guiCreateLabel(10, 120, 290, 38, "", false, loginWindow)
        guiLabelSetHorizontalAlign(errorLabel, "center", true)
        guiEditSetMasked(passwordEdit,true)
        guiLabelSetVerticalAlign ( errorLabel, "center")

        addEventHandler( "onClientGUIClick", loginWindow, 
        function( button )
            if button == "left" then
                if source == loginButton then
                    clLoginAttempt("log")
                elseif source == registerButton then
                    clLoginAttempt("reg")
                end
            end
        end )
        addEventHandler( "onClientKey", root, clLoginEnter)
        cameraChange()
        fadeCamera( true,  3)
        cameraTimer = setTimer( cameraChange, 10000, 0 )
        --showChat( false )
        showCursor( true, true )
        setPlayerHudComponentVisible("area_name",false)
        setPlayerHudComponentVisible("radar",false)
        addEventHandler( "onClientMouseEnter", loginWindow,
        function ( )
            if source == loginButton then
                guiSetAlpha( loginButton, 1 )
                playSound( "buttontick.wav" )
            elseif source == registerButton then
                guiSetAlpha( registerButton, 1 )
                playSound( "buttontick.wav" )
            end
        end )
        addEventHandler( "onClientMouseLeave", loginWindow, 
        function ( )
            if source == loginButton then
                guiSetAlpha( loginButton, 0.05 )
            elseif source == registerButton then
                guiSetAlpha( registerButton, 0.05 )
            end
        end )
    end
end

function clLoginEnter(key)
    if key == "enter" then
        clLoginAttempt("log")
    end
end

function clLoginAttempt( logOrReg )
    if guiGetText( loginEdit ) ~= "" then
        if guiGetText( passwordEdit ) ~= "" then
            triggerServerEvent( "logReg", localPlayer, guiGetText( loginEdit ), guiGetText( passwordEdit ), logOrReg)
        else
            errorOutput("Error: Pole hasła jest puste")
        end
    else
        errorOutput("Error: Pole loginu jest puste")
    end
end

addEventHandler( "onLogin", resourceRoot, 
function (  )
    guiSetVisible(loginWindow,false)
    killTimer( cameraTimer )
    if isTimer(cameraFadeInTimer) then killTimer( cameraFadeInTimer ) end
    if isTimer(cameraFadeOutTimer) then killTimer( cameraFadeOutTimer ) end
    showChat( true )
    setPlayerHudComponentVisible("area_name",true)
    setPlayerHudComponentVisible("radar",true)
    showCursor( false )
    removeEventHandler( "onClientKey", root, clLoginEnter )
end )

function errorOutput( reason )
    if reason then
        guiSetText(errorLabel,reason)
        --guiSetSize( loginWindow, 329, 217, false ) 
        if isTimer(errorTimer) then killTimer( errorTimer ) end
        errorTimer = setTimer(function() guiSetText(errorLabel,"") end,6000,1)
    end
end
addEvent( "loginError", true )
addEventHandler( "loginError", resourceRoot, errorOutput )

function cameraChange( )
    cameraFadeInTimer = setTimer(function() fadeCamera( true,  1) end,11000,1)
    cameraFadeOutTimer = setTimer(function() fadeCamera( false,  1) end,9000,1)
    local rotation = getElementRotation( getCamera(  ))
    setElementRotation( getCamera(  ), -215, 180, 120 )
    setElementPosition( getCamera(  ), math.random(-2300,2300),math.random(-2300,2300),math.random(300,350))
    setCameraShakeLevel ( 5 )
end










local loreQuestions = {
    {
        question = "Witaj! Wkrótce dołączysz do gry! Prosimy jednak wypełnić tą krótką ankietę, dzięki której zostaniesz przydzielony do gangu. Pytania są IC (in character).\nUwaga: Nie tylko od tego wyboru zależy twój początkowy gang.\n\nMłodość spędziłeś na ulicach...",
        a = {"Grove", {ballas=7}},
        b = {"Ballas", {grove=7}},
        c = {"Vagos", {vagos=7}}
    },
    {
		question = "Którą broń wolisz?",
		a = {"Uzi", {ballas=3,grove=1,aztecas=1}},
		b = {"Tec-9", {grove=3,ballas=1,aztecas=1}},
		c = {"Strzelba", {vagos=4}}
	},
	{
		question = "Skąd pochodzi twoja rodzina?",
		a = {"Ameryka", {ballas=4,grove=4}},
		b = {"Meksyk", {vagos=4, aztecas=1}},
		c = {"Hiszpania",{aztecas=4, vagos=1}}
	},
    {
        question = "Czym wolisz się zajmować?",
        a = {"Handel narkotykami", {aztecas=3,ballas=3}},
        b = {"Prowadzenie walki z innymi gangami", {grove=4}},
        c = {"Produkcja narkotyków",{vagos=3, ballas=1}}
    },
}

local loreI = 1
local answerSum = {}

addEventHandler("onClientResourceStart", resourceRoot,
function()
    wndLore = guiCreateWindow((screenW - 480) / 2, (screenH - 315) / 2, 480, 315, "Wybierz swoją historię", false)
    guiWindowSetSizable(wndLore, false)

    labelQuestion = guiCreateLabel(10, 31, 460, 160, "Question", false, wndLore)
    guiLabelSetHorizontalAlign(labelQuestion, "center", true)
    guiLabelSetVerticalAlign(labelQuestion, "center")
    a = {}
    a.a = guiCreateButton(20, 201, 450, 26, "a", false, wndLore)
    a.b = guiCreateButton(20, 237, 450, 26, "b", false, wndLore)
    a.c = guiCreateButton(21, 273, 449, 26, "c", false, wndLore)

    guiSetVisible( wndLore, false )

    addEventHandler( "onClientGUIClick", wndLore,
	function (  )
	  guiGetText ( source)
		for k,v in pairs( a ) do
			if v == source then
				local q = loreQuestions[loreI]
				for k2,v2 in pairs( q[k][2] ) do
					if not answerSum[k2] then answerSum[k2] = 0 end
					answerSum[k2] = answerSum[k2]+v2
					--outputChatBox( "Add to "..k2.." amm "..v2 )
				end
				loreI = loreI+1
				showLoreWindow( )
			end
		end
	end )
end )

function showLoreWindow(  )
	local q = loreQuestions[loreI]
	if q then
		guiSetText( labelQuestion, q.question )
		guiSetText( a.a, q.a[1] )
		guiSetText( a.b, q.b[1] )
		guiSetText( a.c, q.c[1] )
		showCursor( true, true )
		guiSetVisible( wndLore, true )
	else
        local hi = 0
        local hiGang = ""
        for k,v in pairs( answerSum ) do
            if v > hi then
                hi = v
                hiGang = k
            end
        end
        triggerServerEvent( "loreRequest", localPlayer, hiGang )
        
		showCursor( false )
		guiSetVisible( wndLore, false )
	end
end

addEvent( "getLore", true )
addEventHandler( "getLore", localPlayer, 
function (  )
    loreI=1
    setTimer( showLoreWindow, 2500, 1)
    answerSum = {}
end )