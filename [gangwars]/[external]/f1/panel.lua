-- skrypt napisal demonek
-- skrypt dla Królewska Piaskownica server

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

napisy = guiCreateLabel(0.43, 0.27, 0.33, 0.47, "Select a Button / Wybierz przycisk / Seleccione el botón", true)
guiLabelSetHorizontalAlign(napisy, "center", false)
guiLabelSetVerticalAlign(napisy, "center")
guiSetVisible(napisy, false)

local foncik = "default"--dxCreateFont("t.fff", 15)
function gui()
        local r, g, b = interpolateBetween(50, 50, 50, 144, 255, 0, (getTickCount())/2100,"SineCurve")
        dxDrawRectangle(screenW * 0.2225, screenH * 0.2370, screenW * 0.5556, screenH * 0.5469, tocolor(r, g, b, 75), false)
        dxDrawLine((screenW * 0.2438) - 1, (screenH * 0.2695) - 1, (screenW * 0.2438) - 1, screenH * 0.3294, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4012, (screenH * 0.2695) - 1, (screenW * 0.2438) - 1, (screenH * 0.2695) - 1, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine((screenW * 0.2438) - 1, screenH * 0.3294, screenW * 0.4012, screenH * 0.3294, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4012, screenH * 0.3294, screenW * 0.4012, (screenH * 0.2695) - 1, tocolor(95, 95, 95, 208), 1, false)
		-- 1 button
		if isMouseIn(screenW * 0.2430, screenH * 0.2682, screenW * 0.1596, screenH * 0.0612) then
        dxDrawRectangle(screenW * 0.2430, screenH * 0.2682, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 125), false)
		else
        dxDrawRectangle(screenW * 0.2430, screenH * 0.2682, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 75), false)
		end
		--
        dxDrawLine((screenW * 0.2430) - 1, (screenH * 0.6810) - 1, (screenW * 0.2430) - 1, screenH * 0.7422, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, (screenH * 0.6810) - 1, (screenW * 0.2430) - 1, (screenH * 0.6810) - 1, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine((screenW * 0.2430) - 1, screenH * 0.7422, screenW * 0.4026, screenH * 0.7422, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, screenH * 0.7422, screenW * 0.4026, (screenH * 0.6810) - 1, tocolor(95, 95, 95, 208), 1, false)
		-- 6 button
		if isMouseIn(screenW * 0.2430, screenH * 0.6810, screenW * 0.1596, screenH * 0.0612) then
        dxDrawRectangle(screenW * 0.2430, screenH * 0.6810, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 125), false)
		else
        dxDrawRectangle(screenW * 0.2430, screenH * 0.6810, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 75), false)
		end
		--
        dxDrawLine((screenW * 0.2430) - 1, (screenH * 0.6003) - 1, (screenW * 0.2430) - 1, screenH * 0.6615, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, (screenH * 0.6003) - 1, (screenW * 0.2430) - 1, (screenH * 0.6003) - 1, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine((screenW * 0.2430) - 1, screenH * 0.6615, screenW * 0.4026, screenH * 0.6615, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, screenH * 0.6615, screenW * 0.4026, (screenH * 0.6003) - 1, tocolor(95, 95, 95, 208), 1, false)
		-- 5 button
		if isMouseIn(screenW * 0.2430, screenH * 0.6003, screenW * 0.1596, screenH * 0.0612) then
        dxDrawRectangle(screenW * 0.2430, screenH * 0.6003, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 125), false)
		else
        dxDrawRectangle(screenW * 0.2430, screenH * 0.6003, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 75), false)
		end
		--
        dxDrawLine((screenW * 0.2430) - 1, (screenH * 0.5169) - 1, (screenW * 0.2430) - 1, screenH * 0.5781, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, (screenH * 0.5169) - 1, (screenW * 0.2430) - 1, (screenH * 0.5169) - 1, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine((screenW * 0.2430) - 1, screenH * 0.5781, screenW * 0.4026, screenH * 0.5781, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, screenH * 0.5781, screenW * 0.4026, (screenH * 0.5169) - 1, tocolor(95, 95, 95, 208), 1, false)
		-- 4 button
		if isMouseIn(screenW * 0.2430, screenH * 0.5169, screenW * 0.1596, screenH * 0.0612) then
        dxDrawRectangle(screenW * 0.2430, screenH * 0.5169, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 125), false)
		else
        dxDrawRectangle(screenW * 0.2430, screenH * 0.5169, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 75), false)
		end
		--
        dxDrawLine((screenW * 0.2430) - 1, (screenH * 0.4349) - 1, (screenW * 0.2430) - 1, screenH * 0.4961, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, (screenH * 0.4349) - 1, (screenW * 0.2430) - 1, (screenH * 0.4349) - 1, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine((screenW * 0.2430) - 1, screenH * 0.4961, screenW * 0.4026, screenH * 0.4961, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, screenH * 0.4961, screenW * 0.4026, (screenH * 0.4349) - 1, tocolor(95, 95, 95, 208), 1, false)
		-- 3 button
		if isMouseIn(screenW * 0.2430, screenH * 0.4349, screenW * 0.1596, screenH * 0.0612) then
        dxDrawRectangle(screenW * 0.2430, screenH * 0.4349, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 125), false)
		else
        dxDrawRectangle(screenW * 0.2430, screenH * 0.4349, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 75), false)
		end
		--
        dxDrawLine((screenW * 0.2430) - 1, (screenH * 0.3503) - 1, (screenW * 0.2430) - 1, screenH * 0.4115, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, (screenH * 0.3503) - 1, (screenW * 0.2430) - 1, (screenH * 0.3503) - 1, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine((screenW * 0.2430) - 1, screenH * 0.4115, screenW * 0.4026, screenH * 0.4115, tocolor(95, 95, 95, 208), 1, false)
        dxDrawLine(screenW * 0.4026, screenH * 0.4115, screenW * 0.4026, (screenH * 0.3503) - 1, tocolor(95, 95, 95, 208), 1, false)
		-- 2 button
		if isMouseIn(screenW * 0.2430, screenH * 0.3503, screenW * 0.1596, screenH * 0.0612) then
        dxDrawRectangle(screenW * 0.2430, screenH * 0.3503, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 125), false)
		else
        dxDrawRectangle(screenW * 0.2430, screenH * 0.3503, screenW * 0.1596, screenH * 0.0612, tocolor(0, 144, 255, 75), false)
		end
		--
        dxDrawText("Polish", (screenW * 0.2430) + 1, (screenH * 0.2669) + 1, (screenW * 0.4026) + 1, (screenH * 0.3294) + 1, tocolor(0, 144, 255, 255), 1.00, foncik, "center", "center", false, false, false, false, false) -- 1 napis
        dxDrawText("Polish", screenW * 0.2430, screenH * 0.2669, screenW * 0.4026, screenH * 0.3294, tocolor(255, 255, 255, 255), 1.00, foncik, "center", "center", false, false, false, false, false) -- 1 napis
        dxDrawText("English", (screenW * 0.2430) + 1, (screenH * 0.3490) + 1, (screenW * 0.4026) + 1, (screenH * 0.4115) + 1, tocolor(0, 144, 255, 255), 1.00, foncik, "center", "center", false, false, false, false, false) -- 2 napis
        dxDrawText("English", screenW * 0.2430, screenH * 0.3490, screenW * 0.4026, screenH * 0.4115, tocolor(255, 255, 255, 255), 1.00, foncik, "center", "center", false, false, false, false, false) -- 2 napis
        dxDrawText("español", (screenW * 0.2430) + 1, (screenH * 0.4336) + 1, (screenW * 0.4026) + 1, (screenH * 0.4961) + 1, tocolor(0, 144, 255, 255), 1.00, foncik, "center", "center", false, false, false, false, false) -- 3 napis
        dxDrawText("español", screenW * 0.2430, screenH * 0.4336, screenW * 0.4026, screenH * 0.4961, tocolor(255, 255, 255, 255), 1.00, foncik, "center", "center", false, false, false, false, false) -- 3 napis
        

       
