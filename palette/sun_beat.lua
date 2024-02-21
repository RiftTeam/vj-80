-- was: palette index ??

local palette = {}

return {
	id="sun_beat",
	boot=function()
		for i=0,15 do
			palette[i*3]=clamp(i*32,0,255)
			palette[i*3+1]=clamp(i*24-128,0,255)
			palette[i*3+2]=clamp(i*24-256,0,255)
		end
	end,
	get=function(y, t)
		return palette
	end,
}