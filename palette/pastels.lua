-- was: palette index ?

local palette = {}

return {
	id="pastels",
	boot=function()
	end,
	get=function(y, t)
		local it=t/8
		local rgbs = {}
		for i=0,47 do
			rgbs[i]=(sin(it/8*sin(i//3)+(i%3)))*99
		end
		return rgbs
	end,
}
