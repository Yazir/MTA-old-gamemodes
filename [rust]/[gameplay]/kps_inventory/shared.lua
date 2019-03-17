-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local itemTable = {}
itemTable["ak"] = {
key="ak", type="weapon", ammoType="rifleammo", wid=30,max=1,qual=1000,
name="Assault Rifle",
desc="The Assault Rifle is an Ak-47 made from scrap metal, old parts and a shovel handle.",
img="images/ak.png",}

itemTable["stone"] = {
key="stone", type="resource", max=1000, qual=false,
name="Stones",
desc="Stone is a valuable resource used to upgrade houses or craft primitive gear",
img="images/stone.png",}

itemTable["wood"] = {
key="wood", type="resource", max=1000, qual=false,
name="Wood",
desc="Wood is elementary to any craft.",
img="images/wood.png",}

itemTable["colt"] = {
key="colt", type="weapon", ammoType="pistolammo", wid=22,max=1,qual=1000,
name="Semi-Automatic Pistol",
desc="Desc.",
img="images/colt.png",}

itemTable["cuntgun"] = {
key="cuntgun", type="weapon", ammoType="rifleammo", wid=33,max=1,qual=1000,
name="Semi-Automatic Rifle",
desc="Desc.",
img="images/cuntgun.png",}

itemTable["m4"] = {
key="m4", type="weapon", ammoType="rifleammo", wid=31,max=1,qual=1000,
name="LR-300 Assault Rifle",
desc="Desc.",
img="images/m4.png",}

itemTable["mp5"] = {
key="mp5", type="weapon", ammoType="pistolammo", wid=29,max=1,qual=1000,
name="MP5A4",
desc="Desc.",
img="images/mp5.png",}

itemTable["sniper"] = {
key="sniper", type="weapon", ammoType="rifleammo", wid=34,max=1,qual=1000,
name="Bolt-Action Rifle",
desc="Desc.",
img="images/sniper.png",}

itemTable["pistolammo"] = {
key="pistolammo", type="ammo", max=64,
name="Pistol Bullet",
desc="Ammo for pistols.",
img="images/pistolammo.png",}

itemTable["rifleammo"] = {
key="rifleammo", type="ammo",max=64,
name="5.56 Rifle Ammo",
desc="Ammo for rifles.",
img="images/rifleammo.png",}

itemTable["shotgunammo"] = {
key="shotgunammo", type="ammo",max=64,
name="12 Gauge Buckshot",
desc="Ammo for shotguns.",
img="images/shotgunammo.png",}

function getItemTable()
	return itemTable
end

function getItem( id )
	local item = itemTable[id]
	if item then return item
	else return false end
end