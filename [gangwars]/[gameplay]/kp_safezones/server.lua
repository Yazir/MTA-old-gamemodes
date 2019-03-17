-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

safezoneparent = createElement( "safezoneparent" )
function createSafezone( x,y,size )
    local rAr = createRadarArea( x-size/2, y-size/2, size,size, 0, 255, 0, 50)
    local col = createColRectangle( x-size/2, y-size/2, size,size )
    setElementData( rAr, "safezone", true )
    setElementParent( col, safezoneparent )
end

addEvent( "onPlayerEnterSafezone" )
addEventHandler( "onColShapeHit", safezoneparent,
function ( el, md )
    if isElement( el ) and md then
    local elType = getElementType( el )
        if elType == "vehicle" or elType == "player" then
            setElementData( el, "inSafezone", true )
            if elType == "player" then
                toggleControl( el, "fire", false )
                toggleControl( el, "aim_weapon", false )
                triggerEvent( "onPlayerEnterSafezone", el )
            elseif elType == "vehicle" then
                setVehicleDamageProof( el, true )
            end
        end
    end
end )

function onSafezoneLeave( el, md )
    if isElement( el ) then
        --if md or md == nil then
        local elType = getElementType( el )
            if elType == "vehicle" or elType == "player" then
                setElementData( el, "inSafezone", false )
                if elType == "player" then
                    toggleControl( el, "fire", true )
                    toggleControl( el, "aim_weapon", true )
                elseif elType == "vehicle" then
                    setVehicleDamageProof( el, false )
                end
            end
        --end
    end
end
addEventHandler( "onColShapeLeave", safezoneparent, onSafezoneLeave )
addEvent( "onSafezoneLeave" )
addEventHandler( "onSafezoneLeave", root, function() onSafezoneLeave( source ) end )

outputDebugString( "[KP] kp_safezones (server.lua) start" )