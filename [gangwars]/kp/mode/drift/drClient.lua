-- textlib

-- modified by 50p (7 Jun 2012)
-- * added: custom font support


dxText = {}
dxText_mt = { __index = dxText }
local idAssign,idPrefix = 0,"c"
local g_screenX,g_screenY = guiGetScreenSize()
local visibleText = {}
------
defaults = {
	fX							= 0.5,
	fY							= 0.5,
	bRelativePosition			= true,
	strText						= "",
	bVerticalAlign 				= "center",
	bHorizontalAlign 			= "center",
	tColor 						= {255,255,255,255},
	fScale 						= 1,
	strFont 					= "default",
	strType						= "normal",
	tAttributes					= {},
	bPostGUI 					= false,
	bClip 						= false,
	bWordWrap	 				= true,
	bVisible 					= true,
	tBoundingBox				= false, --If a bounding box is not set, it will not be used.
	bRelativeBoundingBox		= true,
}

local validFonts = {
	default						= true,
	["default-bold"]			= true,
	clear						= true,
	arial						= true,
	pricedown					= true,
	bankgothic					= true,
	diploma						= true,
	beckett						= true,
}

local validTypes = {
	normal						= true,
	shadow						= true,
	border						= true,
	stroke						= true, --Clone of border
}

local validAlignTypes = {
	center						= true,
	left						= true,
	right						= true,
}

function dxText:create( text, x, y, relative, strFont, fScale, horzA )
	assert(not self.fX, "attempt to call method 'create' (a nil value)")
	if ( type(text) ~= "string" ) or ( not tonumber(x) ) or ( not tonumber(y) ) then
		outputDebugString ( "dxText:create - Bad argument", 0, 112, 112, 112 )
		return false
	end
    local new = {}
	setmetatable( new, dxText_mt )
	--Add default settings
	for i,v in pairs(defaults) do
		new[i] = v
	end
	idAssign = idAssign + 1
	new.id = idPrefix..idAssign
	new.strText = text or new.strText
	new.fX = x or new.fX
	new.fY = y or new.fY
	if type(relative) == "boolean" then
		new.bRelativePosition = relative
	end
	new:scale( fScale or new.fScale )
	new:font( strFont or new.strFont )
	new:align( horzA or new.bHorizontalAlign )
	visibleText[new] = true
	return new
end

function dxText:text(text)
	if type(text) ~= "string" then return self.strText end
	self.strText = text
	return true
end

function dxText:position(x,y,relative)
	if not tonumber(x) then return self.fX, self.fY end
	self.fX = x
	self.fY = y
	if type(relative) == "boolean" then
		self.bRelativePosition = relative
	else
		self.bRelativePosition = true
	end
	return true
end

function dxText:color(r,g,b,a)
	if not tonumber(r) then return unpack(self.tColor) end
	g = g or self.tColor[2]
	b = b or self.tColor[3]
	a = a or self.tColor[4]
	self.tColor = { r,g,b,a }
	return true
end

function dxText:scale(scale)
	if not tonumber(scale) then return self.fScale end
	self.fScale = scale
	return true
end

function dxText:visible(bool)
	if type(bool) ~= "boolean" then return self.bVisible end
	if self.bVisible == bool then return end
	self.bVisible = bool
	if bool then
		visibleText[self] = true
	else
		visibleText[self] = nil
	end
	return true
end

function dxText:destroy()
	self.bDestroyed = true
	setmetatable( self, self )
	return true
end

function dxText:font(font)
	if not validFonts[font] and ( type( font ) == "nil" or type( font ) == "string" ) then return self.strFont end
	self.strFont = font
	return true
end

function dxText:postGUI(bool)
	if type(bool) ~= "boolean" then return self.bPostGUI end
	self.bPostGUI = bool
	return true
end

function dxText:clip(bool)
	if type(bool) ~= "boolean" then return self.bClip end
	self.bClip = bool
	return true
end

function dxText:wordWrap(bool)
	if type(bool) ~= "boolean" then return self.bWordWrap end
	self.bWordWrap = bool
	return true
end

function dxText:type(type,...)
	if not validTypes[type] then return self.strType, unpack(self.tAttributes) end
	self.strType = type
	self.tAttributes = {...}
	return true