end

bindKey("F1", "down", function ()
	if guiGetVisible(napisy) then
	    removeEventHandler("onClientRender", root, gui)
		guiSetVisible(napisy, false)
		showCursor(false)
	else
	    addEventHandler("onClientRender", root, gui)
		guiSetVisible(napisy, true)
		showCursor(true, false)
		guiSetText(napisy, "Select a Button / Wybierz przycisk / Seleccione el botón")
	end
end)

addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "down" then
if isMouseIn(screenW * 0.2430, screenH * 0.2669, screenW * 0.4026, screenH * 0.3294) and guiGetVisible(napisy) then
	-- polski
guiSetText(napisy, "Witaj na serwerze Królewska Piaskownica\n\n...\n\n\n...")
elseif isMouseIn(screenW * 0.2430, screenH * 0.3490, screenW * 0.4026, screenH * 0.4115) and guiGetVisible(napisy) then
	-- angielski
guiSetText(napisy, "Welcome to a server Royal Sandbox\n\n...\n\n\n...")
elseif isMouseIn(screenW * 0.2430, screenH * 0.4336, screenW * 0.4026, screenH * 0.4961596, screenH * 0.0612) and guiGetVisible(napisy) then
	-- hiszpanski
guiSetText(napisy, "Bienvenido a un servidor Real Zona de pruebas\n\n...\n\n\n...")
end
end
end)
