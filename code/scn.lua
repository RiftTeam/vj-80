Scn={}

function Scn:new(pal)
	local yLines={}
	for i=0,135 do
		yLines[i] = {
			rgbs={}
		}
	end

	local o = {
		pal=pal,
		yLines=yLines,
		lerpPal=1,	-- 1 (current) -> 0 (old)
		-- This could be improved...
		oldPal=pal,
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

function Scn:setPalette(pal)
	-- If lerp is not 1 then make a temporary palette to migrate from
	self.oldPal = self.pal
	self.pal = pal
	self.lerpPal = 0
end

function Scn:update(t)
	local lerp, invLerp = self.lerpPal, 1-self.lerpPal
	for y=0,135 do
		local oldRgbs = self.oldPal.get(y, t)
		local newRgbs = self.pal.get(y, t)
		local rgbs = {}
		for ci = 0,47 do
			rgbs[ci] = lerp * newRgbs[ci] + invLerp * oldRgbs[ci]
		end

		self.yLines[y] = {rgbs=rgbs}
	end
	self.lerpPal = min(self.lerpPal + 0.05, 1)
end

function Scn:get(y)
	return self.yLines[y]
end

