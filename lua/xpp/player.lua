XPPPlayer = Class("XPPPlayer")

function XPPPlayer:constructor(uid)
	self.friends = {}
	self.uid = uid
end

function XPPPlayer:addFriend(uid)
	self.friends[uid] = true
end

function XPPPlayer:removeFriend(uid)
	self.friends[uid] = nil
end

function XPPPlayer:isFriend(uid)
	return self.friends[uid] ~= nil
end
