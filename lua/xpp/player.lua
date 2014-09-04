Player = Class("Player")

function Player:constructor()
	self.friends = {}
end

function Player:addFriend(uid)
	self.friends[uid] = true
end

function Player:removeFriend(uid)
	self.friends[uid] = nil
end

function Player:isFriend(uid)
	return self.friends[uid] ~= nil
end
