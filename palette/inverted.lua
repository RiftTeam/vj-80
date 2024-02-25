-- was: palette index 10

local palette = {}

return {
	id="inverted",
	boot=function()
	end,
	get=function(y, t)
		local it=t/8

		local grader=sin(it*1/7+y/150)+1
		local gradeg=sin(it*1/13+y/150)+1
		local gradeb=sin(it*1/11+y/150)+1
		local rgbs={}
		for i=0,15 do
			rgbs[i*3] = 255-(8+4*grader)*i
			rgbs[i*3+1] = max(0,min(255,255-(8+4*gradeg)*i))
			rgbs[i*3+2] = max(0,min(255,255-(8+4*gradeb)*i))
		end
		return rgbs
	end,
}
