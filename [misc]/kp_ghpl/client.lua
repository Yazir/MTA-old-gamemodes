--[[
narkoID=0
narkoNazwa=""
narkoPodwojny=true
narkoCzas=0
narkoWspolczynnik=0.0
narkoGrawitacja=true
	narkoGrawitacjaMin=0.0
	narkoGrawitacjaMax=0.0
narkoPredkoscGry=true
	narkoPredkoscGryMin=0.0
	narkoPredkoscGryMax=0.0
narkoSamozaplon=true
	narkoSamozaplonProgMocy=0.0
narkoKolorNieba=true
	narkoKolorNiebaTyp=0
		narkoKolorNieba1=0
]]


local narkotyki = {}
narkotyki[#narkotyki+1]={ narkoPodwojny=true, narkoID=0, narkoNazwa="Siurex", narkoCzas=20000, narkoWspolczynnik=0.5, narkoGrawitacja=true, narkoGrawitacjaMin=0.00005, narkoGrawitacjaMax=0.008 }
narkotyki[#narkotyki+1]={ narkoPodwojny=false, narkoID=1, narkoNazwa="Yazirix", narkoCzas=30000, narkoWspolczynnik=0.5, narkoGrawitacjaMin=0.005, narkoGrawitacjaMax=0.008, narkoPredkoscGry=true, narkoPredkoscGryMin=1, narkoPredkoscGryMax=2 }
narkotyki[#narkotyki+1]={ narkoPodwojny=false, narkoID=2, narkoNazwa="Giehapeelix", narkoCzas=15000, narkoSamozaplon=true, narkoSamozaplonProg=0.5, narkoWspolczynnik=0.5, narkoGrawitacjaMin=0.005, narkoGrawitacjaMax=0.008 }

local narkotyki2 = {}
narkotyki[#narkotyki+1]={ narkoID=0, narkoNazwa="Siurex", narkoCzas=20000, narkoMocMaksymalna=-1000, narkoWspolczynnik=0.5, narkoGrawitacjaMin=0.005, narkoGrawitacjaMax=0.008, narkoPredkoscGryMin=1, narkoPredkoscGryMax=2 }
narkotyki[#narkotyki+1]={}

local narkotykiLaczenie = {}
narkotykiLaczenie[#narkotykiLaczenie+1]={}



function narkoDodaj ( narkotykJaki )
	outputDebugString(narkotyki[tonumber(narkotykJaki)]["narkoSamozaplonProg"] )
	moc = math.sin(((index/(narkotyki[tonumber(narkotykJaki)]["narkoCzas"]/50))^narkotyki[tonumber(narkotykJaki)]["narkoWspolczynnik"])*math.pi)
	if narkotyki[tonumber(narkotykJaki)]["narkoGrawitacja"] == true then
		setGravity ( ((narkotyki[tonumber(narkotykJaki)]["narkoGrawitacjaMax"]-narkotyki[tonumber(narkotykJaki)]["narkoGrawitacjaMin"]))*(-moc)+narkotyki[tonumber(narkotykJaki)]["narkoGrawitacjaMax"] )
	end
	if narkotyki[tonumber(narkotykJaki)]["narkoPredkosc"]==true then
		setGameSpeed ( ((narkotyki[tonumber(narkotykJaki)]["narkoPredkoscGryMax"]-narkotyki[tonumber(narkotykJaki)]["narkoPredkoscGryMin"]))*moc+narkotyki[tonumber(narkotykJaki)]["narkoPredkoscGryMin"] )
	end
	--if narkotyki[tonumber(narkotykJaki)]["narkoSamozaplon"]==true then
		--if narkotyki[tonumber(narkotykJaki)]["narkoSamozaplonProg"] < moc then
		--	triggerServerEvent( "wiadomosc", localPlayer )
		--end
--	end
	index = index + 1

	setFarClipDistance( (math.abs(math.sin(index))+math.sin(index)+1)*150 )
end

function narkotyk ( nazwaKomendy, narkotykJaki )
	index = 0
	setTimer ( narkoDodaj, 50 , narkotyki[tonumber(narkotykJaki)]["narkoCzas"]/50, narkotykJaki )
end 
addCommandHandler( "n", narkotyk )


addEvent( "narkoOgienKlient", true )
addEventHandler( "narkoOgienKlient", root, 
function (pla)
	createFire(getElementPosition(pla), 2)
end )

----------------- KUPA -----------


-- function poop ( source )
--	local ix, iy, iz = getElementPosition( source )
--	fxAddWood ( ix, iy, iz, 0, 0, 0, 10, 0.7)
--end

--- 	setTimer ( poop, 50, 200, source )

--[[
function boom ( )
	local x, y, z = getElementPosition ( getLocalPlayer ( ) )
	createExplosion ( x, y, z, 7 )
end

function partikle ( )
	local x, y, z = getElementPosition ( getLocalPlayer ( ) )
	fxAddWood ( x, y, z, 0, 0, 0, 1000, 0.7)
end

function poop ( )
	-- get the local player's position
	local x, y, z = getElementPosition ( getLocalPlayer ( ) )
	setTimer ( partikle, 50, 100, getLocalPlayer ( ) )
	setTimer ( boom, 50*100+500, 1, getLocalPlayer ( ) )
end

addCommandHandler ( "kupa", poop)



function partikle ( )
	local x, y, z = getElementPosition ( getLocalPlayer ( ) )
	fxAddWood ( x, y, z, 0, 0, 0, 1000, 0.7)
end


function poopClientFunkcja ( playerSource )
	outputDebugString( "zrobil w majty" )
	local x,y,z = getElementPosition( localPlayer )
    setTimer ( partikle, 50, 100, getLocalPlayer ( ) )
end
addEvent( "poopClient", true )
addEventHandler( "poopClient", localPlayer, poopClientFunkcja )

outputDebugString( "[KP] ghpl client (server.lua) start" )
--]]