end

function dxText:align(horzA, vertA)
	if not validAlignTypes[horzA] then return self.bHorizontalAlign, self.bVerticalAlign end
	vertA = vertA or self.bVerticalAlign
	self.bHorizontalAlign, self.bVerticalAlign = horzA, vertA
	return true
end

function dxText:boundingBox(left,top,right,bottom,relative)
	if left == nil then
		if self.tBoundingBox then
			return unpack(boundingBox)
		else
			return false
		end
	elseif tonumber(left) and tonumber(right) and tonumber(top) and tonumber(bottom) then
		self.tBoundingBox = {left,top,right,bottom}
		if type(relative) == "boolean" then
			self.bRelativeBoundingBox = relative
		else
			self.bRelativeBoundingBox = true
		end
	else
		self.tBoundingBox = false
	end
	return true
end

addEventHandler ( "onClientRender", getRootElement(),
	function()
		for self,_ in pairs(visibleText) do
			while true do
				if self.bDestroyed then
					visibleText[self] = nil
					break
				end
				if self.tColor[4] < 1 then
					break
				end
				local l,t,r,b
				--If we arent using a bounding box
				if not self.tBoundingBox then
					--Decide if we use relative or absolute
					local p_screenX,p_screenY = 1,1
					if self.bRelativePosition then
						p_screenX,p_screenY = g_screenX,g_screenY
					end
					local fX,fY = (self.fX)*p_screenX,(self.fY)*p_screenY
					if self.bHorizontalAlign == "left" then
						l = fX
						r = fX + g_screenX
					elseif self.bHorizontalAlign == "right" then
						l = fX - g_screenX
						r = fX
					else
						l = fX - g_screenX
						r = fX + g_screenX
					end
					if self.bVerticalAlign == "top" then
						t = fY
						b = fY + g_screenY
					elseif self.bVerticalAlign == "bottom" then
						t = fY - g_screenY
						b = fY
					else
						t = fY - g_screenY
						b = fY + g_screenY
					end
				elseif type(self.tBoundingBox) == "table" then
					local b_screenX,b_screenY = 1,1
					if self.bRelativeBoundingBox then
						b_screenX,b_screenY = g_screenX,g_screenY
					end
					l,t,r,b = self.tBoundingBox[1],self.tBoundingBox[2],self.tBoundingBox[3],self.tBoundingBox[4]
					l = l*b_screenX
					t = t*b_screenY
					r = r*b_screenX
					b = b*b_screenY
				end
				local type,att1,att2,att3,att4,att5 = self:type()
				if type == "border" or type == "stroke" then
					att2 = att2 or 0
					att3 = att3 or 0
					att4 = att4 or 0
					att5 = att5 or self.tColor[4]
					outlinesize = att1 or 2
					if outlinesize > 0 then
						for offsetX=-outlinesize,outlinesize,outlinesize do
							for offsetY=-outlinesize,outlinesize,outlinesize do
								if not (offsetX == 0 and offsetY == 0) then
									dxDrawText(self.strText, l + offsetX, t + offsetY, r + offsetX, b + offsetY, tocolor(att2, att3, att4, att5), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI )
								end
							end
						end
					end
				elseif type == "shadow" then
					local shadowDist = att1
					att2 = att2 or 0
					att3 = att3 or 0
					att4 = att4 or 0
					att5 = att5 or self.tColor[4]
					dxDrawText(self.strText, l + shadowDist, t + shadowDist, r + shadowDist, b + shadowDist, tocolor(att2, att3, att4, att5), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI )
				end
				dxDrawText ( self.strText, l, t, r, b, tocolor(unpack(self.tColor)), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI )
				break
			end
		end
	end
)

if addEvent ( "updateDisplays", true ) then
	addEventHandler ( "updateDisplays", getRootElement(),
		function(self)
			setmetatable( self, dxText_mt )
			--Remove any old ones with the same id
			for text,_ in pairs(visibleText) do
				if text.id == self.id then
					visibleText[text] = nil
				end
			end
			if self.bVisible and not self.bDestroyed then
				visibleText[self] = true
			end
		end
	)
end


-- vector3



Vector3 = { };
Vector3.__index = Vector3;


