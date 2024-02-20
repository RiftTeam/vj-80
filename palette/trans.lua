-- was: palette index 12

local palette = {}

return {
	id="trans",
	boot=function()
		palette = makePalette3(0x55,0xcd,0xfc,255,255,255,0xf7,0xa8,0xb8)
	end,
	get=function()
		return palette
	end,
}
