-- was: palette index 3

local palette = {}

return {
	id="blue_grey_sine",
	boot=function()
		for i=0,47 do
			palette[i]=sin(i/15)*255
		end
	end,
	get=function(y, t)
		return palette
	end,
}
