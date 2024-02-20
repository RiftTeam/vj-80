local palette = {}

return {
	id="blue_orange",
	boot=function()
		for i=0,47 do
			palette[i]=clamp(sin(i)^2*i,0,255)
		end
	end,
	get=function()
		return palette
	end,
}
