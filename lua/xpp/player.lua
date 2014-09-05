XPPPlayer = Class("XPPPlayer")

function XPPPlayer:constructor(steamid, entity)
	self.friends = {}
	self.steamid = steamid
	self.entity = entity
end

function XPPPlayer:addFriend(steamid)
	self.friends[steamid] = true
end

function XPPPlayer:removeFriend(steamid)
	self.friends[steamid] = nil
end

function XPPPlayer:isFriend(steamid)
	return self.friends[steamid] ~= nil
end

function XPPPlayer:getEntity()
	if not self.entity then
		for k, v in pairs(player.GetAll()) do
			if v:SteamID() == self.steamid then
				self.entity = v
				break
			end
		end
	end
	return self.entity
end