function Vector3:new( x, y, z )
	if type( x ) == "string" then
		local temp = string.sub( x, 2, -2 ); -- remove [ and ] from START and END of the string
		temp = split( temp, "," ); -- split by comma
		x = tonumber( temp[ 1 ] );
		y = tonumber( temp[ 2 ] );
		z = tonumber( temp[ 3 ] );
	end
	if ( type( x ) == "number" ) and ( not y ) and ( not z ) then
		x, y, z = x, x, x;
	end
	local vec3 = {
		x = x and x or 0,
		y = y and y or 0,
		z = z and z or 0,
	}
	self.__index = self;
	setmetatable( vec3, self );
	return vec3;
end

function Vector3: up( )
	return Vector3: new( 0, 0, 1 );
end

function Vector3: down( )
	return Vector3: new( 0, 0, -1 );
end

function Vector3: right( )
	return Vector3: new( 1, 0, 0 );
end

function Vector3: left( )
	return Vector3: new( -1, 0, 0 );
end

function Vector3: forward( )
	return Vector3: new( 0, 1, 0 );
end

function Vector3: backward( )
	return Vector3: new( 0, -1, 0 );
end

function Vector3: elementOffsetPosition( eElem, vOffset )
	if eElem then
		vOffset = vOffset and vOffset or Vector3: zero( );
		local m = getElementMatrix ( eElem )
		local x = vOffset.x * m[1][1] + vOffset.y * m[2][1] + vOffset.z * m[3][1] + m[4][1];
		local y = vOffset.x * m[1][2] + vOffset.y * m[2][2] + vOffset.z * m[3][2] + m[4][2];
		local z = vOffset.x * m[1][3] + vOffset.y * m[2][3] + vOffset.z * m[3][3] + m[4][3];
		return Vector3: new( x, y, z );
	end
end


-- returns x, y and z respectively
function Vector3: explode( )
	return self.x, self.y, self.z;
end


function Vector3: zero( )
	return Vector3:new( 0 );
end


function Vector3: one( )
	return Vector3:new( 1 );
end


function Vector3: add( vec3 )
	if type( vec3 ) == "table" then
		return Vector3: new( self.x + vec3.x, self.y + vec3.y, self.z + vec3.z );
	elseif type( vec3 ) == "number" then
		return Vector3: new( self.x + vec3, self.y + vec3, self.z + vec3 );
	end
end


function Vector3: sub( vec3 )
	if type( vec3 ) == "table" then
		return Vector3: new( self.x - vec3.x, self.y - vec3.y, self.z - vec3.z );
	elseif type( vec3 ) == "number" then
		return Vector3: new( self.x - vec3, self.y - vec3, self.z - vec3 );
	end
end


function Vector3: mul( vec3 )
	if type( vec3 ) == "table" then
		return Vector3: new(  self.x * vec3.x, self.y * vec3.y, self.z * vec3.z );
	elseif type( vec3 ) == "number" then
		return Vector3: new(  self.x * vec3, self.y * vec3, self.z * vec3 );
	end
end


function Vector3: div( vec3 )
	return Vector3: new( self.x / vec3.x, self.y / vec3.y, self.z / vec3.z );
end


-- returns length (or magnitude) of the vector
function Vector3: length( )
	return math.sqrt( self.x^2 + self.y^2 + self.z^2 );
end


-- returns normalized vector (values of x, y and z will be between 0 and 1)
function Vector3: normalize( )
	return self:div( Vector3:new( self:length() ) );
end


-- returns a pointing direction of the vector
function Vector3: direction2D( )
	return math.deg( math.atan2( self.x, self.y ) );
end


-- returns dot product of 2 vectors
function Vector3: dot( vec3 )
	local mul = self:mul( vec3 );
	return mul.x + mul.y + mul.z;
end


-- returns cross product vector of 2 vectors
function Vector3: cross( vec3 )
	assert( type( vec3 ) == "table", "Vector3: cross - pass vector3 as an argument" );
	if type( vec3 ) ~= "table" then return false; end
	local fX = self.y * vec3.z - self.z * vec3.y;
	local fY = self.z * vec3.x - self.x * vec3.z;
	local fZ = self.x * vec3.y - self.y * vec3.x;
	return Vector3: new( fX, fY, fZ );
end


