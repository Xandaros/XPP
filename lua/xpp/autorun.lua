-- Includes
include('class.lua')
include('player.lua')
include('prop.lua')

-- Main table
XPP = {
	players = {},
	steamIDToPlayer = {},
	props = {}
}

-- Network strings
util.AddNetworkString("xandaros_prop_protection_changefriend")

-- Net messages
net.Receive("xandaros_prop_protection_changefriend", function(len, ply)
	local steamid = net.ReadString()
	local value = net.ReadBit() ~= 0
	local players = XPP.players
	print(steamid, tostring(value))
	if value then
		players[ply]:addFriend(steamid)
	else
		players[ply]:removeFriend(steamid)
	end
end)

-- Register props
do
	local cleanupAdd = cleanup.Add
	function cleanup.Add(ply, typ, ent)
		if not XPP.props[ent] and IsValid(ent) then
			local prop = Prop(ent:EntIndex(), ply:SteamID())
			XPP.props[ent] = prop
		end
		cleanupAdd(ply, typ, ent)
	end

	local plymeta = FindMetaTable("Player")
	local addCount = plymeta.AddCount
	function plymeta:AddCount(enttype, ent)
		if not XPP.props[ent] and IsValid(ent) then
			local prop = Prop(ent:EntIndex(), self:SteamID())
			XPP.props[ent] = prop
		end
		addCount(self, enttype, ent)
	end
end

-- Actual protection
hook.Add("PhysgunPickup", "xandaros_prop_protection", function(ply, ent)
	local prop = XPP.props[ent]
	if not prop then return false end

	local owner = prop:getOwner()
	local steamid = ply:SteamID()
	if steamid == owner then return end
	if not owner then return false end
	local ownerply = XPP.players[XPP.steamIDToPlayer[owner]]

	local player = XPP.players[ply]
	if player and ownerply:isFriend(ply:SteamID()) then return end
	return false
end)

hook.Add("PlayerAuthed", "xandaros_prop_protection", function(ply, steamid, uid)
	XPP.players[ply] = XPPPlayer(steamid, ply)
	XPP.steamIDToPlayer[steamid] = ply
end)
