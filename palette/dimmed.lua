-- was: palette index 7

local palette = {}

return {
	id="dimmed",
	boot=function()
	end,
	get=function(y, t)
		local it=t
		local rgbs = {}
		for i=0,15 do
			rgbs[i*3] = clamp(i*(8+8*(sin(tau/6*5+it+y/100))), 0, 255)
			rgbs[i*3+1] = clamp(i*(8+8*(sin(it+y/100))), 0, 255)
			rgbs[i*3+2] = clamp(i*(8+8*(cos(it+y/100))), 0, 255)
		end
		return rgbs
	end,
}