-- returns an angle between 2 vectors
function Vector3: angle( vec3 )
	-- formula:      vec x vec 
	--		ang = ---------------
	--			  sqrt of ( magnitude * magnitude )
	return math.deg( math.acos( self:dot( vec3 ) / math.sqrt( self:length( ) * vec3:length( ) ) ) );
end


-- inverses the vector
function Vector3: inverse( )
	return self:mul( -1 );
end


function Vector3: interpolate( vTarget, fFactor )
	if type( vTarget ) ~= "table" then return false; end
	if fFactor < 0 then fFactor = 0; end
	if fFactor > 1 then fFactor = 1; end
	return self: add( vTarget: sub( self ):mul( fFactor ) );
end


function Vector3: print( )
	outputDebugString( "< " .. tostring( self.x ) .. " ,  " .. tostring( self.y ) .. " ,  ".. tostring( self.z ) .. " >" );
end


function Vector3: tostring( )
	return "< " .. tostring( self.x ) .. " ,  " .. tostring( self.y ) .. " ,  ".. tostring( self.z ) .. " >";
end

function Vector3: draw( vOffset, iColour )
	if type( vOffset ) == "table" then
		dxDrawLine3D( vOffset.x, vOffset.y, vOffset.z, self.x + vOffset.x, self.y + vOffset.y, self.z + vOffset.z, iColour and iColour or COLOUR.RED, 5, false, 0 );
	elseif type( vOffset ) == "number" then
		dxDrawLine3D( 0, 0, 0, self.x, self.y, self.z, vOffset, 5, false, 0 );
	else 
		dxDrawLine3D( 0, 0, 0, self.x, self.y, self.z, tocolor( 255, 0, 0 ), 5, false, 65635 );
	end
end

-- c_main

addEvent( "onClientVehicleStartDrift" );
addEvent( "onClientVehicleEndDrift" );
addEvent( "onClientVehicleDrift" );
addEvent( "onClientVehicleDriftCombo" );

g_Me = localPlayer;
screenSize = { guiGetScreenSize( ) };

local gShowMeter = false;
local bIfDrifting = false;
local iStartDriftTick = 0;
local iCurrentTick = 0;
local iDriftTime = 0;
local iEndDriftTick = 0;
local iBackToDriftMS = 2000;
local iLastFrameTick = 0;

local iMinDriftAngle = 10;
local iMaxDriftAngle = 85;

local sDriftDir = "";
local bContinuosDrift = false;
local iDriftCombo = 1;
local iMaxCombo = 500;

--local mMeterMat = dxCreateTexture( "images/drift_gauge.png" );
--local mNeedleMat = dxCreateTexture( "images/needle.png" );
--local vMeterSize = Vector2: new( dxGetMaterialSize( mMeterMat ) );
--local vNeedleSize = Vector2: new( dxGetMaterialSize( mNeedleMat ) );
--local vMeterPos = Vector2:new( screenSize[ 1 ] / 2 - vMeterSize.x/2, screenSize[ 2 ] - 150 );


function getPlayerSpeed( )
	local veh = getPedOccupiedVehicle( g_Me );
	local x, y, z = getElementVelocity( veh and veh or g_Me );
	return math.sqrt( x^2 + y^2 + z^2 ) * 160;
end

addCommandHandler( "showdriftmeter", 
	function( _, show )
		gShowMeter = show and show == "true" and true or false
	end
)


