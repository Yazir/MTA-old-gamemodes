--//////////////////////////////
--|| Skrypt wykonal DeMoNeK_
--|| Dla serwera Królewska Piaskownica
--|| Wersja skryptu: 1.0
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
czcionka = dxCreateFont("myriadproregular.ttf", 17)
czcionka2 = dxCreateFont("myriadproregular.ttf", 26, true)
local x,y = guiGetScreenSize()
okno = guiCreateGridList(x/3.8, y/3.8, x/2.02, 0, false)
guiSetVisible(okno, false )

function wyswietlPanel()
        dxDrawRectangle(x/3.8, y/3.8, x/2, y/2, tocolor(0,0,0,130), true)
        dxDrawText("Panel Informacyjny", x/2, y/3.7, x/2.5, y/2.9, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, true, false, false)
        dxDrawText("Witaj w panelu informacyjnym serwera Królewska Piaskownica\n\nKanał Discord: discord.gg/3DzbGsj\nPanel Pomcy: F1\nPokoje gier: F2\nStatystyki: F3\nSkin Shop: F4\nEkwipunek: F5\n\nSerwer jest we wczesnej fazie.", x/3.5, y/1.8, x/2, y/2, tocolor(255, 255, 255, 255), 1.0, czcionka, "left", "center", false, false, true, false, false)
end

function funkcjaPanelu()
	if (guiGetVisible(okno)) == true then
		guiSetVisible(okno, false)
		removeEventHandler("onClientRender", getRootElement(), wyswietlPanel)
	else
		guiSetVisible(okno, true)
		addEventHandler("onClientRender", getRootElement(), wyswietlPanel)
	end
end
addCommandHandler("pomoc", funkcjaPanelu)