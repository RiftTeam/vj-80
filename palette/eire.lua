-- was: palette index 13

local palette = {}

return {
	id="eire",
	boot=function()
		palette = makePalette3(0x00,0x9a,0x44,255,255,255,0xff,0x82,0x00)
	end,
	get=function()
		return palette
	end,
}