addEventHandler( "onClientRender", root, 
	function( )
		local dim = getElementDimension( localPlayer )
		if dim>0 and lobbys and lobbys[dim] and lobbys[dim]["type"] == "dr" then
			local eVeh = getPedOccupiedVehicle( g_Me );
			
			iCurrentTick = getTickCount( );
			
			if eVeh then
				
				if gShowMeter then
					--dxDrawImage( vMeterPos.x, vMeterPos.y, vMeterSize.x, vMeterSize.y, "images/drift_gauge.png" );
				end
				
				local vVel = Vector3: new( getElementVelocity( eVeh ) );
				local fVelocity = vVel:length( ) * 160;
				local vVel2 = vVel:mul( 2 );
				
				local vVehPos = Vector3: new( getElementPosition( eVeh ) );
				local fDriveDir = vVel:direction2D( );
				local vRot = Vector3: new( getElementRotation( eVeh ) );
				local fRot = vRot.z;
				
				local vOffset = Vector3: elementOffsetPosition( eVeh, Vector3: new( 0, 5, 0 ) );
				vOffset = vOffset:sub( vVehPos );
				
				local vCross = vOffset:cross( vVel2 );
				local fNormal = vCross:dot( Vector3: new( 0,0, 4 ) );
				if fNormal > 0 then
					sDriftDir = "right";
				elseif fNormal < 0 then
					sDriftDir = "left";
				end
				
				if fDriveDir < 0 then -- NORTH -> TO WEST -> TO SOUTH
					fDriveDir = fDriveDir * -1;
				elseif fDriveDir > 0 then -- NORTH -> TO EAST -> TO SOUTH
					fDriveDir = 360 - fDriveDir;
				end
				
				local fDriftAng = math.abs( fRot - fDriveDir );
				if fDriftAng > 140 then
					if fRot < 360 and fRot > 180 and fDriveDir > 0 and fDriveDir < 180 then
						fDriftAng = 360 - fRot + fDriveDir;
					elseif fRot < 180 and fRot > 0 and fDriveDir > 180 and fDriveDir < 360 then
						fDriftAng = ( 360 - fDriveDir ) + fRot;
					end
				end
				
				if fVelocity < 1 or fDriftAng < 1 then
					sDriftDir = "";
					fDriftAng = 0;
				end
				
				--[[
				dxDrawText( "VEH ROT: " .. tostring( fRot ), 10, 300 );
				dxDrawText( "DRIVE DIR: " .. tostring( fDriveDir ), 10, 320 );
				dxDrawText( "VELOCITY DIR: " .. tostring( vVel:direction2D( ) ), 250, 320 );
				dxDrawText( "DRIFT angle: " .. tostring( fDriftAng ), 10, 350 );
				dxDrawText( "VELOCITY: " .. tostring( fVelocity ), 10, 380 );
				dxDrawText( "DRIFT DIR: " .. sDriftDir, 10, 400 );			
				--]]
				
				local r, g, b = 255, 0, 0;
				local fAngPercent = ( fDriftAng / iMaxDriftAngle ) * 4;
				if fAngPercent > 0 and fAngPercent < 1 then
					r = 255;
					g = 255 * fAngPercent;
				elseif fAngPercent > 1 and fAngPercent < 2 then
					r = 255 * (2 - fAngPercent);
					g = 255;
				elseif fAngPercent > 2 and fAngPercent < 3 then
					r = 255 * (1 - (4 - fAngPercent));
					g = 255;
				elseif fAngPercent > 3 and fAngPercent < 4 then
					r = 255;
					g = 255 * (5 - fAngPercent);
				end
				
				cDriftColour = tocolor( r, g, b );
				
				if gShowMeter then
					local needleAngle = fDriftAng < iMaxDriftAngle and fDriftAng or iMaxDriftAngle;
					needleAngle = sDriftDir == "right" and needleAngle or needleAngle * -1;
					
					--dxDrawImage(
						--vMeterPos.x + vMeterSize.x/2 - vNeedleSize.x/2,
						--vMeterPos.y + 10,
						--vNeedleSize.x,
						--vNeedleSize.y,
						--"images/needle.png",
						--needleAngle, 0, 45, cDriftColour
					--);
				end
				
				
				if fVelocity > 50 and fDriftAng > iMinDriftAngle and not bContinuosDrift and not bIsDrifting and isVehicleOnGround( eVeh ) then -- start DRIFT
					bIsDrifting = true;
					bContinuosDrift = true;
					triggerEvent( "onClientVehicleStartDrift", eVeh, fVelocity );
					triggerEvent( "onVehicleDrift", eVeh, fVelocity );
					iStartDriftTick = iCurrentTick;
					iDriftTime = 0;
				elseif ( ( fVelocity < 50 and fVelocity ~= 0 ) or fDriftAng < iMinDriftAngle ) and bIsDrifting or not isVehicleOnGround( eVeh ) then -- valid when stopped meeting requirements (still in drift)
					bIsDrifting = false;
					iEndDriftTick = iCurrentTick;
				elseif fVelocity > 50 and fDriftAng > iMinDriftAngle and bContinuosDrift and not bIsDrifting then -- triggered to back on drift (+1 combo)
					bIsDrifting = true;
					iStartDriftTick = iCurrentTick;
					if iDriftCombo < iMaxCombo then
						iDriftCombo = iDriftCombo + 0.1;
						triggerEvent( "onClientVehicleDriftCombo", eVeh, iDriftCombo );
					end
				elseif not bIsDrifting and bContinuosDrift then -- called when stopped 1 drift but has chance for combo
					if iCurrentTick - iEndDriftTick >= iBackToDriftMS then
						triggerEvent( "onClientVehicleEndDrift", eVeh, iDriftTime, iDriftCombo );
						triggerEvent( "onVehicleEndDrift", eVeh, iDriftTime, iDriftCombo );
						bContinuosDrift = false;
						bIsDrifting = false;
						iEndDriftTick = 0;
						iDriftTime = 0;
						iDriftCombo = 1;
					end
				elseif bIsDrifting and bContinuosDrift then
					iDriftTime = iDriftTime + (iCurrentTick - iLastFrameTick);
					triggerEvent( "onClientVehicleDrift", eVeh, fDriftAng, fVelocity, sDriftDir, iDriftTime );
				end
				
			end
			iLastFrameTick = iCurrentTick;
		end
	end
)

