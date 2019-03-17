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