local screenW, screenH = guiGetScreenSize()

clientGangTable = {
    grove = {
        color = {25,180,25},
    },
    ballas = {
        color = {153,50,153},
    },
    police = {
        color = {65,105,225},
    },
    vagos = {
        color = {255,215,0},
    },
    aztecas = {
        color = {51,179,166},
    },
    rus = {
        color = {118,0,0},
    },
    nomad = {
        color = {153,153,153},
    },
    vigilante = {
        color = {190,25,25},
    },
    civilian = {
        color = {229,121,27},
    },
    --[[vaginos = {
        color = {255,20,33},
        team = createTeam( "Vaginos", 255,20,33 ),
        skins = {"ballas1","grove2"},
        chatprefix = "#990000[Vaginos]"
    },]]
}

addEventHandler("onClientResourceStart", resourceRoot,
function()
    gangWindowSelection = guiCreateWindow((screenW - 310) / 2, (screenH - 163) / 2, 310, 163, "Gang selection", false)
    guiWindowSetSizable(gangWindowSelection, false)

    gangButtonSelectionGrove = guiCreateButton(10, 82, 123, 62, "Grove St.", false, gangWindowSelection)
    guiSetProperty(gangButtonSelectionGrove, "NormalTextColour", "FF19E900")
    gangButtonSelectionBallas = guiCreateButton(177, 82, 123, 62, "Ballas", false, gangWindowSelection)
    guiSetProperty(gangButtonSelectionBallas, "NormalTextColour", "FFC101F1")
    gangLabelSelecitonInfo = guiCreateLabel(20, 29, 270, 43, "Choose your gang", false, gangWindowSelection)
    guiLabelSetHorizontalAlign(gangLabelSelecitonInfo, "center", false)
    guiLabelSetVerticalAlign(gangLabelSelecitonInfo, "center")   

    guiSetVisible( gangWindowSelection, false )
    addEventHandler( "onClientGUIClick", gangWindowSelection, 
    function ( but, sta )
        if but == "left" then
            if source == gangButtonSelectionBallas then
                triggerServerEvent( "gangRequest", localPlayer, "join", "ballas" )
                guiSetVisible( gangWindowSelection, false )
                showCursor( false )
            elseif source == gangButtonSelectionGrove then
                triggerServerEvent( "gangRequest", localPlayer, "join", "grove" )
                guiSetVisible( gangWindowSelection, false )
                showCursor( false )
            end
        end
    end )
end )

addEvent( "gangClientShowJoin", true )
addEventHandler( "gangClientShowJoin", localPlayer, 
function (  )
    guiSetVisible( gangWindowSelection, true )
    showCursor( true )
end )

local gangAreaTickets = nil
local handled = false
local sortedTickets = {}
addEvent( "gangGetAreaTable", true )
addEventHandler( "gangGetAreaTable", localPlayer, 
function ( data )
    if data then
        gangAreaTickets = data
        sortedTickets = {}
        for k,v in pairs( gangAreaTickets ) do
        sortedTickets[#sortedTickets+1] = {k, v} 
        end
        table.sort( sortedTickets, function ( a,b ) return a[2]>b[2] end )
        if not handled then
            addEventHandler("onClientRender", root, gangRenderAreaScore )
            handled = true
        end
    else
        removeEventHandler( "onClientRender", root, gangRenderAreaScore )
        handled = false
    end
end )


local maxTickets = 35
local maxSize = screenW*0.35

function gangRenderAreaScore()
    
    dxDrawRectangle(screenW*0.5-(maxSize/2), screenH*0.06-(35/2), maxSize, 35, tocolor(0,0,0, 50), false)
    for k,v in pairs( sortedTickets ) do
        local c = clientGangTable[v[1]]["color"]
        local size = maxSize*( v[2]/maxTickets )
        dxDrawRectangle(screenW*0.5-(size/2), screenH*0.06-(35/2), size, 35, tocolor(c[1],c[2],c[3], 200), false)
    end
    dxDrawLine( screenW*0.5-(maxSize/2), screenH*0.06-(35/2), screenW*0.5-(maxSize/2), screenH*0.06+(35/2), tocolor( 0, 0, 0, 160 ), 1 )
    dxDrawLine( screenW*0.5+(maxSize/2), screenH*0.06-(35/2), screenW*0.5+(maxSize/2), screenH*0.06+(35/2), tocolor( 0, 0, 0, 160 ), 1 )
    dxDrawLine( screenW*0.5-(maxSize/2), screenH*0.06-(35/2), screenW*0.5+(maxSize/2), screenH*0.06-(35/2), tocolor( 0, 0, 0, 160 ), 1 )
    dxDrawLine( screenW*0.5-(maxSize/2), screenH*0.06+(35/2), screenW*0.5+(maxSize/2), screenH*0.06+(35/2), tocolor( 0, 0, 0, 160 ), 1 )
    
end


setTimer( 
function (  )
    if getElementDimension( localPlayer ) == 0 and not isPedDead( localPlayer ) then
        setElementHealth( localPlayer, getElementHealth( localPlayer ) + 0.08 )
    end
end, 1000, 0 )

local snd = nil
addEventHandler( "onClientPlayerDamage", root,
function ( att, wpn, bodypart, loss )
    local pla = source
    local dim = getElementDimension( pla )
    if lobbys[dim] then return end
    if isElement( att ) and getElementType( att ) == "player" and att ~= pla then
        local gang1 = getElementData( pla, "gang" )
        local gang2 = getElementData( att, "gang" )
        
        if getElementData( pla, "inSafezone" ) or getElementData( att, "inSafezone" ) then
            if att == localPlayer then
                outputChatBox( "[Safezone] Ochrona bezpiecznej strefy.", 225, 50, 50 )
            end
            cancelEvent( )
            return
        end

        if gang2 == "police" or gang1 == "police" then return end
        if getElementData( att, "job" ) == "medic" then return end
       --[[ local x,y,z = getElementPosition( pla )
          local x2,y2,z2 = getElementPosition( att )
          for k,v in ipairs( getElementChildren( getElementsByType( "safezoneparent" )[1] ) ) do 
              --if getElementData( v, "safezone" ) then
                  if isInsideRadarArea( v, x, y ) or isInsideRadarArea( v, x2, y2 ) then
                      if att == localPlayer then
                          outputChatBox( "[Safezone] Safezone protection.", 220, 50, 50 )
                      end
                      cancelEvent(  )
                      return
                  end
              --end
          end]]
        if gang1 == "civilian" or gang2 == "civilian" then
            cancelEvent( )
            return
        end

        if gang1 == gang2 and gang1 ~= "nomad" then
            if att == localPlayer then
                outputChatBox( "[Gang] Nie możesz skrzywdzić członka swojego gangu ".. getPlayerName( pla ) .."!" , 220, 50, 50 )
            end
            cancelEvent( )
            return
        end
    end
    if att == localPlayer then
        if not isElement( snd ) then
            snd = playSound( "files/sfx/weapon/hitsound.wav" )
        end
    end
end )