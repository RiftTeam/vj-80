-- was: palette index 11

local palette = {}

return {
	id="ukr",
	boot=function()
		palette = makePalette3(0,0,0,0x00,0x5b,0xbb,0xff,0xd5,0x00)
	end,
	get=function()
		return palette
	end,
}
