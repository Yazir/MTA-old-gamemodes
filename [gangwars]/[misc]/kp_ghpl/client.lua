--[[
narkoID=0
narkoNazwa=""
narkoNazwaNarzednik=""
narkoPodwojny=true
	narkoPodwojnyJaki=0
narkoCzas=0
narkoWspolczynnik=0.0
narkoRozmiarKsiezyca=true
	narkoRozmiarKsiezycaEkstremum=0.0
narkoRozmiarSlonca=true
	narkoRozmiarSloncaEkstremum=0.0
narkoGrawitacja=true
	narkoGrawitacjaEkstremum=0.0
narkoPredkosc=true
	narkoPredkoscEkstremum=0.0
narkoSamozaplon=true
	narkoSamozaplonProgMocy=0.0
	narkoSamozaplonCzestotliwosc=0
narkoKolor=true
	narkoKolorTyp=0
		#0#narkoKolorKolorR=0
		#0#narkoKolorKolorG=0
		#0#narkoKolorKolorB=0
		#1#narkoKolorDzielnik=0.0
		narkoKolorPrzezroczystosc=0.0
narkoSraczka = true
	narkoSraczkaProg = 0.0
narkoSiury = true
	narkoSiuryProg = 0.0
	narkoSiuryMoc = 0.0
narkoKrewOdbyt = true
	narkoKrewOdbytProg = 0.0
narkoKrewSiurak = true
	narkoKrewSiurakProg = 0.0
	narkoKrewSiurakMoc = 0.0
narkoZyskiwanieKrwi = true
	narkoZyskiwanieKrwiProg = 0.0
	narkoZyskiwanieKrwiIlosc = 0.0
narkoWybuch = true
	narkoWybuchProg = 0.0
	narkoWybuchCzestotliwosc = 0
	narkoWybuchTyp = 0
narkoMgla = true
	narkoMglaEkstremum = 0
narkoZasiegRenderowania = 0
	narkoZasiegRenderowaniaEkstremum= 0
narkoWstrzasyKamery = true
	narkoWstrzasyKameryIloczyn = 0
narkoRozmycieRuchu = true
	narkoRozmycieRuchuIloczyn
]]
local narkotykJaki2=0
local r1, g1, b1 = 0,0,0
local r1S, g1S, b1S = 0,0,0
local index = 0
local indexNiebo = 0
local narkoNieboFaza = 0
local resx,resy = guiGetScreenSize()
local moc = 0
local zm = 0
local grawitacja = getGravity()
local predkosc = getGameSpeed()
local mgla = getFogDistance()
local zasiegRenderowania = getFarClipDistance()
local rozmiarKsiezyca = getMoonSize()
local rozmiarSlonca = getSunSize()

