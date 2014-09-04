-- Main table
XPP = {
	players = {}
}

-- Network strings
util.AddNetworkString("xandaros_prop_protection_changefriend")

-- Net messages
net.Receive("xandaros_prop_protection_changefriend", function(len, ply)
	local uid = net.ReadUInt(32)
	local value = net.ReadBit() ~= 0
	if not players[ply] then players[ply] = Player() end
	if value then
		players[ply]:addFriend(uid)
	else
		players[ply]:removeFriend(uid)
	end
end)
