dbase = dbConnect( "sqlite", "db/kpData.db")

addEventHandler( "onResourceStart", resourceRoot,
function (  )
	if dbase then
		dbExec( dbase, "CREATE TABLE IF NOT EXISTS clans ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, members	TEXT, membersMaxINTEGER, business	TEXT, balance	INTEGER, vehicles TEXT, settings TEXT, `bizModf` TEXT );")
		dbExec( dbase, "CREATE TABLE IF NOT EXISTS biz ( id INTEGER PRIMARY KEY AUTOINCREMENT, pos TEXT, bizType TEXT, clan TEXT, level INTEGER, cost INTEGER, buyableAfter INTEGER, name TEXT );")

		--[[
		dbQuery( 
		function ( qh )
			local result = dbPoll( qh, 0 )
			for k,v in ipairs(result) do
				local members = fromJSON( v["members"] )
				local changed = false
				local count = 0
				for k2,v2 in pairs( members ) do
					if getAccountData( getAccount( k2 ), "clan" ) == v["name"] then
						count = count+1
					else
						members[k2] = nil
						changed = true
					end	
				end
				if changed then
					local count2 = 0
					for k,v in pairs( members ) do
						count2 = count2+1
					end
					if count2 == 0 or count == 0 then
						dbExec( dbase, "DELETE FROM clans WHERE id = ?", v["id"]  )
						outputDebugString( "Removed clan "..v["name"] )
					elseif count == count2 then
						dbExec( dbase, "UPDATE clans SET members = ? WHERE id = ?", toJSON( members ), result[1]["id"] )
						outputDebugString( "Updated members clan "..v["name"] )
					end
				end
			end
		end, dbase, "SELECT * FROM clans")]]

		dbQuery( 
		function ( qh )
			local clans = dbPoll( qh, 0 )
			for k,clan in pairs( clans ) do
				local members = fromJSON( clan["members"] )
				local countRemoved = 0
				local countSum = 0
				for k2,member in pairs( members ) do
					countSum = countSum +1
					if getAccountData( getAccount( k2 ), "clan" ) ~= clan["name"] then
						members[k2] = nil
						countRemoved = countRemoved +1
						outputDebugString( "CLANS.DB removed account "..k2.." from clan "..clan["name"] )
					end
				end
				if countRemoved > 0 then
					dbExec( dbase, "UPDATE clans SET members = ? WHERE name = ?", toJSON( members ), clan["name"] )
					outputDebugString( "CLANS.DB updated members of clan "..clan["name"].." ("..countRemoved.."/"..countSum.." removed)" )
				end
				if countRemoved == countSum then
					dbExec( dbase, "DELETE FROM clans WHERE name = ?", clan["name"] )
					outputDebugString( "CLANS.DB deleted clan "..clan["name"] )
				end
			end
		end, dbase, "SELECT * FROM clans" )

		outputDebugString("kpData.db connected", nil, 0, 255, 0)
	else
		outputDebugString("kpData.db not connected", nil, 255, 0, 0)
	end

	--[[
	dbQuery( 
	function ( qh )
		local result = dbPoll( qh, 0 )
		for k,v in ipairs(result) do
			local pos = fromJSON( v["pos"] )
			createBlip( pos[1],pos[2],pos[3], 0 , 2, 255,255,0 )
		end
	end, dbase, "SELECT * FROM biz" )
	]]
end, nil, "high" )