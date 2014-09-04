-- Includes
include('class.lua')
include('player.lua')
include('prop.lua')

-- Main table
XPP = {
	players = {},
	props = {}
}

-- Network strings
util.AddNetworkString("xandaros_prop_protection_changefriend")

-- Net messages
net.Receive("xandaros_prop_protection_changefriend", function(len, ply)
	local uid = net.ReadUInt(32)
	local value = net.ReadBit() ~= 0
	if not players[ply] then players[ply] = XPPPlayer() end
	if value then
		players[ply]:addFriend(uid)
	else
		players[ply]:removeFriend(uid)
	end
end)

-- Register props
do
	local cleanupAdd = cleanup.Add
	function cleanup.Add(ply, typ, ent)
		if not XPP.props[ent] and IsValid(ent) then
			local prop = Prop(ent:EntIndex(), ply:UniqueID())
			XPP.props[ent] = prop
		end
		cleanupAdd(ply, typ, ent)
	end

	local plymeta = FindMetaTable("Player")
	local addCount = plymeta.AddCount
	function plymeta:AddCount(enttype, ent)
		if not XPP.props[ent] and IsValid(ent) then
			local prop = Prop(ent:EntIndex(), self:UniqueID())
			XPP.props[ent] = prop
		end
		addCount(self, enttype, ent)
	end
end

-- Actual protection
hook.Add("PhysgunPickup", "xandaros_prop_protection", function(ply, ent)
	local prop = XPP.props[ent]
	if not prop then print("Not prop") return false end

	local owner = prop:getOwner()
	local uid = ply:UniqueID()
	if uid == owner then print("owner") return end
	print(uid)
	print(owner)
	local player = XPP.players[ply]
	if player and player:isFriend(uid) then return true end
	return false
end)

hook.Add("PlayerInitialSpawn", "xandaros_prop_protection", function(ply)
	XPP.players[ply] = XPPPlayer(ply:UniqueID())
end)