-- c_drift



local iDriftScore = 0;
local iMaxScore = 0;
local iScore = 0;
local iMyCombo = 1;
local fCustomFontScale = 2;
local bJustFinished = false;

addEventHandler( "onClientLeaveLobby", localPlayer,
function(  )
	local dim = getElementDimension( localPlayer )
	if dim>0 and lobbys and lobbys[dim]["type"] == "dr" then
		txtCombo: visible(false)
		txtScore: visible(false)
		iDriftScore = 0;
		iMaxScore = 0;
		iScore = 0;
		iMyCombo = 1;
		fCustomFontScale = 2;
		bJustFinished = false;
	end
end)

addEventHandler( "onClientResourceStart", resourceRoot,
	function(  )
	
		dxSetTestMode( "none" );
		
	
		txtCombo = dxText: create( "x2", screenSize[ 1 ] - 100, screenSize[ 2 ] / 2 , false, "default-bold", 5 );
		txtCombo: type( "shadow", 4 );
		txtCombo: visible( false );		
		
		--txtComboTitle = dxText: create( "COMBO", screenSize[ 1 ] * 0.9, screenSize[ 2 ] / 2 - 60, false, "default-bold", 3 );
		--txtComboTitle: type( "shadow", 3 );
		--txtComboTitle: visible( false );
		
		--txtScoreTitle = dxText: create( "DRIFT", screenSize[ 1 ] / 2, screenSize[ 2 ] / 5.6, false, "default-bold", 3 );
		--txtScoreTitle: type( "shadow", 3 );
		--txtScoreTitle: visible( false );
		txtScore = dxText: create( "", screenSize[ 1 ] / 2, screenSize[ 2 ] / 4, false, "default-bold", 3 );
		txtScore: visible( false );
		txtScore: type( "shadow", 3 );
		txtScore: scale(1.5)
		
		--txtBestScore = dxText: create( "Best score: 0", screenSize[ 1 ] * 0.8, 20, false, "arial", 2 );
		--txtBestScore: type( "shadow", 2 );
		
	end
)

addEventHandler( "onClientVehicleStartDrift", root,
	function( )
		local dim = getElementDimension( localPlayer )
		if dim>0 and lobbys and lobbys[dim]["type"] == "dr" then
			addEventHandler( "onClientVehicleDrift", root, drift );
			if not bJustFinished then
				txtScore: text( "0" );
				txtScore: visible( true );
				--txtScoreTitle: visible( true );
				local r,g,b,a = txtScore: color(255, 165, 0 );
				txtScore: color( r, g, b, 255 );
			end
		end
	end
)

