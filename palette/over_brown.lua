-- was: palette index 1

local palette = {}

return {
	id="over_brown",
	boot=function()
		for i=0,15 do
			palette[i*3]=min(255,20+i*32)
			palette[i*3+1]=min(255,10+i*24)
			palette[i*3+2]=i*17
		end
	end,
	get=function()
		return palette
	end,
}