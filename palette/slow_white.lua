-- was: palette index 9

local palette = {}

return {
	id="slow_white",
	boot=function()
	end,
	get=function(y, t)
		local it=t
		local ta=96*(sin(it/10)+1)
		local tb=96*(sin(it/10+tau/3)+1)
		local tc=96*(sin(it/10+tau*4/3)+1)
		local rgbs = {}
		for i=0,7 do
			rgbs[i*3] = (i/7*(ta))
			rgbs[i*3+1] = (i/7*(tb))
			rgbs[i*3+2] = (i/7*(tc))
		end
		for i=8,15 do
			rgbs[i*3] = min(255,(15-i)/7*ta + (i-7)/8*255)
			rgbs[i*3+1] = min(255,(15-i)/7*tb + (i-7)/8*255)
			rgbs[i*3+2] = min(255,(15-i)/7*tc + (i-7)/8*255)
		end
		return rgbs
	end,
}
