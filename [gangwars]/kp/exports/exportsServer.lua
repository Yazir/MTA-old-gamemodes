attachElementToBone = function ( element,ped,bone,x,y,z,rx,ry,rz ) return call( getResourceFromName( "bone_attach" ), "attachElementToBone", element,ped,bone,x,y,z,rx,ry,rz ) end
detachElementFromBone = function ( element ) return call( getResourceFromName( "bone_attach" ), "detachElementFromBone", element) end
isElementAttachedToBone = function ( element ) return call( getResourceFromName( "bone_attach" ), "isElementAttachedToBone", element) end
getElementBoneAttachmentDetails = function ( element ) return call( getResourceFromName( "bone_attach" ), "getElementBoneAttachmentDetails", element) end
setElementBonePositionOffset = function ( element,x,y,z ) return call( getResourceFromName( "bone_attach" ), "setElementBonePositionOffset", element,x,y,z) end
setElementBoneRotationOffset = function ( element,rx,ry,rz ) return call( getResourceFromName( "bone_attach" ), "setElementBonePositionOffset", element,rx,ry,rz) end

--[[
attachElementToBone(element,ped,bone,x,y,z,rx,ry,rz) : attaches element to the bone of the ped. Server and client function.
element : Element which you want to attach.
ped : Ped or player which you want to attach element to.
bone : Bone which you want to attach element to.
x,y,z : Position offset from the bone.
rx,ry,rz : Rotation offset from the bone.
Returns true if element was successfully attached, false otherwise.

detachElementFromBone(element) : detaches element from the bone of the ped. Server and client function.
element : Element which you want to detach.
Returns true if element was successfully detached, false otherwise.

isElementAttachedToBone(element) : checks if element is attached to a bone. Server and client function.
element : Element which you want to check.
Returns true if element is attached to a bone, false otherwise.

getElementBoneAttachmentDetails(element) : gets ped, bone and offset of attached element. Server and client function.
element : Element which you want to get attachment details of.
Returns ped,bone,x,y,z,rx,ry,rz used in attachElementToBone if element is attached, false otherwise.

setElementBonePositionOffset(element,x,y,z) : changes position offset of attached element. Server and client function.
element : Element which you want to change offset of.
x,y,z : New position offset.
Returns true if position set successfully, false otherwise.

setElementBoneRotationOffset(element,rx,ry,rz) : changes rotation offset of attached element. Server and client function.
element : Element which you want to change offset of.
rx,ry,rz : New rotation offset.
Returns true if rotation set successfully, false otherwise.

getBonePositionAndRotation(ped,bone) : gets position and rotation of the ped bone. Client-only function.
Returns bone x,y,z position and rotation if ped is streamed in and bone number is valid, false otherwise.

Bone IDs:
1: head
2: neck
3: spine
4: pelvis
5: left clavicle
6: right clavicle
7: left shoulder
8: right shoulder
9: left elbow
10: right elbow
11: left hand
12: right hand
13: left hip
14: right hip
15: left knee
16: right knee
17: left ankle
18: right ankle
19: left foot
20: right foot
]]

function spawnBot(x,y,z,rot,skinID,interior,dim,theTeam,weapon,theMode,theModeSubject) return call(getResourceFromName( "slothbot" ), "spawnBot", x,y,z,rot,skinID,interior,dim,theTeam,weapon,theMode,theModeSubject) end
function setBotHunt(theBot) return call(getResourceFromName( "slothbot" ), "setBotHunt",theBot ) end
function setBotWait(theBot) return call(getResourceFromName( "slothbot" ), "setBotWait",theBot ) end
function setBotChase(theBot,theTarget) return call(getResourceFromName( "slothbot" ), "setBotChase",theBot,theTarget ) end
function setBotFollow(theBot,theTarget) return call(getResourceFromName( "slothbot" ), "setBotFollow",theBot,theTarget ) end
function setBotGuard(theBot,x,y,z) return call(getResourceFromName( "slothbot" ), "setBotGuard",theBot,x,y,z ) end
function getBotTeam(theBot) return call(getResourceFromName( "slothbot" ), "getBotTeam",theBot ) end
function setBotTeam(theBot,theTeam) return call(getResourceFromName( "slothbot" ), "setBotTeam",theBot,theTeam ) end
function getBotAttackEnabled(theBot) return call(getResourceFromName( "slothbot" ), "getBotAttackEnabled",theBot ) end
function setBotAttackEnabled(theBot,enabled) return call(getResourceFromName( "slothbot" ), "setBotAttackEnabled",theBot,enabled ) end
function getBotMode(theBot) return call(getResourceFromName( "slothbot" ), "getBotMode",theBot ) end
function isPedBot(theBot) return call(getResourceFromName( "slothbot" ), "isPedBot",theBot ) end
function setBotWeapon(theBot,weapon) return call(getResourceFromName( "slothbot" ), "setBotWeapon",theBot,weapon ) end