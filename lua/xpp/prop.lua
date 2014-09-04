Prop = Class("Prop")

function Prop:constructor(entid, owner)
	self.entid = entid
	self.owner = owner
end

function Prop:setOwner(owner)
	self.owner = owner
end

function Prop:getOwner()
	return self.owner
end