local narkotyki = {}
narkotyki[#narkotyki+1]={ narkoID=1, narkoNazwa="Siurex", narkoNazwaNarzednik="Siurexem", narkoPodwojny=true, narkoPodwojnyJaki=2, narkoSiury=true,narkoSiuryMoc=0.5, narkoCzas=9000, narkoWspolczynnik=1 }
narkotyki[#narkotyki+1]={ narkoID=2, narkoNazwa="Krwix", narkoNazwaNarzednik="Krwixem", narkoKrewSiurak=true,narkoKrewSiurakMoc=1, narkoCzas=10000, narkoWspolczynnik=0.5, narkoZyskiwanieKrwi=true, narkoZyskiwanieKrwiIlosc=-1 }

local narkotykiLaczenie = {}
narkotykiLaczenie[#narkotykiLaczenie+1]={ narkoL1=1, narkoL2=3, narkoL3=2 }

function przenies( takNaPrawde )
	narkotykJaki2 = takNaPrawde
	setTimer ( narkoDodaj, 50, narkotyki[tonumber(narkotykJaki2)]["narkoCzas"]/50+1, narkotykJaki2 )
end

function zeruj ()
	index=0
	narkotykJaki2=0
	grawitacja = 0.008
	resetFogDistance()
	resetFarClipDistance()
	resetMoonSize ( )
	resetSunSize ( )
	mgla = getFogDistance()
	zasiegRenderowania = getFarClipDistance()
	setCameraShakeLevel (0)
	setBlurLevel(0)
	rozmiarKsiezyca = getMoonSize()
	rozmiarSlonca = getSunSize()
end



function narkoDodaj ( narkotykJaki2 )
	if isPedDead(localPlayer) then
		zeruj()
		killTimer(glownyTimer)
		killTimer(narkoDodaj)
	end
	moc = math.sin(((index/(narkotyki[tonumber(narkotykJaki2)]["narkoCzas"]/50))^narkotyki[tonumber(narkotykJaki2)]["narkoWspolczynnik"])*math.pi)
	if narkotyki[tonumber(narkotykJaki2)]["narkoGrawitacja"] == true then
		setGravity ( ((-grawitacja+narkotyki[tonumber(narkotykJaki2)]["narkoGrawitacjaEkstremum"]))*moc+grawitacja )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoRozmiarKsiezyca"] == true then
		setMoonSize ( ((-rozmiarKsiezyca +narkotyki[tonumber(narkotykJaki2)]["narkoRozmiarKsiezycaEkstremum"]))*moc+rozmiarKsiezyca )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoRozmiarSlonca"] == true then
		setSunSize ( ((-rozmiarSlonca +narkotyki[tonumber(narkotykJaki2)]["narkoRozmiarSloncaEkstremum"]))*moc+rozmiarSlonca )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoRozmycieRuchu"] == true then
		setBlurLevel ( moc*narkotyki[tonumber(narkotykJaki2)]["narkoRozmycieRuchuIloczyn"] )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoWstrzasyKamery"] == true then
		setCameraShakeLevel ( moc*narkotyki[tonumber(narkotykJaki2)]["narkoWstrzasyKameryIloczyn"] )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoMgla"] == true then
		setFogDistance ( ((-mgla+narkotyki[tonumber(narkotykJaki2)]["narkoMglaEkstremum"]))*moc+mgla )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoPredkosc"]==true then
		setGameSpeed ( ((-predkosc+narkotyki[tonumber(narkotykJaki2)]["narkoPredkoscEkstremum"]))*moc+predkosc )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoZasiegRenderowania"]==true then
		setFarClipDistance ( ((-zasiegRenderowania+narkotyki[tonumber(narkotykJaki2)]["narkoZasiegRenderowaniaEkstremum"]))*moc+zasiegRenderowania )
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoKolor"]==true and narkotyki[tonumber(narkotykJaki2)]["narkoKolorTyp"]==0 then
		r1= (narkotyki[tonumber(narkotykJaki2)]["narkoKolorKolorR"])
		g1= (narkotyki[tonumber(narkotykJaki2)]["narkoKolorKolorG"])
		b1= (narkotyki[tonumber(narkotykJaki2)]["narkoKolorKolorB"])
	end
	if narkotyki[tonumber(narkotykJaki2)]["narkoZyskiwanieKrwi"]==true then
		if narkotyki[tonumber(narkotykJaki2)]["narkoZyskiwanieKrwiProg"]==nil or narkotyki[tonumber(narkotykJaki2)]["narkoZyskiwanieKrwiProg"] <= moc then
			setElementHealth (localPlayer, getElementHealth(localPlayer)+narkotyki[tonumber(narkotykJaki2)]["narkoZyskiwanieKrwiIlosc"]*moc )
		end
	end
	if  narkotyki[tonumber(narkotykJaki2)]["narkoKolor"]==true and narkotyki[tonumber(narkotykJaki2)]["narkoKolorTyp"]==1 then
		if (narkoNieboFaza == 0 or narkoNieboFaza == 3) and indexNiebo == 0 then
			r1S =(255-r1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			g1S =(0-g1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			b1S =(0-b1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
		end
		if narkoNieboFaza == 0 and r1 >= 254 then
			r1 = 255
			g1 = 0
			b1 = 0
			narkoNieboFaza = 1
			r1S =(0-r1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			g1S =(255-g1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			b1S =(0-b1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
		end
		if narkoNieboFaza == 1 and g1 >= 254 then
			r1 = 0
			g1 = 255
			b1 = 0
			narkoNieboFaza = 2
			r1S =(0-r1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			g1S =(0-g1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			b1S =(255-b1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
		end
		if narkoNieboFaza == 2 and b1 >= 254 then
			r1 = 0
			g1 = 0
			b1 = 255
			narkoNieboFaza = 3
			r1S =(255-r1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			g1S =(0-g1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
			b1S =(0-b1)/narkotyki[tonumber(narkotykJaki2)]["narkoKolorDzielnik"]
		end
		if narkoNieboFaza == 3 and r1 >= 254 then
			indexNiebo = 0
			narkoNieboFaza = 0
		end
		if r1 >= 0 and g1 >= 0 and b1 >= 0 and r1 <= 255 and g1 <= 255 and b1 <= 255 then
			r1 = r1 + r1S
			g1 = g1 + g1S
			b1 = b1 + b1S
			indexNiebo = indexNiebo + 1
		end
	end
	
	
	

	
	
	
	
	-- specjalne
	-- wybuch
	if narkotyki[tonumber(narkotykJaki2)]["narkoWybuch"] == true then
		if index%narkotyki[tonumber(narkotykJaki2)]["narkoWybuchCzestotliwosc"] == 0 then
			if narkotyki[tonumber(narkotykJaki2)]["narkoWybuchProg"] <= moc then
				triggerServerEvent( "narkoWybuchSerwer", resourceRoot, narkotyki[tonumber(narkotykJaki2)]["narkoWybuchTyp"] )
			end
		end
	end
	-- Samozapłon
	if narkotyki[tonumber(narkotykJaki2)]["narkoSamozaplon"] == true then
		if index%narkotyki[tonumber(narkotykJaki2)]["narkoSamozaplonCzestotliwosc"] == 0 then
			if narkotyki[tonumber(narkotykJaki2)]["narkoSamozaplonProg"] < moc then
				triggerServerEvent( "narkoOgienSerwer", resourceRoot )
				setPedOnFire ( localPlayer, true )
			end
		end
	end
	-- sraczka
	if narkotyki[tonumber(narkotykJaki2)]["narkoSraczka"] == true then
		if narkotyki[tonumber(narkotykJaki2)]["narkoSraczkaProg"] <= moc then
			triggerServerEvent( "narkoSraczkaSerwer", resourceRoot,	getPedBonePosition ( localPlayer, 1 ) )
		end
	end
	-- siury
	if narkotyki[tonumber(narkotykJaki2)]["narkoSiury"] == true then
		if narkotyki[tonumber(narkotykJaki2)]["narkoSiuryProg"]==nil or narkotyki[tonumber(narkotykJaki2)]["narkoSiuryProg"] <= moc  then
			triggerServerEvent( "narkoSiurySerwer", resourceRoot, getPedBonePosition ( localPlayer, 1 ) )
		end
	end
	-- krew
	if narkotyki[tonumber(narkotykJaki2)]["narkoKrewOdbyt"] == true then
		if narkotyki[tonumber(narkotykJaki2)]["narkoKrewOdbytProg"] <= moc then
			triggerServerEvent( "narkoKrewOdbytSerwer", resourceRoot, getPedBonePosition ( localPlayer, 1 ) )
		end
	end

	if narkotyki[tonumber(narkotykJaki2)]["narkoKrewSiurak"] == true then
		if narkotyki[tonumber(narkotykJaki2)]["narkoKrewSiurakProg"]==nil or narkotyki[tonumber(narkotykJaki2)]["narkoKrewSiurakProg"] <= moc then
			triggerServerEvent( "narkoKrewSiurakSerwer", resourceRoot, getPedBonePosition ( localPlayer, 1 ) )
		end
	end
	

	
	index = index + 1
	outputDebugString (moc)
	if index == narkotyki[tonumber(narkotykJaki2)]["narkoCzas"]/50+1 then
		if narkotyki[tonumber(narkotykJaki2)]["narkoPodwojny"] == true then
			zm = narkotykJaki2
			zeruj ()
			narkotykJaki2=narkotyki[tonumber(zm)]["narkoPodwojnyJaki"]
			przenies ( narkotykJaki2 )
		else
		zeruj ()
		end
	end
end



function narkotyk ( nazwaKomendy, narkotykJaki )
	if narkotykJaki2 == 0 then
		narkotykJaki2 = narkotykJaki
		outputChatBox ("Narkotyzujesz się " .. narkotyki[tonumber(narkotykJaki2)]["narkoNazwaNarzednik"])
	else
		index = math.floor( (index/narkotyki[tonumber(narkotykJaki2)]["narkoCzas"]/50)*narkotyki[tonumber(narkotykJaki)]["narkoCzas"]/50)
		narkotykJaki2 = narkotykiLaczenie[tonumber(narkotykJaki2)]["narkoL" .. tostring(narkotykJaki)]
	end
	glownyTimer = setTimer ( narkoDodaj, 50, narkotyki[tonumber(narkotykJaki2)]["narkoCzas"]/50+1, narkotykJaki2 )
end 
addCommandHandler( "n", narkotyk )





addEventHandler ( "onClientRender", root,
function ()
	if narkotykJaki2 ~= 0 and narkotykJaki2 ~= 3 and narkotyki[tonumber(narkotykJaki2)]["narkoKolor"]==true then
	dxDrawRectangle ( 0,0, resx, resy, tocolor (r1,g1,b1, moc*narkotyki[tonumber(narkotykJaki2)]["narkoKolorPrzezroczystosc"]), false )
	end
end
)




--- specjalne parametry
--- Samozapłon

function narkoOgienKlient2 (x, y, z)
	createFire( x,y,z, 0)
end

addEvent( "narkoOgienKlient", true )
addEventHandler( "narkoOgienKlient", localPlayer, narkoOgienKlient2 ) 

--- Sraczka

function narkoSraczkaKlient2 ( x, y, z, rx, ry, rz)
	fxAddWood(x, y, z-0.2, 1.2*math.cos(math.rad(rz+270)), 1.2*math.sin(math.rad(rz+270)), 0, 50, 1)
end

addEvent( "narkoSraczkaKlient", true )
addEventHandler( "narkoSraczkaKlient", localPlayer, narkoSraczkaKlient2 ) 

--- Siury

function narkoSiuryKlient2 ( x, y, z, rx, ry, rz)
	if narkotykJaki2 ~= 0 then
		fxAddSparks( x, y, z-0.2, 3*math.cos(math.rad(rz+90)), 3*math.sin(math.rad(rz+90)), 1, narkotyki[tonumber(narkotykJaki2)]["narkoSiuryMoc"], 5, 0, 0, 0, false, 0.1 )
	end
end

addEvent( "narkoSiuryKlient", true )
addEventHandler( "narkoSiuryKlient", localPlayer, narkoSiuryKlient2 ) 

--- Krew z odbytu

function narkoKrewOdbytKlient2 ( x, y, z, rx, ry, rz)
	fxAddBlood ( x, y, z-0.2, 1.2*math.cos(math.rad(rz+270)), 1.2*math.sin(math.rad(rz+270)), 0.00000, 10, 1 )
end

addEvent( "narkoKrewOdbytKlient", true )
addEventHandler( "narkoKrewOdbytKlient", localPlayer, narkoKrewOdbytKlient2 ) 

--- Krew z siuraka

function narkoKrewSiurakKlient2 ( x, y, z, rx, ry, rz)
	if narkotykJaki2 ~=0 then
		fxAddBlood ( x, y, z-0.2, narkotyki[tonumber(narkotykJaki2)]["narkoKrewSiurakMoc"]*math.cos(math.rad(rz+90)), narkotyki[tonumber(narkotykJaki2)]["narkoKrewSiurakMoc"]*math.sin(math.rad(rz+90)), 0, 10, 1 )
	end
end

addEvent( "narkoKrewSiurakKlient", true )
addEventHandler( "narkoKrewSiurakKlient", localPlayer, narkoKrewSiurakKlient2 ) 
