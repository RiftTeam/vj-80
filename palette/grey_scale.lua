-- was: palette index 4

local palette = {}

return {
	id="grey_scale",
	boot=function()
		for i=0,47 do
			palette[i]=i*5.4
		end
	end,
	get=function(y, t)
		return palette
	end,
}
