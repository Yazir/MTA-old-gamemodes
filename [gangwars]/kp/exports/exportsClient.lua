attachElementToBone = function ( element,ped,bone,x,y,z,rx,ry,rz ) return call( getResourceFromName( "bone_attach" ), "attachElementToBone", element,ped,bone,x,y,z,rx,ry,rz ) end
detachElementFromBone = function ( element ) return call( getResourceFromName( "bone_attach" ), "detachElementFromBone", element) end
isElementAttachedToBone = function ( element ) return call( getResourceFromName( "bone_attach" ), "isElementAttachedToBone", element) end
getElementBoneAttachmentDetails = function ( element ) return call( getResourceFromName( "bone_attach" ), "getElementBoneAttachmentDetails", element) end
setElementBonePositionOffset = function ( element,x,y,z ) return call( getResourceFromName( "bone_attach" ), "setElementBonePositionOffset", element,x,y,z) end
setElementBoneRotationOffset = function ( element,rx,ry,rz ) return call( getResourceFromName( "bone_attach" ), "setElementBonePositionOffset", element,rx,ry,rz) end

getBonePositionAndRotation = function ( ped,bone ) return call( getResourceFromName( "bone_attach" ), "getBonePositionAndRotation", ped,bone) end