-- skrypt napisal DeMoNeK_ / modified by Yazir
-- client site
local limiT = 15 		-- maksymalna ilość wyświetlanych notyfikacji na raz
local CZAS = 4000 		-- ile czasu 1 notyfikacja ma sie pojawiac (w milisekundach) (domyślna wartość jeśli nie podana we funkcji)
local FADE_CZAS = 12000 -- ile czasu ma trwać animacja znikania (w milisekundach)
local OFFSET = 22 		-- odstep miedzy wiadomosciami w pikselach 
--local FONT_SIZE = 36 	-- rozmiar czcionki
local FONT_SCALE = 1.3 -- skala czcionki

--local font = dxCreateFont("f.ttf", FONT_SIZE)
local notyfikacje = {} 

function createNotification(demon, text)
	if type(text) ~= "string" then return false end 
	
	if demon == "error" then
	outputConsole("[ERROR] "..text)
	table.insert(notyfikacje, {text=text, kolor1=255, kolor2=0, kolor3=0, alpha=255, typ="error", startTick=getTickCount(), length=CZAS})
	elseif demon == "info" then
	outputConsole("[INFO] "..text)
	table.insert(notyfikacje, {text=text, kolor1=255, kolor2=255, kolor3=255, alpha=255, typ="info", startTick=getTickCount(), length=CZAS})
	elseif demon == "warning" then
	outputConsole("[WARNING] "..text)
	table.insert(notyfikacje, {text=text, kolor1=255, kolor2=255, kolor3=0, alpha=255, typ="warning", startTick=getTickCount(), length=CZAS})
	end
	
	if #notyfikacje > limiT then 
		table.remove(notyfikacje, 1)
	end
	
	
	return true 
end
addEvent("onClientAddNotification", true)
addEventHandler("onClientAddNotification", root, createNotification)

local screenW, screenH = guiGetScreenSize()
function rendernotyfikacje() 
	local now = getTickCount() 
	
	local visiblenotyfikacje = 0 
	
	local notif = table.reverse(notyfikacje)
	for k,v in ipairs(notif) do 
		local x,y = screenW * 0.99, screenH * 0.8 - OFFSET * k
		
		if now > v.startTick+v.length then
			local startCZAS = v.startTick+v.length 
			local progress = (now - startCZAS) / FADE_CZAS
			v.alpha = interpolateBetween(v.alpha, 0, 0, 0, 0, 0, progress, "InOutQuad")
		end 
		
		if v.alpha > 0 then 
			visiblenotyfikacje = visiblenotyfikacje+1 
		end
		local offX, offY = 500, 20
		--dxDrawText(v.text, x, y, nil, nil, tocolor(0, 0, 0, v.alpha), FONT_SCALE+0.03, "clear", "right", "center", false, false, true) 
		dxDrawText(v.text, x-offX-15,y-offY,x+offX,y+offY, tocolor(v.kolor1, v.kolor2, v.kolor3, v.alpha), FONT_SCALE, "clear", "right", "center", false, true, true)

	end
	
	if visiblenotyfikacje == 0 then 
		notyfikacje = {}
	end 
end 
addEventHandler("onClientRender", root, rendernotyfikacje)

-- poczebne 
function table.reverse(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

-- exports.demon_notyfikacje:createNotification("error", "error xd")
-- exports.demon_notyfikacje:createNotification("warning", "warning xd")
-- exports.demon_notyfikacje:createNotification("info", "info xd")