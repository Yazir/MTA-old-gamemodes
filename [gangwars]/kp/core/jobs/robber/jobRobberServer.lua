--[[local jobMarker = createJobMarker( 2026.5893554688,-1301.3439941406,20, {job="burglar", blip=51} )
local vehMarker = createVehMarker( 2025.6772460938,-1294.0936279297,20, {job="burglar", veh=498, rz=270})
local deliveryPoint = createMarker( 2033.7611083984,-1284.7995605469,20.958938598633, "cylinder", 3, 50,225,50 )

addEvent( "onVehMarkerUsed" )
addEventHandler( "onVehMarkerUsed", vehMarker,
function ( veh, pla )
	local textEl = create3dText( 9999,9999,9999, "Burglar vehicle\nOwner: "..getPlayerName( pla ).."\nLoad: 0/10", 15, {120,120,120}, 1.4 )
	attachElements( textEl, veh )
	setElementData( pla, "jobRobberVehicle", veh )
end )

addEvent( "jobBurglarOnRemovePoints" )
function jobBurglarCreatePoint( pla )
	triggerEvent( "jobBurglarOnRemovePoints", pla )
	local points = getElementsByType( "loot" )
	local x,y,z = getElementPosition( points[math.random(1,#points)] )
	local blip = createBlip( x,y,z, 41, 1, 0,0,0,255, 0, nil, pla )
	local col = createColSphere( x, y, z, 8 )
	local marker = createMarker( x, y, z, "cylinder", 2, 255,50,50, 150)
	local obj = createObject( 2912, x, y, z )
	setElementParent( marker, col )
	setElementVisibleTo( marker, root, false )
	setElementVisibleTo( marker, pla, false )
	setElementParent( blip, col )
	addEventHandler( "jobBurglarOnRemovePoints", pla, function() if isElement( col ) then destroyElement( col ) end end )
	addEventHandler( "onColShapeHit", col,
	function ( el, md )
		if md and el == pla and not isPedInVehicle( el ) then
			--jobBurglarCreatePoint( pla )
			--outputChatBox( "Robbed house", pla )
			--local exp, money = math.random( 2, 4 ), math.random( 6,8 )
			--addExp( pla, exp )
			--addMoney( pla, money )
			--outputChatBox( "[Job:Burglar] You found "..money.."$ in the house and earned "..exp.."XP!", pla, 50,200,50 )
			attachElements( obj, pla, 0.3 )

		end
	end )
end

function jobBurglarRob( pla )
	-- body
end

addEventHandler( "onJobInit", root,
function ( job )
	if job == "burglar" then
		jobBurglarCreatePoint( source )
	end
end )]]