-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

itemTable = {
	skinHarley= 	{name="(F)Harley Quinn",			use="skin", 	cat="Model gracza",		desc="Well known Jared Leto Joker's girl.",												image="skinHarley.png", skinID=63,	destroy=0},
	skinGtav= 		{name="(M)Clothes-V", 				use="skin",		cat="Model gracza",		desc="GTA:Online character dressed and converted.",										image="skinGtav.png", skinID=82,	destroy=0},
	skinEarlyplayer={name="(M)Early player", 			use="skin",		cat="Model gracza",		desc="Dziękujemy za to, że jesteś z nami od początku!",									image="noicon.png", skinID=248,		destroy=0},
	default=	 	{name="(M)Default", 				use="skin",		cat="Model gracza",		desc="Podstawowy model gracza.",														image="noicon.png", skinID=73,		destroy=0},
	ballas1=	 	{name="(M)Gang: Ballas 1", 			use="skin",		cat="Model gracza",		desc="Gang skin.",																		image="ballas1.png", skinID=102,	destroy=0},
	ballas2=	 	{name="(M)Gang: Ballas 2", 			use="skin",		cat="Model gracza",		desc="Gang skin.",																		image="ballas2.png", skinID=103,	destroy=0},
	ballas3=	 	{name="(M)Gang: Ballas 3", 			use="skin",		cat="Model gracza",		desc="Gang skin.",																		image="ballas3.png", skinID=104,	destroy=0},
	grove1=	 		{name="(M)Gang: Grove 1", 			use="skin",		cat="Model gracza",		desc="Gang skin.",																		image="grove1.png", skinID=105,		destroy=0},
	grove2=	 		{name="(M)Gang: Grove 2", 			use="skin",		cat="Model gracza",		desc="Gang skin.",																		image="grove2.png", skinID=106,		destroy=0},
	grove3=	 		{name="(M)Gang: Grove 3", 			use="skin",		cat="Model gracza",		desc="Gang skin.",																		image="grove3.png", skinID=107,		destroy=0},
	police1=	 	{name="(M)Organizacja: Police 1", 	use="skin",		cat="Model gracza",		desc="Police deputy skin.",																image="cop1.png", skinID=280,		destroy=0},
	police2=	 	{name="(M)Organizacja: Police 2", 	use="skin",		cat="Model gracza",		desc="Police deputy skin.",																image="cop2.png", skinID=281,		destroy=0},
	police3=	 	{name="(M)Organizacja: Police 3", 	use="skin",		cat="Model gracza",		desc="Police deputy skin.",																image="cop3.png", skinID=284,		destroy=0},
	vagos1=	 		{name="(M)Gang: Vagos 1", 			use="skin",		cat="Model gracza",		desc="Wygląd członka gangu vagos.",														image="noicon.png", skinID=108,		destroy=0},
	vagos2=	 		{name="(M)Gang: Vagos 2", 			use="skin",		cat="Model gracza",		desc="Wygląd członka gangu vagos.",														image="noicon.png", skinID=109,		destroy=0},
	vagos3=	 		{name="(M)Gang: Vagos 3", 			use="skin",		cat="Model gracza",		desc="Wygląd członka gangu vagos.",														image="noicon.png", skinID=110,		destroy=0},
	rus1=	 		{name="(M)Gang: Ruska Mafia 1", 	use="skin",		cat="Model gracza",		desc="Wygląd członka Rosyjskiej Mafii.",												image="noicon.png", skinID=111,		destroy=0},
	rus2=	 		{name="(M)Gang: Ruska Mafia 2", 	use="skin",		cat="Model gracza",		desc="Wygląd członka Rosyjskiej Mafii.",												image="noicon.png", skinID=112,		destroy=0},
	rus3=	 		{name="(M)Gang: Ruska Mafia 3", 	use="skin",		cat="Model gracza",		desc="Wygląd członka Rosyjskiej Mafii.",												image="noicon.png", skinID=113,		destroy=0},
	nomad1=	 		{name="(M)Gang: Odludek 1", 		use="skin",		cat="Model gracza",		desc="Wygląd odludka.",																	image="noicon.png", skinID=230,		destroy=0},
	nomad2=	 		{name="(M)Gang: Odludek 2", 		use="skin",		cat="Model gracza",		desc="Wygląd odludka.",																	image="noicon.png", skinID=312,		destroy=0},
	nomad3=	 		{name="(M)Gang: Odludek 3", 		use="skin",		cat="Model gracza",		desc="Wygląd odludka.",																	image="noicon.png", skinID=32,		destroy=0},
	aztecas1=		{name="(M)Gang: Aztecas 1", 		use="skin",		cat="Model gracza",		desc="Wygląd członka gangu aztecas.",													image="noicon.png", skinID=114,		destroy=0},
	aztecas2=		{name="(M)Gang: Aztecas 2", 		use="skin",		cat="Model gracza",		desc="Wygląd członka gangu aztecas.",													image="noicon.png", skinID=115,		destroy=0},
	aztecas3=		{name="(M)Gang: Aztecas 3", 		use="skin",		cat="Model gracza",		desc="Wygląd członka gangu aztecas.",													image="noicon.png", skinID=116,		destroy=0},
	diesel=	 		{name="(M)Skórka Patrona", 			use="skin",		cat="Model gracza",		desc="Vin diesel.",																		image="noicon.png", skinID=16,		destroy=0},
	pv2=	 		{name="(M)Skórka Patrona", 			use="skin",		cat="Model gracza",		desc="Facet ze złotą maską czaszki.",													image="noicon.png", skinID=17,		destroy=0},
}

function getGlobalItemTable( )
	return itemTable
end

function getGlobalItem( itemID )
	local item = itemTable[itemID]
	if item then return item
	else outputDebugString( "kp_inventory: no item with id "..itemID..".", 1 ) return false
	end
end