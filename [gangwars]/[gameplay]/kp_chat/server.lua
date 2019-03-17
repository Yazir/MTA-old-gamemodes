-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.
local plaMsgCount = {}
local blockedWords = { "kurwo","kurwa", "zjeb", "cwel", "frajer", "( ͡° ͜ʖ ͡°)", "spierdalaj", "skurwiel", "huj", "pizda", "dziwka", "jebany", "pedał", "szmata", "kutas", "jebał", "jebal", "cfel", "morda", "pizdo", "kutafon", "szmato"  }
local replaceWords = { "*" }

addEventHandler( "onPlayerChat", root,
function ( msg, msgType )
	local gangTable = exports.kp:getGangTable()
	local pla = source
	local lobbys = exports.kp:getLobbys()
	if msgType == 0 then
		if not plaMsgCount[pla] then plaMsgCount[pla] = 0 end
		if plaMsgCount[pla] < 3 then
			plaMsgCount[pla] = plaMsgCount[pla]+1
			local pla = source
			local acc = getPlayerAccount( source ) 
			local dim = getElementDimension( source )
			local room = ""
			local gangprefix = ""
			local lvl = ""
			local roomc, namec, msgc = "#56555B", "#ACAAB7", "#D7D5E5"
			local gang = getElementData( source, "gang" )
			local cT = getElementData( source, "chatColors" )
			if cT then roomc, namec, msgc = cT.room, cT.name, cT.msg end
			if gangTable[gang] then gangprefix = gangTable[gang]["chatprefix"] end
			if getAccount( "Yazir" ) == getPlayerAccount( pla ) then namec = "#BF0000" end
			if lobbys[dim] and lobbys[dim]["name"] then room = lobbys[dim]["name"] else room = "L" end
			if getElementData( pla, "lvl" ) then lvl = "["..getElementData( pla, "lvl" ).."]" end
			local origMsg = msg
			for _,v in ipairs( blockedWords ) do
				msg = gisub( msg, v, replaceWords[math.random(1,#replaceWords)] )
			end
			if origMsg ~= msg then triggerClientEvent( "onJezus", source, source ) end
			outputChatBox( gangprefix..roomc.."["..room.."]"..namec.." "..getPlayerName( source )..lvl..msgc..": "..msg, root, nil, nil, nil, true )
		else
			plaMsgCount[pla] = plaMsgCount[pla]+1
			outputChatBox( "[Chat] Blokada spamu.", source, 225,25,25 )
		end
		cancelEvent(  )
	end
end )

function gisub(s, pat, repl, n)
    pat = string.gsub(pat, '(%a)', 
               function (v) return '['..string.upper(v)..string.lower(v)..']' end)
    if n then
        return string.gsub(s, pat, repl, n)
    else
        return string.gsub(s, pat, repl)
    end
end

setTimer( 
function (  )
	for k,v in pairs( plaMsgCount ) do
		if v > 0 then
			plaMsgCount[k]=v-1
		end
	end
end, 4000, 0 )

local messages = {
	"#7d8fd7Dołącz do naszego serwera #2b90f5Discord #7d8fd7! Link: #2b90f5discord.gg/3DzbGsj",
	"#7d8fd7Zaproś swoich #2b90f5przyjaciół!",
	--"#7d8fd7Every player before 17.3.17 got an #2b90f5unique skin!",
	"#2b90f5Przekleństwa #7d8fd7i #2b90f5obrazy #7d8fd7skutkują #2b90f5mutem #7d8fd7albo nawet #2b90f5banem!",
	"#7d8fd7Odwiedź nasze forum #2b90f5mtakp.pl!",
	"#7d8fd7Możesz obrócić swój pojazd poprzez #2b90f5/fix!",
}
local msgcount = 1
setTimer( function (  )
	outputChatBox( "#2f3d7b[Announce] " .. messages[msgcount], root, nil, nil, nil, true )
	msgcount = msgcount+1
	if msgcount > #messages then msgcount = 1 end
end, 1000*120, 0 )

outputDebugString( "[KP] kp_chat (server.lua) start" )