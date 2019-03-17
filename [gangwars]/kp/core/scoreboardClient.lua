local screenW, screenH = guiGetScreenSize()
local scorePosY = {
    {0.9361,0.9611},
    {0.9111,0.9361},
    {0.8861,0.9111},
    {0.8611,0.8861},
    {0.8361,0.8611},
    {0.8111,0.8361},
    {0.7861,0.8111},
    {0.7611,0.7861},
    {0.7361,0.7611},
    {0.7111,0.7361},
}

function checkIfMap()
    local dim = getElementDimension( localPlayer )
    if dim>0 and lobbys and lobbys[dim]["type"] == "dm" and lobbys[dim]["dmMap"] then
        return "("..lobbys[dim]["dmMap"]..")"
    else
        return ""
    end
end

addEventHandler("onClientRender", root,
    function()
        --dmSboard1 = math.random(1000)
        local dim = getElementDimension( localPlayer )
        if lobbys~= nil and dim ~= 0 and lobbys[dim] and lobbys[dim]["scoreboard"] == true then
            dxDrawLine((screenW * 0.8708) - 1, (screenH * 0.6796) - 1, (screenW * 0.8708) - 1, screenH * 0.9861, tocolor(0, 0, 0, 255), 1, false)
            dxDrawLine(screenW * 0.9948, (screenH * 0.6796) - 1, (screenW * 0.8708) - 1, (screenH * 0.6796) - 1, tocolor(0, 0, 0, 255), 1, false)
            dxDrawLine((screenW * 0.8708) - 1, screenH * 0.9861, screenW * 0.9948, screenH * 0.9861, tocolor(0, 0, 0, 255), 1, false)
            dxDrawLine(screenW * 0.9948, screenH * 0.9861, screenW * 0.9948, (screenH * 0.6796) - 1, tocolor(0, 0, 0, 255), 1, false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.6796, screenW * 0.1240, screenH * 0.3065, tocolor(48, 48, 48, 150), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.6796, screenW * 0.1240, screenH * 0.0315, tocolor(30, 30, 30, 136), false)
            dxDrawText(lobbys[dim]["name"] .. " " .. checkIfMap(), screenW * 0.8760, screenH * 0.6870, screenW * 0.9896, screenH * 0.7111, tocolor(255, 255, 255, 255), 1.00, "default", "center", "top", false, false, false, false, false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.7111, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 70), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.7361, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 103), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.7611, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 70), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.7861, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 103), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.8111, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 70), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.8361, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 103), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.8611, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 70), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.8861, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 103), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.9111, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 70), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.9361, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 103), false)
            dxDrawRectangle(screenW * 0.8708, screenH * 0.9611, screenW * 0.1240, screenH * 0.0250, tocolor(48, 48, 48, 70), false)
            for key,value in ipairs(scorePosY) do
                if sbData[key] then
                    dxDrawText(sbData[key][1] , screenW * 0.8760, screenH * value[1], screenW * 0.9896, screenH * value[2], tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false)
                    if sbData[key][2] ~= -1 then dxDrawText(" | " .. sbData[key][2], screenW * 0.965, screenH * value[1], screenW * 0.9896, screenH * value[2], tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
                end
            end

            --[[
            if sbData[9][2] ~= -1 then dxDrawText(sbData[9][1] , screenW * 0.8760, screenH * 0.7361, screenW * 0.9896, screenH * 0.7611, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[8][2] ~= -1 then dxDrawText(sbData[8][1] , screenW * 0.8760, screenH * 0.7611, screenW * 0.9896, screenH * 0.7861, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[7][2] ~= -1 then dxDrawText(sbData[7][1] , screenW * 0.8760, screenH * 0.7861, screenW * 0.9896, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[6][2] ~= -1 then dxDrawText(sbData[6][1] , screenW * 0.8760, screenH * 0.8111, screenW * 0.9896, screenH * 0.8361, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[5][2] ~= -1 then dxDrawText(sbData[5][1] , screenW * 0.8760, screenH * 0.8361, screenW * 0.9896, screenH * 0.8611, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[4][2] ~= -1 then dxDrawText(sbData[4][1] , screenW * 0.8760, screenH * 0.8611, screenW * 0.9896, screenH * 0.8861, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[3][2] ~= -1 then dxDrawText(sbData[3][1] , screenW * 0.8760, screenH * 0.8861, screenW * 0.9896, screenH * 0.9111, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[2][2] ~= -1 then dxDrawText(sbData[2][1] , screenW * 0.8760, screenH * 0.9111, screenW * 0.9896, screenH * 0.9361, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
            if sbData[1][2] ~= -1 then dxDrawText(sbData[1][1] , screenW * 0.8760, screenH * 0.9361, screenW * 0.9896, screenH * 0.9611, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end

			if sbData[10][2] ~= -1 then dxDrawText(" | " .. sbData[10][2], screenW * 0.8760, screenH * 0.7111, screenW * 0.9896, screenH * 0.7361, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[9][2] ~= -1 then dxDrawText(" | " .. sbData[9][2], screenW * 0.8760, screenH * 0.7361, screenW * 0.9896, screenH * 0.7611, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[8][2] ~= -1 then dxDrawText(" | " .. sbData[8][2], screenW * 0.8760, screenH * 0.7611, screenW * 0.9896, screenH * 0.7861, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[7][2] ~= -1 then dxDrawText(" | " .. sbData[7][2], screenW * 0.8760, screenH * 0.7861, screenW * 0.9896, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[6][2] ~= -1 then dxDrawText(" | " .. sbData[6][2], screenW * 0.8760, screenH * 0.8111, screenW * 0.9896, screenH * 0.8361, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[5][2] ~= -1 then dxDrawText(" | " .. sbData[5][2], screenW * 0.8760, screenH * 0.8361, screenW * 0.9896, screenH * 0.8611, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[4][2] ~= -1 then dxDrawText(" | " .. sbData[4][2], screenW * 0.8760, screenH * 0.8611, screenW * 0.9896, screenH * 0.8861, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[3][2] ~= -1 then dxDrawText(" | " .. sbData[3][2], screenW * 0.8760, screenH * 0.8861, screenW * 0.9896, screenH * 0.9111, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[2][2] ~= -1 then dxDrawText(" | " .. sbData[2][2], screenW * 0.8760, screenH * 0.9111, screenW * 0.9896, screenH * 0.9361, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            if sbData[1][2] ~= -1 then dxDrawText(" | " .. sbData[1][2], screenW * 0.8760, screenH * 0.9361, screenW * 0.9896, screenH * 0.9611, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false) end
            ]]
            dxDrawText(getPlayerName( localPlayer ), screenW * 0.8760, screenH * 0.9611, screenW * 0.9896, screenH * 0.9861, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false)
            if getElementData( localPlayer, "score" ) ~= -1 then dxDrawText(" | " .. getElementData( localPlayer, "score" ), screenW * 0.965, screenH * 0.9611, screenW * 0.9896, screenH * 0.9861, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false) end
        end
    end
)

sbData = {}
setTimer( 
function()
    local dim = getElementDimension( localPlayer )
   	if lobbys~= nil and dim ~= 0 and lobbys[dim] and lobbys[dim]["scoreboard"] == true then
	    sbData = {}
	    local players = lobbys[dim]["players"]
	    for key,player in ipairs(players) do
	        if getElementDimension( player ) == getElementDimension( localPlayer ) then
	            sbData[#sbData+1] = {getPlayerName( player ), getElementData( player, "score" )}
	        end
	    end
	    while #sbData < 10 do
	        sbData[#sbData+1] = {"",-1}
	    end
	    table.sort(sbData, function( a,b )
	    if (a[2] < b[2]) then
	        -- primary sort on position -> a before b
	        return true
	        elseif (a[2] > b[2]) then
	        -- primary sort on position -> b before a
	        return false
	        else
	        -- primary sort tied, resolve w secondary sort on rank
	        return a[1] < b[1]
	        end
	    end)
	end
end, 500, 0 )