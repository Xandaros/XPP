-- Main table
XPP = {}

-- Network strings
util.AddNetworkString("xandaros_prop_protection_changefriend")

-- Net messages
net.Receive("xandaros_prop_protection_changefriend", function(len, ply)
	local uid = net.ReadUInt(32)
	local value = net.ReadBit() ~= 0
	print(uid .. " " .. tostring(value))
end)