addEventHandler( "onClientVehicleEndDrift", root,
	function( )
		removeEventHandler( "onClientVehicleDrift", root, drift );
		
		iLastScore = math.floor(iDriftScore * iMyCombo);
		txtCombo: visible( false );
		--txtComboTitle: visible( false );
		txtScore: text( tostring( iLastScore ) );
		txtScore: scale(2)
		txtScore: color(240,30,30)
		--Animation.createAndPlay( txtScore, 
		--	Animation.presets.dxTextMove( 
		--		screenSize[ 1 ] / 2,
		--		screenSize[ 2 ] / 4,
		--		100, false,
		--		screenSize[ 1 ] * .3,
		--		screenSize[ 2 ] / 4
		--		)
		--);
		--Animation.createAndPlay( txtScore, Animation.presets.dxTextFadeIn( 100 ) );

		--Animation.createAndPlay( txtScoreTitle, 
		--	Animation.presets.dxTextMove( 
		--		screenSize[ 1 ] / 2,
		--		screenSize[ 2 ] / 5.6,
		--		100, false,
		--		screenSize[ 1 ] * .7,
		--		screenSize[ 2 ] / 5.6
		--		)
		--);
		--Animation.createAndPlay( txtScoreTitle, Animation.presets.dxTextFadeIn( 300 ) );

		if iLastScore > getElementData(localPlayer,"drHiScore") then
			--txtBestScore: text( "Hiscore: " .. tostring( iLastScore ) )
			setElementData( localPlayer, "drHiScore", iLastScore )
			triggerServerEvent( "drUpdateScore", localPlayer, iLastScore )
		end
		
		bJustFinished = true;
		setTimer( changeFinishedState, 2000, 1 );
		setTimer( centreScore, 100, 1 );
		
		iDriftScore = 0;
		iMyCombo = 1;
	end
)

addEventHandler( "onClientVehicleDriftCombo", root, 
	function( iCombo )
		txtCombo: text( "x"..tostring( iCombo ) );
		txtCombo: visible( true );
		--txtComboTitle: visible( true );
		playSoundFrontEnd( 43 );
		
		--Animation.createAndPlay( txtCombo, Animation.presets.dxTextMoveResize( 
		--	screenSize[ 1 ] * 0.9,
		--	screenSize[ 2 ] / 2 - 10,
		--	ftDigitalism and fCustomFontScale*.75 or 5,
		--	300, false, -- time, loop,
		--	screenSize[ 1 ] * 0.9,
		--	screenSize[ 2 ] / 2 - 10,
		--	ftDigitalism and fCustomFontScale*3 or 15 ) );
			
		--Animation.createAndPlay( txtCombo, Animation.presets.dxTextFadeIn( 300 ) );
		iMyCombo = iCombo;
	end
);


function drift( fAngle, fSpeed, sSide, iDriftTime )
	local dim = getElementDimension( localPlayer )
	if dim>0 and lobbys and lobbys[dim]["type"] == "dr" then
		local iNewScore = math.ceil( iDriftScore + (fAngle/25) * (fSpeed/15) );
		if not bJustFinished then
			txtScore: text( tostring( iNewScore ) );
			txtScore: visible( true );
			--txtScoreTitle: visible( true );
			local r,g,b = txtScore: color( 255, 165, 0 );
			txtScore: color( r, g, b, 255 );
		end
		iDriftScore = iNewScore;
	end
end

function centreScore( )
	txtScore: position( screenSize[ 1 ] / 2, screenSize[ 2 ] / 4, false )
	--txtScoreTitle: position( screenSize[ 1 ] / 2, screenSize[ 2 ] / 5.6, false );
end

function changeFinishedState( )
	bJustFinished = false;
	if iDriftScore == 0 then
		txtScore: scale(1.5)
		txtScore: visible( false );
		txtScore: color(255, 165, 0 )
		--txtScoreTitle: visible( false );
	else
		txtScore: text( tostring( iDriftScore ) );
	end
end

addEvent( "drSpawned", true )
addEventHandler( "drSpawned", resourceRoot,
function ( veh )
	for k,v in ipairs(getElementsByType( "vehicle" )) do
		setElementCollidableWith( veh, v, false )
	end
end )

local memeRI90s = playSound3D( "http://66.90.93.122/ost/initial-d-d-selection-1/ihoesqnsur/09-running-in-the-90-s.mp3", -1503.7679443359,-387.15612792969,6.4402613639832, true )
setElementDimension( memeRI90s, 6 )
setSoundMaxDistance( memeRI90s, 2000 )